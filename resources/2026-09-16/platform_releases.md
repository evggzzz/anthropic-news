# Claude Platform Release Notes - 2026-09-16

> 対象期間: 2026-09-15 〜 2026-09-16（2日分）／取得元: https://platform.claude.com/docs/en/release-notes/overview

## 今回の対象エントリ

> 注: 取得時点で 2026-09-15〜2026-09-16 日付のエントリはまだ掲載されていない（最新は 2026-09-14）。下記の 2026-09-14 エントリは、前回実行（2026-09-15、対象期間 09-14〜09-15）の取得時点では未掲載で、seen_urls にも未登録（一度もダイジェストでカバーされていない）のため、取りこぼし防止の目的で今回に含める。

### 2026-09-14 - Messages API on-demand conversation compaction（beta）
- **URL**: https://platform.claude.com/docs/en/release-notes/overview
- **概要**: Messages API で会話をオンデマンドでコンパクション（要約による圧縮）できる機能がベータで追加された。ベータヘッダー付きでトップレベルの `compaction` パラメータを送ると、API は送信済みメッセージを要約した署名付き `compaction` ブロックを返す。以降のリクエストでは元のメッセージ群の代わりに、このブロックを先頭に送信すればよい。
- **破壊的変更**: なし（既存動作を変更しないベータ機能の追加）
- **詳細**:
  - ベータヘッダー: `compact-2026-09-04`
  - トップレベル `compaction` パラメータを送信すると、API が送信メッセージを要約する署名付き `compaction` ブロックを返す
  - 以降のリクエストでは、対象メッセージの代わりに `compaction` ブロックを先頭に送信する
  - コンパクションのタイミングは開発者が選択でき、リクエストはバックグラウンド実行も可能
  - 要約後も直近のターンは要約されずそのまま（word for word）保持できる
  - preserved thinking 対応モデルでは、保持したターンの thinking ブロックも有効なまま維持できる

## Source References
- Claude Platform Release Notes: https://platform.claude.com/docs/en/release-notes/overview
