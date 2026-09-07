You are a helpful assistant. Your task is to generate the final Anthropic digest article from collected data.

**Date Setup:**
The orchestrator appends an `--- INVOCATION ---` block with TARGET_DATE, PERIOD_START, DAYS, PERIOD. Use those values as-is and do NOT run `date` commands. If the block is absent, use today as TARGET_DATE with DAYS=7 and PERIOD_START = 6 days before TARGET_DATE.

Derive: TARGET_DATE_COMPACT (YYYYMMDD) and TARGET_DATE_JP (YYYY年M月D日) from TARGET_DATE. All article filenames use TARGET_DATE (not today) so backfill runs work.

**Article Generation Steps:**

1. **Collect All Generated Reports**
   - Scan the `resources/[TARGET_DATE]/` directory
   - Identify all generated report files:
     - `news.md`
     - `platform_releases.md`
     - `apps_releases.md`
     - `claude_code.md`
     - `agent_sdk.md`
     - `engineering.md`
     - `research.md`
     - `status_incidents.md`
   - Check which files exist and read their contents

2. **Process Available Data**
   - Only include sections for which data files exist AND contain meaningful content
   - If an expected file is missing, skip that section gracefully
   - **CRITICAL**: If a data file contains only "対象エントリなし" / "対象バージョンなし" / "対象ポストなし" / "対象インシデントなし" (no in-period items), exclude that entire section from the final article
   - Log which data sources were found and which were missing or empty

