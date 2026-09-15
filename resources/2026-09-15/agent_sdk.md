# Claude Agent SDK Changelog - 2026-09-15

> 対象期間: 2026-09-14 〜 2026-09-15（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.271（2026-09-14）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.271
- **概要**: サブエージェント定義（`agents` オプション）に CLAUDE.md を読み込まずに起動する `omitClaudeMd` を追加。Windows 環境のセッション検出と `sessionStore` レジューム時の設定喪失という2つの不具合も修正されている。Claude Code v2.1.271 とパリティ。
- **主要変更**:
  - Added optional `omitClaudeMd` to `AgentDefinition` in the `agents` option, so a subagent can run without user, project and local CLAUDE.md files; managed policy files still load
  - Fixed `listSessions`, `getSessionMessages` and `getSessionInfo` with `dir` on Windows not finding sessions for a directory on a mapped network drive or SUBST drive
  - Fixed `sessionStore` resume losing the global config when it is stored under the legacy `.config.json` name or an OAuth-suffixed file name
  - Removed `persistent` from the `MonitorInput` tool type（破壊的変更: `MonitorInput` ツール型から `persistent` フィールドが削除）
  - Updated to parity with Claude Code v2.1.271

## Python SDK

## 対象バージョンなし
対象期間内の新しいリリースはありませんでした。最新は v0.2.152（2026-09-02、Claude CLI 2.1.259 同梱のバンドル更新のみ）で、対象期間外です。

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
