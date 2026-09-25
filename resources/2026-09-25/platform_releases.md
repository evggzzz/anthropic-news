# Claude Platform Release Notes - 2026-09-25

> 対象期間: 2026-09-24 〜 2026-09-25（2日分）／取得元: https://platform.claude.com/docs/en/release-notes/overview

## 今回の対象エントリ

### 2026-09-24 - Refusal billing expansion（リフューザル課金対象の拡大）
- **URL**: https://platform.claude.com/docs/en/release-notes/overview
- **概要**: Claude APIのrefusal（拒否応答）のうち、出力が始まる前に到着したrefusalの課金対象が拡大された。対象は `stop_details.category` が `"bio"`、`"frontier_llm"`、`"reasoning_extraction"` の3カテゴリで、誤検出が少ないカテゴリとして測定されているもの。新たに課金されるrefusalは通常のリクエストと同様に、実行されたモデルのレートで課金される。
- **破壊的変更**: APIシェイプの破壊的変更はない。ただし課金動作の変更であり、上記3カテゴリの出力前refusalが新たに課金されるため、請求額に影響する可能性がある（意図しないコスト増に注意）。
- **詳細**:
  - 課金対象の拡大: 出力前（before any output）のrefusalのうち、`stop_details.category` が `"bio"` / `"frontier_llm"` / `"reasoning_extraction"` のものが新たに課金対象になる
  - ストリーミング途中（mid-stream）のrefusalはすでに課金対象。今回の変更は出力前refusalに適用
  - 新たに課金されるrefusalは通常リクエストと同様に課金され、レートは実行されたモデルの料金に従う
  - 上記以外のカテゴリの出力前refusalは引き続き課金されない。fallbackクレジットの扱いも変更なし
  - この変更はすべてのプラットフォーム（Claude API、Amazon Bedrock、Google Cloud など）に適用される
  - 詳細はドキュメント「How refusals are billed」を参照

## Source References
- Claude Platform Release Notes: https://platform.claude.com/docs/en/release-notes/overview