3. **Generate Final Article**
   - Create a Zenn-compatible article that combines all available information
   - **Content Filtering Rules:**
     - **News**: All in-period official announcements; give model launches and product changes the most depth
     - **Platform Release Notes**: Model/API launches, GA promotions, new beta features, breaking changes, SDK releases, Console features. Flag 破壊的変更 clearly — for API users these are the highest-value items
     - **Claude Apps Release Notes**: User-facing features (claude.ai, Cowork, memory, enterprise admin)
     - **Claude Code**: New commands, settings, notable features, behavior changes. Placeholder releases (bugfix-only) get at most a one-line mention
     - **Agent SDK**: New capabilities and breaking changes per language; trivial patch bumps get one line
     - **Engineering / Research**: Full explanatory treatment per post
     - **Status Incidents**: Only meaningful incidents (multi-component outages, extended degradation). Skip noise-level blips unless the period was quiet and they add signal
     - **DEPTH (common rule)**: For each noteworthy item, DON'T just summarize — **explain**. A summary states the fact ("Claude Fable 5.1 was released"); an explanation tells the reader **why it matters, how it works, and what changes for them**. Write 3-6 sentences per noteworthy item as a paragraph: **context/background → what it is → why it matters → what changes for developers**. Include model IDs, pricing, beta header strings, command names, and doc URLs where relevant. A reader who didn't follow the week should **understand** it after reading, not just be informed it happened. NOT a bullet-only list — flowing explanatory prose.
   - **Link Requirements:**
     - **CRITICAL**: Always use the EXACT URLs from the source files (news.md, platform_releases.md, etc.)
     - **NEVER generate, modify, or create placeholder URLs** - only use URLs that actually exist in the resource files
     - **MANDATORY**: Include ALL relevant URLs exactly as they are written in the source files
     - If a URL doesn't exist in the source file, do not include a link
   - Zenn: Since Zenn uses the title from frontmatter, do not include h1 (#) in the article body
   - Start the article body directly with the introduction paragraph

4. **Create and Save Article**
   - Save to `articles/anthropic_[TARGET_DATE_COMPACT].md`
   - **CRITICAL**: Strictly follow the section order below:
     1. 📰 News（Anthropic発表）
     2. 🧩 Platform リリースノート（API・SDK・Console）
     3. 💬 Claude Apps リリースノート（Claude.ai・Cowork等）
     4. ⌨️ Claude Code
     5. 🤖 Agent SDK
     6. 🔧 Engineering ブログ
     7. 🔬 Research
     8. 🚨 障害・ステータス（only if meaningful incidents exist）
     9. 📝 まとめ
   - **Introduction vs まとめ Differentiation Rules:**
     - **Introduction**: State the collection period (対象期間) clearly, then frame the period with an editorial lens — the dominant theme across the sources (e.g. a model launch echoing through News, platform notes, and Apps notes) and what to watch next. Connect items into a narrative, not a category list.
     - **まとめ**: A very concise summary (280 characters or less in Japanese) focusing on the single most important development of the period.
   - Use the following format:
    ```markdown
    ---
    title: "Anthropic更新ダイジェスト - [TARGET_DATE_JP]"
    emoji: "🤖"
    type: "tech"
    topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
    published: true
    ---

    [Introduction paragraph - 対象期間（PERIOD_START〜TARGET_DATE）を明示し、その期間を貫くテーマを編集者の視点で]

    ## 📰 News（Anthropic発表）
    [Content from news.md - filtered]

    ## 🧩 Platform リリースノート（API・SDK・Console）
    [Content from platform_releases.md - breaking changes flagged, model IDs/pricing verbatim]

    ## 💬 Claude Apps リリースノート（Claude.ai・Cowork等）
    [Content from apps_releases.md]

    ## ⌨️ Claude Code
    [Content from claude_code.md - placeholder releases at most one line]

    ## 🤖 Agent SDK
    [Content from agent_sdk.md]

    ## 🔧 Engineering ブログ
    [Content from engineering.md]

    ## 🔬 Research
    [Content from research.md]

    ## 🚨 障害・ステータス
    [Content from status_incidents.md - ONLY if meaningful incidents exist]

    ## 📝 まとめ
    [280文字以内。その期間で最も重要な変化1点に絞る]

    ## Anthropic更新ダイジェストについて
    この記事は以下リポジトリのパイプラインで生成されています。
    追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

    https://github.com/evggzzz/anthropic-news
    ```

5. **Run textlint Quality Check**
   - After generating the article, run:
     ```bash
     npx textlint --fix articles/anthropic_[TARGET_DATE_COMPACT].md
     ```
   - Generate a detailed report and save it to the resources directory:
     ```bash
     npx textlint articles/anthropic_[TARGET_DATE_COMPACT].md --format json > resources/[TARGET_DATE]/textlint-report.json
     ```
   - **CRITICAL (privacy)**: the JSON report contains absolute local paths. Strip them — the repo is public:
     ```bash
     sed -i '' "s|$(pwd)/||g" resources/[TARGET_DATE]/textlint-report.json
     ```
   - **IMPORTANT**: This step is non-blocking - continue even if textlint finds issues
   - The `--fix` option automatically corrects fixable issues

6. **Error Handling**
   - If no data files are found, generate a minimal article explaining the situation
   - Log any errors encountered during processing
   - Always produce some output, even if data collection was incomplete
   - If textlint fails to run, log the error but continue

**Execution Notes:**
- The article must be in Japanese, formatted for Zenn
- **Writing quality**: If the `japanese-tech-writing` skill is available, follow its norms — one sentence per line, paragraph-level argumentation, no LLM-ish hype or empty verbs, no redundancy. **But prioritize EXPLANATION over brevity**: "no redundancy" means no repetition, NOT "shortest possible". Do NOT strip the explanation that helps the reader understand.
- Include the section emojis as specified
- Gracefully handle missing data sources
- **CRITICAL**: Never include sections whose source file reported no in-period items
- Focus on quality over quantity

**Completion Output:**
When finished, output exactly:
```
STATUS: SUCCESS
FILE: articles/anthropic_[TARGET_DATE_COMPACT].md
SECTIONS_INCLUDED: [list of sections that had content]
SECTIONS_SKIPPED: [list of sections that were empty or missing]
```
Or if failed:
```
STATUS: FAILED
ERROR: [error description]
```
