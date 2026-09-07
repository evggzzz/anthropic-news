You are a helpful assistant executing a fully autonomous Anthropic digest pipeline using Task agents.

# CRITICAL EXECUTION RULES - READ FIRST

**ABSOLUTE REQUIREMENTS:**
1. **NEVER STOP** for user confirmation, questions, or input at any point
2. **NEVER USE AskUserQuestion** tool during this pipeline
3. **AUTOMATICALLY PROCEED** to the next step immediately after each step completes
4. **LOG ERRORS AND CONTINUE** - if any step fails, record the error and move to the next step
5. **RUN TO COMPLETION** - only the final completion report should be shown to the user

**IF YOU FEEL LIKE STOPPING:** DO NOT STOP. Continue to the next step immediately.

# Arguments

The user invoked this command with the following arguments (may be empty):

$ARGUMENTS

Parse them:
- **Argument 1** (optional): TARGET_DATE in `YYYY-MM-DD` format. If omitted, use today.
- **Argument 2** (optional): DAYS - lookback window in days (integer >= 1). If omitted, use 7.
  - Weekly operation: DAYS=7. Daily operation: DAYS=1.
- If an argument is malformed, do NOT stop - log a warning and fall back to the default (today / 7).

# Setup (Do Once at Start)

Compute the pipeline dates with bash (macOS `date` is BSD; GNU fallback included). OFFSET = DAYS - 1.

```bash
if [ -z "<TARGET_DATE_ARG>" ]; then TARGET_DATE=$(date +%Y-%m-%d); else TARGET_DATE=<TARGET_DATE_ARG>; fi
OFFSET=$(( <DAYS> - 1 ))
PERIOD_START=$(date -j -f "%Y-%m-%d" -v-${OFFSET}d "$TARGET_DATE" +%Y-%m-%d 2>/dev/null || date -d "$TARGET_DATE ${OFFSET} days ago" +%Y-%m-%d)
echo "TARGET_DATE=$TARGET_DATE PERIOD_START=$PERIOD_START DAYS=<DAYS>"
```

Also compute the compact date and Japanese-formatted date for $TARGET_DATE:

```bash
date -j -f "%Y-%m-%d" "$TARGET_DATE" +%Y%m%d 2>/dev/null || date -d "$TARGET_DATE" +%Y%m%d
date -j -f "%Y-%m-%d" "$TARGET_DATE" +"%Y年%m月%d日" 2>/dev/null || date -d "$TARGET_DATE" +"%Y年%m月%d日"
```

Store these four values and use them for ALL subsequent steps. Do NOT run `date` again.

- TARGET_DATE (YYYY-MM-DD) - run anchor; resources dir and article filename use this
- PERIOD_START (YYYY-MM-DD) - collection window start (inclusive)
- TARGET_DATE_COMPACT (YYYYMMDD)
- TARGET_DATE_JP (YYYY年M月D日)

# Invocation Block

When launching every digest task and the article-generation task in the steps below, append this block to the end of the skill prompt (fill in the computed values):

```
--- INVOCATION ---
TARGET_DATE: <TARGET_DATE>
PERIOD_START: <PERIOD_START>
DAYS: <DAYS>
PERIOD: <PERIOD_START> .. <TARGET_DATE> (inclusive)
---
```

# Pipeline Execution Steps

## STEP 1: Execute Digest Tasks in PARALLEL

Use the Task tool to launch ALL 8 digest tasks simultaneously with `run_in_background=true`.

**IMPORTANT:** Send a SINGLE message with ALL 8 Task tool calls to run them in parallel.

For each task: Read the skill file from `.claude/skills/`, use its content as the prompt, and append the Invocation Block. Use subagent_type "general-purpose" and run_in_background true.

Launch these tasks in parallel:

