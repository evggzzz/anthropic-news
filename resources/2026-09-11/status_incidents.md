# Claude Status Incidents - 2026-09-11

> 対象期間: 2026-09-10 〜 2026-09-11（2日分）／取得元: https://status.claude.com/history.rss

## 今回の対象インシデント

### Degraded functionality for Claude Cowork on Windows
- **Date**: Thu, 10 Sep 2026 17:20:39 +0000
- **URL**: https://status.claude.com/incidents/r1pqn1kb4hvk
- **状態**: 【進行中】未解決（最終更新 2026-09-10 17:20 UTC、ステータスは Identified）
- **影響**: Claude Cowork on Windows
- **概要**: 2026年9月8日配信のWindowsアップデートが原因で、Claude Cowork on Windowsがローカルコマンドを実行できなくなった。ワークスペースがコンピュータのドライブにアクセスできないためで、15:54 UTCに原因と判明した。チャットやファイルの読み取り・編集はほぼ通常どおり利用可能。アプリ内に回避策はなく、再起動・再インストールでも直らない。修正はMicrosoft側で対応中。

### Elevated latency on the Claude API for some users
- **Date**: Thu, 10 Sep 2026 23:24:22 +0000
- **URL**: https://status.claude.com/incidents/2pt83vlkk7x7
- **状態**: 解決済み（2026-09-10 23:24 UTC）
- **影響**: Claude API（トラフィックが米国中西部経由で流入するユーザー）
- **概要**: 米国中西部経由でトラフィックが流入する一部の顧客で、Claude APIの応答速度が通常より低下し、一部リクエストがタイムアウトした。21:43 UTCに原因を特定し、23:24 UTCに解決を確認した。

## Source References
- Claude Status: https://status.claude.com/
- Incident history RSS: https://status.claude.com/history.rss
