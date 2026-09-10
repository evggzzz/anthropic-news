# Claude Agent SDK Changelog - 2026-09-10

> 対象期間: 2026-09-09 〜 2026-09-10（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.267（2026-09-09）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.267
- **概要**: ブラウザSDKのSSEトランスポートに、再接続・追いかけ再生のためのAPIとオプションが追加された。あわせて `systemPrompt` の記録（snapshot）がカスタムプロンプトと追記でデフォルト有効になり、セッション途中のプロンプト変更は次のcompactionで反映される。Claude Code v2.1.267とのパリティ。
- **主要変更**:
  - Added `getCcrEvent(query, message)` and `getSseLastSequenceNum(query)` to the browser SDK's SSE transport, plus `fromSequenceNum`, `onCatchUpTruncated` and `onDeliveryUpdate` SSE options
  - Changed `systemPrompt` recording to default on for custom prompts and appends (a mid-session prompt change takes effect at the next compaction); pass `snapshot: false` to keep per-request rendering
  - Updated to parity with Claude Code v2.1.267

## Python SDK

対象期間内の新しいリリースはありませんでした（最新は v0.2.152、2026-09-02公開。内容は bundled Claude CLI の 2.1.259 更新のみ）。

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
