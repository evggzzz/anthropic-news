# Claude Code Changelog - 2026-09-20

> 対象期間: 2026-09-19 〜 2026-09-20（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.278（2026-09-19）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.278
- **概要**: Auto modeの分類器（classifier）がサーバー側で動作する方式へデフォルト変更された。Claude API・EnterpriseユーザーとBedrock / Vertex / Foundry / ゲートウェイ利用者が対象で、サーバー側分類器ではclassifier overheadの課金が発生しない。あわせて `/status` にサーバー側動作の状態を確認できる行が追加された。
- **主要変更**:
  - Auto modeがClaude API・Enterpriseユーザー、およびBedrock / Vertex / Foundry / ゲートウェイでサーバー側分類器をデフォルト化。サーバー側分類器にはclassifier overheadの課金なし
  - Bedrock / Vertex / Foundry / ゲートウェイでは環境変数 `CLAUDE_CODE_AUTO_MODE_SERVER=0` でオプトアウト可能
  - 課金対象の分類器へフォールバックした際にツールが警告を表示
  - `/status` に `Auto mode server` 行を追加。現在のセッションのauto mode分類器がサーバー側で動いているかを確認できる
  - 参考ドキュメント: https://code.claude.com/docs/en/auto-mode-classifier-billing

## マイナーリリース
- 対象期間内に該当なし（v2.1.277・v2.1.276は2026-09-18リリースで対象期間外、既出）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
