# Claude Agent SDK Changelog - 2026-09-16

> 対象期間: 2026-09-15 〜 2026-09-16（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.273（2026-09-15）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.273
- **概要**: アシスタントメッセージにヘッドレス `/usage` の結果を届ける `SDKUsageReport` の追加が目玉。ホスト側フックのタイムアウト扱いと、バックグラウンドタスクのリスタスト通知にも手が入った。Claude Code v2.1.273 とパリティ。
- **主要変更**:
  - Added a `usage_report` sibling (`SDKUsageReport`) on the assistant message delivering a headless `/usage` result — covering session totals, the plan's usage rows, and extra usage
  - Added `reason: "worker_restart"` to task_notification messages for background tasks stopped by a worker process restart
  - Added a single-line transcript notice that appears when the host's Stop or SessionStart hook callback times out
  - Fixed an over-timeout Stop, SubagentStop or SessionStart callback being reported as a hook failure that discarded other hooks' decisions; it now counts as no decision
  - Fixed the browser SSE transport dropping the live slash-command list update (`system/commands_changed`)
  - Updated to parity with Claude Code v2.1.273

### v0.3.272（2026-09-15）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.272
- **概要**: Claude Code v2.1.272 とのパリティ更新のみのパッチリリース。

## Python SDK

### v0.2.153（2026-09-15）
- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.153
- **概要**: システムプロンプトに `snapshot` オプションが追加された。初回リクエスト時点のプロンプトをセッションが保持するため、再開セッションをまたいだプロンプトキャッシングの効率が向上する。利用には CLI 2.1.257 以降が必要。同梱 CLI も 2.1.273 に更新。
- **主要変更**:
  - Added a `snapshot` field to `SystemPromptPreset` and a new `SystemPromptCustom` typed dict — `True` retains the prompt as recorded on its first request (improving prompt-caching behavior across resumed sessions), `False` rebuilds the prompt on each request (useful for iterating on `append` text) (#1268, requires CLI 2.1.257+)
  - Updated bundled Claude CLI to version 2.1.273

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
