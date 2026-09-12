# Claude Agent SDK Changelog - 2026-09-12

> 対象期間: 2026-09-11 〜 2026-09-12（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.269（2026-09-11）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.269
- **概要**: 権限まわりの修正とハング解消が中心のリリース。パススコープのdenyルールでブロックされたRead/Edit/Write呼び出しが `result.permission_denials` から漏れる不具合を修正し、ホスト起動のMCPサーバーのOAuth認可待ちで割り込みや権限応答が止まる問題も解消した。Plan modeの権限チェック挙動が変わり、skip-permissionsフラグ指定時でも書き込み操作は `canUseTool` を通るようになった。
- **主要変更**:
  - Fixed `result.permission_denials` omitting Read, Edit and Write calls blocked by a path-scoped deny rule
  - `user_message_uuid`, `user_message_uuids`, `resume_reason` now also land on a turn's first finished assistant message, in addition to its opening stream event when partial messages are enabled
  - Interrupts and permission replies no longer stall while a host-launched MCP server's OAuth flow waits on a sluggish authorization server
  - `task_started` / `task_notification` now include `tool_use_id` when the CLI itself revives a background subagent, using that agent's most recent call id
  - Plan mode now sends write operations through `canUseTool` even when the skip-permissions flag is set; the flag's only remaining job is permitting a later switch into `bypassPermissions`
  - Updated to parity with Claude Code v2.1.269

## Python SDK

対象期間内の新しいリリースはありませんでした（直近は v0.2.152、2026-09-02。同リリースはバンドルClaude CLIバージョン更新のみの内部変更）。

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
