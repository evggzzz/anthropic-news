# Claude Agent SDK Changelog - 2026-09-19

> 対象期間: 2026-09-18 〜 2026-09-19（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.277（2026-09-18）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.277
- **概要**: ホストアプリ実装向けの情報追加が中心のリリース。`SlashCommand`への`builtin`フィールド追加、`SDKUserMessage`への`pasted_content`追加、リモートセッションのレイテンシ計測フィールド追加など。あわせて、resume/forkしたセッションのコスト・利用量合計がゼロから始まってしまうバグが修正された。Claude Code v2.1.277とのパリティリリース。
- **主要変更**:
  - Added an optional `builtin` field to `SlashCommand`, set when a command is built into Claude Code
  - Added `pasted_content` to `SDKUserMessage`: text the user pasted rather than typed, appended after the typed prompt
  - Added optional remote-session latency fields (`first_text_post_ms`, `first_text_post_wall_ms`, `first_stream_post_queue_wait_ms`, `first_stream_post_queued_behind`) to the success result message
  - Added `'userSettings'` as an `updateSettings()` source, accepting only `effortLevel`, which is saved for the session's current model as `/effort` saves it
  - Fixed a resumed or forked session's `total_cost_usd`, `modelUsage` and `get_usage` totals starting at zero instead of continuing from the earlier turns (`maxBudgetUsd` is unchanged)
  - Changed `SDKUsageReport` usage rows to always carry `severity` and `is_active`: the report relays only rows from a live server reply, and none while the usage fetch is failing
  - Updated to parity with Claude Code v2.1.277

### v0.3.276（2026-09-18）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.276
- **概要**: Claude Code v2.1.276とのパリティ更新のみ。SDK単独の機能追加・修正はなし。

## Python SDK

### v0.2.156（2026-09-18）
- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.156
- **概要**: バンドル済みClaude CLIを2.1.276へ更新したメンテナンスリリース。SDK API側の変更はなし。

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
