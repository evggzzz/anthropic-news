# Claude Agent SDK Changelog - 2026-09-08

> 対象期間: 2026-09-02 〜 2026-09-08（7日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.261（2026-09-04）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.261
- **概要**: プラグインを stdin 経由で渡す新しい起動オプションと、テストランタイムでの `query()` クラッシュ修正が含まれるリリース。多数のプラグインを積んだ Windows 環境での起動失敗が解消される。
- **主要変更**:
  - 新オプション `pluginDelivery: 'initialize'`。プラグインを stdin 経由で渡し、プラグイン数の増加に伴ってコマンドラインが肥大化するのを防止。プラグインが多い Windows 環境での起動失敗を修正
  - ネイティブの `Symbol.dispose` が無いランタイムで `query()` が "Object not disposable" を投げる問題を修正（Node 22 以下の VM ベース環境 — Jest の node environment、vitest の vmThreads/vmForks — および 18.18 未満の Node）
  - Updated to parity with Claude Code v2.1.261

### v0.3.260（2026-09-03）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.260
- **概要**: リモートセッション向けのレイテンシー内訳フィールド追加と、`rewindFiles()` の誤成功報告など複数の重要バグ修正を含むリリース。ストリーム消費側の状態管理も改善されている。
- **主要変更**:
  - 成功結果にオプションのレイテンシー内訳フィールドを追加（リモートセッション向け）: `first_content_frame_ms`, `first_stream_post_ms`, `first_stream_post_ack_ms`, `first_stream_post_wall_ms`
  - `thinking_tokens` システムメッセージにオプションの `user_message_uuid` を追加し、thinking の進捗をターンを開始したユーザーメッセージに紐付け
  - `managedSettings` の `disableAutoMode: "disable"` が restrictive-only フィルタで除去され、スポーンされたセッションの auto mode をオフにできなかった問題を修正
  - `rewindFiles()` が復元できなかった（チェックポイントバックアップ不在など）のに成功を報告していた問題を修正。現在は失敗する
  - `error_max_structured_output_retries` の結果に最終 StructuredOutput ツールエラーを追記。検証失敗時は対象キー・許容値・実際の長さ/件数を明示
  - `rate_limit_event` が 429 の継続中に再送されるように（制限ウィンドウごとに約30秒ごと）。ストリーム消費側が古い状態をリフレッシュ可能に
  - Updated to parity with Claude Code v2.1.260

### v0.3.259（2026-09-02）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.259
- **概要**: 複数ユーザーメッセージへの応答紐付けと、無人セッション向けの権限プロンプト自動拒否オプションを追加したリリース。
- **主要変更**:
  - ターンの最初の reply フレームと結果に新フィールド `user_message_uuids`（`user_message_uuid` の隣）を追加。マージされた複数のユーザーメッセージにまたがる応答を、各メッセージと照合可能に
  - 新オプション `permissionPrompts: 'none'`。応答できる人がいないセッションで権限プロンプトを自動拒否しつつ、auto mode の分類器は動作を維持
  - Updated to parity with Claude Code v2.1.259

### v0.3.263（2026-09-06）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.263
- **概要**: Claude Code v2.1.263 とのパリティ更新のみ（v0.3.262 もパリティ更新のみで、GitHub Releases には未公開）。

## Python SDK

### v0.2.152（2026-09-02）
- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.152
- **概要**: バンドルされる Claude CLI を 2.1.259 に更新したメンテナンスリリース。新機能・バグ修正なし。

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