1. **anthropic_news_digest** - skill: `.claude/skills/anthropic_news_digest.md` → output `resources/[TARGET_DATE]/news.md`
2. **anthropic_engineering_digest** - skill: `.claude/skills/anthropic_engineering_digest.md` → output `resources/[TARGET_DATE]/engineering.md`
3. **anthropic_research_digest** - skill: `.claude/skills/anthropic_research_digest.md` → output `resources/[TARGET_DATE]/research.md`
4. **platform_release_notes_digest** - skill: `.claude/skills/platform_release_notes_digest.md` → output `resources/[TARGET_DATE]/platform_releases.md`
5. **claude_apps_release_notes_digest** - skill: `.claude/skills/claude_apps_release_notes_digest.md` → output `resources/[TARGET_DATE]/apps_releases.md`
6. **claude_code_changelog_digest** - skill: `.claude/skills/claude_code_changelog_digest.md` → output `resources/[TARGET_DATE]/claude_code.md`
7. **agent_sdk_changelog_digest** - skill: `.claude/skills/agent_sdk_changelog_digest.md` → output `resources/[TARGET_DATE]/agent_sdk.md`
8. **status_incidents_digest** - skill: `.claude/skills/status_incidents_digest.md` → output `resources/[TARGET_DATE]/status_incidents.md`

## STEP 2: Collect Results from All Tasks

Use TaskOutput to collect results from each background task:

```
For each task_id from Step 1:
  - TaskOutput(task_id, block=true)
  - Parse the STATUS from the output
  - Record success/failure
```

Track results:
- SUCCESS: [list of succeeded tasks with file paths]
- FAILED: [list of failed tasks with brief error]

**Error Handling:** If a task fails, log "FAILED: [task name] - [error]" and continue collecting other results. A task that succeeded but found no updates (STATUS: SUCCESS with zero items) is a SUCCESS.

**AFTER ALL 8 RESULTS COLLECTED → IMMEDIATELY GO TO STEP 3**

## STEP 3: Generate Final Article

Use the Task tool to run the article generation:

```
Task(
  subagent_type: "general-purpose",
  prompt: [content of .claude/skills/generate_digest_article.md] + Invocation Block,
  run_in_background: false
)
```

This reads all files from `resources/[TARGET_DATE]/` and creates `articles/anthropic_[TARGET_DATE_COMPACT].md`, then runs textlint.

**AFTER COMPLETION → IMMEDIATELY GO TO STEP 4**

## STEP 4: Guardrail Review

Use the Task tool to run the guardrail review:

```
Task(
  subagent_type: "general-purpose",
  prompt: [content of .claude/skills/article_guardrail_review.md] + Invocation Block,
  run_in_background: false
)
```

If issues found (NEEDS REVISION): fix them directly, then re-run the review (max 2 re-review loops). If BLOCKED: fix, re-run once, and if still blocked, keep the article but flag it clearly in the final report and set `published: false` in the article frontmatter. If approved: continue.

**AFTER REVIEW → IMMEDIATELY GO TO STEP 5**

## STEP 5: Commit and Push

Execute these git commands in sequence:

```bash
git add resources/[TARGET_DATE]/ articles/ state/
git commit -m "Add Anthropic digest for [TARGET_DATE]

🤖 Generated with Claude Code
Co-Authored-By: Claude Code <noreply@anthropic.com>"
git push origin main
```

If there is nothing to commit (no changes), skip commit and note it in the final report.

**AFTER PUSH COMPLETES (or skip) → GO TO FINAL REPORT**

# FINAL REPORT

Only after ALL steps complete, output a single summary:

```
# Anthropic Digest Pipeline Complete

**Target date:** [TARGET_DATE]  **Period:** [PERIOD_START] .. [TARGET_DATE] ([DAYS] days)

## Execution Summary
- Digest Tasks: X/8 succeeded (parallel execution)
- Article Generated: Yes/No
- Guardrail Review: APPROVED / NEEDS REVISION (fixed) / BLOCKED
- textlint: clean / N remaining issues
- Git Commit & Push: Success / Skipped (no changes) / Failed

## Task Results
| Task | Status | Output File |
|------|--------|-------------|
| anthropic_news_digest | ✓/✗ | news.md |
| anthropic_engineering_digest | ✓/✗ | engineering.md |
| anthropic_research_digest | ✓/✗ | research.md |
| platform_release_notes_digest | ✓/✗ | platform_releases.md |
| claude_apps_release_notes_digest | ✓/✗ | apps_releases.md |
| claude_code_changelog_digest | ✓/✗ | claude_code.md |
| agent_sdk_changelog_digest | ✓/✗ | agent_sdk.md |
| status_incidents_digest | ✓/✗ | status_incidents.md |

## Failed Steps (if any)
- [List any failures with brief description]

## Output Files
- resources/[TARGET_DATE]/[list files]
- articles/anthropic_[TARGET_DATE_COMPACT].md
```

# REMINDER: DO NOT STOP UNTIL YOU REACH THE FINAL REPORT
