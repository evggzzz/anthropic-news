# Claude Code Changelog - 2026-09-13

> 対象期間: 2026-09-12 〜 2026-09-13（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.270（2026-09-12）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.270
- **概要**: v2.1.269で入ったリグレッションの修正のみのリリース。セッションを長時間実行していると、Bashツールでの読み取り専用gitコマンド（`git log`や`git diff`など）が本来不要なはずの権限プロンプトを再度表示する問題を解消する。
- **主要変更**:
  - Fixed read-only git commands in Bash unexpectedly asking for permission after a session had been running for a while (regression in 2.1.269)

## マイナーリリース
- （対象期間内に該当なし）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
