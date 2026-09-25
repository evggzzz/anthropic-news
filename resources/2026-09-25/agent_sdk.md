# Claude Agent SDK Changelog - 2026-09-25

> 対象期間: 2026-09-24 〜 2026-09-25（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.282（2026-09-24）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.282
- **概要**: ホスト提供の `managedSettings` でのマーケットプレイス許可/ブロック制御、バンドルアプリ向けの軽量エントリーポイント `@anthropic-ai/claude-agent-sdk/core`、セッション起動前のプロセス事前起動（`prewarm()` / `SpareProcess.claim()`、alpha）が追加された。Claude Code v2.1.282 とのパリティ更新を含む。
- **主要変更**:
  - Added `strictKnownMarketplaces` and `blockedMarketplaces` support in host-supplied `managedSettings`（許可リストは管理者ポリシーが無い場所で適用、ブロックリストは管理者ポリシーに積み重ね）
  - Added `@anthropic-ai/claude-agent-sdk/core`（`query`、MCP tool helpers、session mutations、`resolveSettings` を含むスリムなエントリーポイント。zod と MCP SDK は利用側のインストールに依存）
  - Added `prewarm()` and `SpareProcess.claim()` (alpha)（セッション存在前に Claude Code プロセスを起動し、後からフォルダと per-session options を紐付け）
  - Fixed `readMcpResource()` no longer relaying content `_meta` keys using the CLI-reserved `com.anthropic/` prefix（tool results と同様に破棄）
  - Updated to parity with Claude Code v2.1.282

## Python SDK

対象期間内の新しいリリースはありませんでした。（直近の v0.2.159 / v0.2.158 は 2026-09-23 リリースで、前回分として処理済み）

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
