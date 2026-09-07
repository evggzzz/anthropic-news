# Claude Status Incidents - 2026-09-08

> 対象期間: 2026-09-02 〜 2026-09-08（7日分）／取得元: https://status.claude.com/history.rss

## 今回の対象インシデント

### Elevated errors for multiple models
- **Date**: 2026-09-03 16:23:12 UTC
- **URL**: https://status.claude.com/incidents/461yvfrzpwtt
- **状態**: 解決済み（2026-09-03 16:23 UTC。実際の影響は 16:16 UTC まで）
- **影響**: Claude Mythos 5.1 / Fable 5.1 / Mythos 5 / Fable 5 / Opus 5 / Opus 4.8 / Opus 4.6
- **概要**: 複数モデルでエラー率が上昇。13:26 UTC に調査開始、13:41 に原因特定。13:50 時点の対象モデル一覧は Mythos/Fable 5.1、Mythos/Fable 5、Opus 5、Opus 4.8、Opus 4.6。15:25 時点で影響は Opus 4.8 と Opus 5 のみに縮小し、16:06 に修正をデプロイ、16:23 に解決。

### Elevated errors for Claude Sonnet 5
- **Date**: 2026-09-03 12:56:26 UTC
- **URL**: https://status.claude.com/incidents/288w7p4hk1l1
- **状態**: 解決済み（2026-09-03 12:56 UTC）
- **影響**: Claude Sonnet 5
- **概要**: Claude Sonnet 5 でエラー率が上昇。12:37 UTC に調査開始、12:47 に修正を実施し 12:56 に解決。

### Elevated errors for Claude Sonnet 5
- **Date**: 2026-09-02 21:44:28 UTC
- **URL**: https://status.claude.com/incidents/ls6bn1x81m0w
- **状態**: 解決済み（2026-09-02 21:44 UTC）
- **影響**: Claude Sonnet 5
- **概要**: Claude Sonnet 5 でエラー率が上昇（実際の影響期間は 21:05〜21:19 UTC）。21:17 に調査開始、21:44 に解決。

### Delays in credit purchases
- **Date**: 2026-09-02 01:24:22 UTC
- **URL**: https://status.claude.com/incidents/620swtqyn24k
- **状態**: 解決済み（2026-09-02 01:24 UTC）
- **影響**: クレジット購入処理
- **概要**: 残高ゼロのユーザーで購入したクレジットの反映が遅延し、誤った「クレジット残高が不足しています」エラーが発生。9/1 12:10〜21:35 UTC の購入が影響対象。9/1 23:26 にモニタリング状態に入り、9/2 01:24 に解決。

## Source References
- Claude Status: https://status.claude.com/
- Incident history RSS: https://status.claude.com/history.rss
