# Anthropic Research - 2026-09-11

> 対象期間: 2026-09-10 〜 2026-09-11（2日分）／取得元: https://www.anthropic.com/research

## 今回の対象ポスト

### Measuring tactical intelligence targeting and conventional weapons capabilities of AI models
- **Date**: Sep 10, 2026
- **Category**: Frontier Red Team
- **URL**: https://www.anthropic.com/research/intelligence-targeting-conventional-weapons-capabilities
- **Summary**: Frontier Red Teamが、AIモデルの戦術的インテリジェンス標定（「find／fix」タスク）と通常兵器開発能力を測定する評価を構築・実施した。対象はClaude（Mythos Preview、Mythos 5、Opus 5、Sonnet 5）とオープンウェイトのKimi K3（一部評価でGLM 5.2）で、標定評価は(1)架空シナリオのSNSコンテンツ200タスクからの個人特定（F1スコア評価、Mythos Previewが最高）、(2)6,000枚のFlickr写真のジオロケーション（ツール・メタデータなし。Mythos Previewは中央誤差37.0 km、1 km以内23.7%で、GeoGuessr上位者代理との比較により屋外写真では「超人的能力に近い」と評価）、(3)テキストベースの位置推定（GeoTextコーパス、検索付き。複数モデルが利用者の8%を1 km以内に特定）の3系統。兵器開発評価はシミュレーションのみ（Betaflightファームウェアのクアッドコプター）で、終端誘導ではOpus 5が突出（駐車車両80%命中、全540発中20%成功。コード編集が小さく比例航法・カルマンフィルタを早期導入）、ペイロード投下では強風下でもOpus 5が28%成功、GPS妨害下航行ではOpus 5が15〜20 m以内に到達したが、GPSスプーフィング設定はどのモデルも解けなかった。限界として、シミュレーションのみでハードウェア検証なし、合成SNSデータの現実性不足、人間のuplift（能力向上）の直接測定なし、写真ジオロケーションの人間ベースラインはGeoGuessr代理であり、結果は「下限値」として扱うべきと明記されている。政策面では、クローズドウェイト開発者には配備後の安全策（AnthropicのSafeguardsチームが兵器開発リクエストをブロックする分類器を追加）、オープンウェイトの安全性研究の緊急性、民主主義国のコンピュート優位の保護などを提起している。
- **論文リンク**: 記載なし（本文中のarXivリンク https://arxiv.org/abs/2307.05845 はGeoGuessr人間ベースライン代理としての引用（Haas et al. 2024）であり、本ポスト自身の論文ではない。併催レポートとして脅威インテリジェンス報告 https://www.anthropic.com/threat-intelligence-report-september-2026 をリンク）

## Source References
- Anthropic Research: https://www.anthropic.com/research
