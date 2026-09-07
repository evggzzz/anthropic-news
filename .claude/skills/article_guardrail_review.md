# Article Guardrail Review

Review the generated Anthropic digest article for compliance with content policies and safety guidelines.

**Date Setup:**
The orchestrator appends an `--- INVOCATION ---` block with TARGET_DATE and related values. Use TARGET_DATE as-is. If the block is absent, use today.

## Target File

Review the article at: `articles/anthropic_YYYYMMDD.md` where YYYYMMDD is TARGET_DATE in the compact format.

## Review Checklist

Please carefully review the article at the specified path and check for the following:

### 1. Confidential Information and Personal Information
- [ ] No API keys, tokens, or credentials
- [ ] No private email addresses or personal contact information
- [ ] No personal information of any kind: real names of private individuals, personal account IDs, local file paths, machine-specific paths
- [ ] No internal company information or trade secrets
- [ ] No non-public pricing information

### 2. Security Concerns
- [ ] No exploit code or vulnerability details that could be misused
- [ ] No instructions for bypassing security measures
- [ ] No malicious code examples
- [ ] No links to compromised or suspicious websites

### 3. Inappropriate Content
- [ ] No sexual or adult content
- [ ] No violent or graphic descriptions
- [ ] No hate speech or discriminatory language
- [ ] No harassment or personal attacks

### 4. Political and Religious Neutrality
- [ ] No political bias or partisan content
- [ ] No religious proselytizing or criticism
- [ ] Maintains neutral tone on controversial topics (safety and policy announcements are reported factually, not editorialized)

### 5. Legal and Ethical Compliance
- [ ] No copyright infringement (proper attribution and links for all sources)
- [ ] No plagiarized content (summaries are original wording, facts attributed to Anthropic's official posts)
- [ ] No false or misleading information (claims match what the source files actually say)
- [ ] No hallucinated URLs — every link must appear verbatim in `resources/[TARGET_DATE]/`

### 6. Professional Standards
- [ ] No profanity or offensive language
- [ ] No unverified claims or conspiracy theories
- [ ] No sensationalized or clickbait content
- [ ] Accurate representation of technical concepts (model IDs, version numbers, pricing, beta header strings match the source files)
- [ ] Proper fact-checking of claims and statistics

## Review Process

1. Read the entire article carefully
2. Cross-check a sample of links and technical claims against the files in `resources/[TARGET_DATE]/`
3. Check each item in the checklist above
4. If any issues are found:
   - Note the specific location (line number or section)
   - Describe the issue clearly
   - Suggest appropriate corrections
5. Provide a summary of your review with one of these outcomes:
   - APPROVED: Article is ready for publication
   - NEEDS REVISION: Minor issues found that need correction
   - BLOCKED: Major issues that require significant revision

## Output Format

After reviewing, provide your assessment in this format:

```
## Guardrail Review Results

**Status**: [APPROVED/NEEDS REVISION/BLOCKED]

### Issues Found
1. [Issue description] - Line/Section: [location]
   Suggested fix: [correction]

### Summary
[Brief summary of the review outcome and any recommendations]
```

Remember: The goal is to ensure the content is safe, accurate, and valuable for readers while maintaining the informative nature of the Anthropic digest. This repository is public — anything personal must not appear in the article.

**Completion Output:**
When finished, output exactly:
```
STATUS: [APPROVED/NEEDS_REVISION/BLOCKED]
FILE: articles/anthropic_YYYYMMDD.md
ISSUES_FOUND: [number of issues, or 0 if approved]
```
