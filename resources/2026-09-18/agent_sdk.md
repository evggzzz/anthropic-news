# Claude Agent SDK Changelog - 2026-09-18

> 対象期間: 2026-09-17 〜 2026-09-18（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.275（2026-09-17）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.275
- **概要**: セッション再開・フォーク周りの不整合に集中した修正リリース。resumed turn 冒頭で deferred tool call が再実行されて内部キー形式の結果を返す問題や、`getSessionMessages()` / `forkSession()` がメッセージを取りこぼす複数のバグを修正した。Claude Code v2.1.275 とパリティ。
- **主要変更**:
  - Fixed deferred tool calls re-running at the start of a resumed turn emitting results with internal keys such as `toolUseResult` instead of `tool_use_result`
  - Fixed `getSessionMessages()` / `forkSession()` occasionally dropping a turn's assistant message when invoked right after that turn's `result` message
  - Fixed `forkSession({ upToMessageId })` rejecting a client-supplied `SDKUserMessage.uuid` that is not in UUID format
  - Fixed `forkSession` rejecting the id `getSessionMessages` returns for a message sent while Claude was working, plus a fork showing the re-run prompt twice
  - Fixed `getSessionMessages()` skipping queued messages (e.g. task notifications) Claude consumed mid-tool; they now surface where Claude read them
  - Updated to parity with Claude Code v2.1.275

### v0.3.274（2026-09-17）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.274
- **概要**: MCPサーバー起動まわりの制御とスタートアップの可視化が中心の機能追加リリース。ホストの信頼判定に必要な情報（MCPサーバー名とsource）が `canUseTool` や tool hook に渡るようになり、初回ターンのMCP接続待ち時間を `CLAUDE_CODE_MCP_STARTUP_WAIT_MS` で制御・無効化できるようになった。Claude Code v2.1.274 とパリティ。
- **主要変更**:
  - Added `startup_failure_reason` to the error result a stream-json run writes before exiting on a known startup failure
  - New fields for host trust decisions: `mcpServer: {name, source}` in `canUseTool` options, `mcp_server` in tool hook inputs, and `source` on MCP status rows (check `source === "sdk"`)
  - New `CLAUDE_CODE_MCP_STARTUP_WAIT_MS` env var (via `env`) caps or disables (with `0`) the first-turn wait on connecting MCP servers
  - New `CLAUDE_CODE_EMIT_STARTUP_TIMING=1` flag: stream-json hosts get a per-phase `startup_timing` breakdown on the first `system/init`
  - Fixed `getSessionMessages()` missing user messages sent while a tool ran; they now return as user messages where Claude read them
  - Fixed the replayed user message lacking `origin: {kind: 'task-notification'}` when a background task finished mid-turn under `--replay-user-messages`
  - Startup speedup: turn one no longer waits up to 2s on settings/plugins MCP servers whose tools defer via search; `options.mcpServers` servers are still awaited
  - Queued background-task completions now share one model call — each still emits a `result`, all but the last empty at `num_turns: 0`
  - Updated to parity with Claude Code v2.1.274

## Python SDK

### v0.2.155 / v0.2.154（2026-09-17）
- **URL**:
  - https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.155
  - https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.154
- **概要**: 両バージョンともバンドルClaude CLIの更新のみ（v0.2.155 → Claude CLI 2.1.275、v0.2.154 → Claude CLI 2.1.274）。SDK自身の機能変更・バグ修正はない。CLI側の変更内容はTypeScript SDK v0.3.274 / v0.3.275 のエントリを参照。
- **主要変更**:
  - Updated bundled Claude CLI to version 2.1.275（v0.2.155）
  - Updated bundled Claude CLI to version 2.1.274（v0.2.154）

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
