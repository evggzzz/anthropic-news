# Claude Code Changelog - 2026-09-11

> 対象期間: 2026-09-10 〜 2026-09-11（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.268（2026-09-10）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.268
- **概要**: Claude apps gateway の料金設定連携（`gateway.yaml` の `pricing:`）により `/cost` とテレメトリーがスパンドメーターと一致するようになった。ゲートウェイのセキュリティ警告強化、`claude plugin` 系コマンドへの `--json` 追加、WebFetch の300秒デッドライン導入などが中心。サードパーティ `ANTHROPIC_BASE_URL` エンドポイントで毎ターン HTTP 400 が出る2.1.265回帰の修正、シンボリックリンク経由のdenyルール回避修正、プロンプトキャッシュ・コンパクション関連の修正を多数含む。
- **主要変更**:
  - ゲートウェイ料金連携: `gateway.yaml` の `pricing:` でサインイン済みクライアントに契約レートを供給し、`/cost` とテレメトリーのコスト値がスパンドメーターと整合するように
  - ゲートウェイセキュリティ: `access_control.allow_cidrs` 空での起動時に警告、パブリックアドレスからの最初のリクエストで一回警告。新管理設定 `gatewayInternalNetworks` で組織所有のパブリックIPv4レンジへの `/login` を許可可能に
  - `claude plugin install` / `uninstall` / `update` / `enable` / `disable` に `--json` を追加。`claude plugin list --json` に `errorDetails` / `noteDetails` 行を追加
  - WebFetch: レスポンスを閉じないサーバーでハングしなくなり、300秒のデッドラインを導入（`CLAUDE_CODE_WEBFETCH_DEADLINE_MS` で上書き、`0` で無効化）
  - 回帰修正: サードパーティ `ANTHROPIC_BASE_URL` エンドポイントで毎ターン HTTP 400 が発生する問題（2.1.265以降、Artifactツールの入力スキーマ正規表現起因）を修正
  - セキュリティ: macOS の `/etc` / `/tmp` / `/var`、Linux の `/bin` などシンボリックリンクされたディレクトリのdeny/askルールが実パス指定で回避できていた問題を修正。Bashもシンボリックリンク表記のdenyルールを尊重。プラグイン/マーケットプレイスのエラーでgitソースURLのトークンやパスワードが漏洩しないよう修正。`/mcp`・`claude mcp list`/`get`・MCPログインエラーで `${VAR}` プレースホルダーのシークレットを露出しないように
  - スレッド内で再生成されたエージェントが信頼できない同名エージェントファイルのツール/システムプロンプトを継承しないよう修正
  - プロンプトキャッシュ: SDKセッションの `excludeDynamicSections` 利用時にキャッシュと拡張思考がセッション途中で壊れる問題、`/compact` と自動コンパクションの要約が `$` を含むテキストを破壊する問題などを修正
  - `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS` が per-hook タイムアウト未設定の SessionEnd フックにも適用されるように（以前は1.5秒で打ち切り）
  - PermissionRequest フックが `--print` モードでも発火するように。ポリシーヘルパーの警告も headless（`-p`）実行時に出力
  - `claude self-hosted-runner --remove-session-state`（デフォルト無効）: セッション終了時に `<base-dir>/_sessions/` 配下を削除。`claude auth status --json` に `configDirectory` を追加
  - 3P（Bedrock / Vertex / Foundry）セッションのシステムプロンプトを環境・モデル・設定情報をアタッチメントとして配信し、ツールリストをバイト安定化（後続接続のツールは遅延ロード）
  - タスク管理ツール（TaskCreate / Get / Update / List / TodoWrite）は Claude 3.x・Opus 4.0〜4.7・Sonnet 4.0〜4.6・Haiku 4.5 のみに提供へ変更（他モデルでは `CLAUDE_CODE_ENABLE_TODO_TOOLS=1` で有効化）
  - アーティファクトの公開ページにブラウザタブアイコンを追加。データ編集の権限プロンプトをドキュメント数と閲覧可能者を示すカード形式に変更
  - `WebFetch` のdeny/askルールは Artifact ツールの読み書きに適用されなくなった（`Artifact` ルールまたは `WebFetch(domain:claude.ai)` を使用）
  - VS Code: `CLAUDE_CONFIG_DIR` 設定時のセッション一覧・設定トグル・チャットタブの不具合、ログイン/ログアウト後のモデルピル一時空白、権限ルール保存先を左右矢印で選択可能にするなどの修正・追加
  - Claude Code on the web: 約6時間を超えるクラウドセッションで永続フォルダー保存ファイルが失われる問題を修正（保存は最大1日保持）
  - Claude Tag: パブリックチャンネルのメモリをチャンネル単位に分離、読み取り専用ルックアップの並列化による応答速度改善、Slack Enterprise Grid チャンネル移動時の設定保持など
  - Code Review: 検証エージェント途中失敗時にレビューが未完了で終わらないよう修正、PR下書き変換後のキュー済みレビュー投稿抑制、ディレクトリの CLAUDE.md 規約を尊重

## マイナーリリース
- 該当なし（対象期間内のリリースは v2.1.268 のみ）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
