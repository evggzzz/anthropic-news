# Claude Platform Release Notes - 2026-09-23

> 対象期間: 2026-09-22 〜 2026-09-23(2日分)／取得元: https://platform.claude.com/docs/en/release-notes/overview

## 今回の対象エントリ

### 2026-09-22 - Claude Opus 5.5 launch
- **URL**: https://platform.claude.com/docs/en/release-notes/overview
- **概要**: 長時間稼働のエージェント型コーディングとナレッジワーク向けの新モデル **Claude Opus 5.5**(`claude-opus-5-5`)が公開された。デフォルトで100万トークンのコンテキストウィンドウ、最大出力128kトークン、アダプティブシンキングが常時有効。価格は入力 $4 / 出力 $20 USD per MTok で、Opus 5($5 / $25)より約20%低価格。Claude API、Amazon Bedrock、Claude Platform on AWS、Google Cloud、Microsoft Foundry で利用可能。あわせて Fast mode(research preview)と、会話途中の system メッセージ内でのツール定義(beta)が発表された。
- **破壊的変更**: あり。Opus 5.5 では thinking を無効化できない。`thinking: {"type": "disabled"}` および `thinking: {"type": "enabled", ...}` は 400 エラーを返すため、`thinking` フィールドを省略して effort パラメータで深さを制御する。`tool_choice` の `any` と `tool` も Fable 5.1 と同様に 400 エラーとなり、`auto` + strict tool use を使う。API と Google Cloud では computer use に `computer_toolset_20260801` ツールセットが必須で、旧 `computer_20251124` は 400 エラー(Amazon Bedrock では `computer_20251124` が引き続き動作)。
- **詳細**:
  - モデルID: `claude-opus-5-5`。コンテキスト100万トークン(デフォルト)、最大出力128kトークン、always-on adaptive thinking
  - 価格: **$4 / $20 USD per MTok**(Claude Opus 5 は $5 / $25)
  - 提供面: Claude API / Amazon Bedrock / Claude Platform on AWS / Google Cloud(Vertex AI)/ Microsoft Foundry
  - Fast mode(research preview)が Claude API 上の Opus 5.5 で利用可能に
  - インラインツール定義(beta、Claude API、beta header: `inline-tools-2026-09-15`): 会話途中の system メッセージ内でツールを定義できる。`tool_addition` ブロックがツールの完全な定義を運べる(`tool: {"type": "tool_definition", "definition": {...}}`)ため、`tools` を編集せずにツール追加・スキーマ変更・サーバーツールの新バージョンへの移行が可能で、プロンプトキャッシュを無効化しない。同じヘッダで参照によるツールの追加・削除もカバー
  - MCP connector と組み合わせる場合(beta header: `mcp-client-2026-09-15` も付与): 定義として MCP ツールセットを指定でき、レスポンスは各サーバーが取得したツールリストを `mcp_tool_listing` ブロックに記録し、送り返すとそのリストが固定される
  - マイグレーションガイド: `https://platform.claude.com/docs/en/models/opus-5-5/migration-guide`(What's new: `https://platform.claude.com/docs/en/models/opus-5-5/whats-new-opus-5-5`)

## Source References
- Claude Platform Release Notes: https://platform.claude.com/docs/en/release-notes/overview
