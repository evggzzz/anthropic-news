# Claude Agent SDK Changelog - 2026-09-26

> 対象期間: 2026-09-25 〜 2026-09-26（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.283（2026-09-25）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.283
- **概要**: プラグインの読み込み失敗を型レベルで検知できるようになったほか、セッション巻き戻し後の分岐を扱うAPIのバグを修正。ターン中の警告や通知がこれまで破棄されていたのに対し、`system/informational` メッセージとして受け取れるようになり、思考トークン予算の制御も柔軟になった。
- **主要変更**:
  - Added `plugin_errors` to the `SDKSystemMessage` type (`system/init`), including `path` for a `--plugin-dir` entry that did not load
  - Fixed `getSessionMessages()` returning, and `forkSession()` copying, a rewound-away branch when the newest branch ends at a meta row or a local command's rows
  - Changed stream-json output to include warnings and notices raised during a turn as `system/informational` messages; it previously dropped them
  - Changed the `set_max_thinking_tokens` control request: omitting `max_thinking_tokens` now leaves the session's thinking budget unchanged; send `null` to reset it to the session default
  - Updated to parity with Claude Code v2.1.283

## Python SDK

### v0.2.160（2026-09-25）
- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.160
- **概要**: バックグラウンドサブエージェント使用後のフォローアップターンが「Stream closed」で失敗する実用上重大なバグを修正。`query()` で hooks・`can_use_tool`・SDK MCP サーバーを使う場合に、サブエージェントの完了とターン結果の到着が重なると stdin が早期クローズされていた問題で、TypeScript SDK と同様に CLI の `idle` 状態まで stdin を開き続ける方式に変わった。
- **主要変更**:
  - Bug Fixes
    - **Fixed follow-up turns failing after background subagents**: The SDK now listens for the CLI's `session_state_changed` messages and keeps stdin open until the CLI reports `idle`, matching the TypeScript SDK's behavior. A bounded wait ceiling (configurable via `CLAUDE_CODE_PRINT_BG_WAIT_CEILING_MS`, default 10 minutes) prevents indefinite hangs. Older CLIs without state events fall back to the previous close-at-first-result behavior. (#1190, #1279)
  - Documentation
    - Aligned docstrings with the code and fixed docstring formatting (#1293)
  - Internal/Other Changes
    - Updated bundled Claude CLI to version 2.1.283
    - CI: skip wheels over PyPI's per-file limit instead of failing the release (#1309)

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
