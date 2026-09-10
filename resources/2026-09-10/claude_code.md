# Claude Code Changelog - 2026-09-10

> 対象期間: 2026-09-09 〜 2026-09-10（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.267（2026-09-09）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.267
- **概要**: 新設定 `maxEffortLevel` と新フラグ `--system-prompt-snapshot off` を追加。セッション再開時のプロンプトキャッシュ再利用を阻む多数の要因（MCPツールリスト再送・コネクタ再接続・`/model` 切替など）を修正し、コスト面での恩恵が大きいリリース。このほかマーケットプレイスのサンドボックス回避バグなどセキュリティ修正、VS Code拡張のCPU 100%問題などを含む。
- **主要変更**:
  - 新設定 `maxEffortLevel`: トップレベルまたは `modelSettings` 内のモデルごとに設定可能。Bedrock / Vertex / Foundry を含む全プロバイダーで effort の上限を指定する（手動でのより低い選択は可能）
  - 新フラグ `--system-prompt-snapshot off`: 会話に記録されたシステムプロンプトを再利用せず毎リクエストで新規レンダリング。プロンプトテキストの反復改善用
  - セキュリティ: マーケットプレイスエントリのパスにバックスラッシュを含めると macOS/Linux でコンテインメントチェックを回避できた問題を修正。管理設定の `allowedHttpHookUrls` / `httpHookAllowedEnvVars` / `allowedChannelPlugins` が読み取れない場合の挙動を「全許可」から「全拒否」に変更
  - プロンプトキャッシュ修正（多数）: MCPサーバー再接続時のツールリスト再書き換え、`/model` 切替時の全ツール定義再送、再開セッションでのツール説明の再レンダリング、printモード会話の対話的再開時のシステムプロンプト前置変更など、キャッシュミスと拡張思考の喪失を引き起こす経路を順次解消
  - `claude remote-control`: サーバー資格情報の期限切れ（約30日）で終了し全セッションを切断していた問題を修正。ホストが再登録して継続する
  - `-p --resume` が `/compact` 後に余分な "Continue from where you left off." ターンを挿入する問題を修正。5MB超のセッション再開で並列ツール呼び出しが失われる問題も修正
  - Claude Desktop 配下で AWS / Google Cloud 認証情報の期限切れ時に「request failed」を10回リトライしていたのを、再認証エラーを即座に提示するよう修正
  - 組織管理設定でサンドボックス必須の環境において Cowork のスケジュール済みクラウドタスクが起動時失敗する問題を修正
  - カスタムコマンド・スキル・サブエージェントの `effort:` フロントマターが、デフォルトeffort固定のモデル（Opus 4.7 / Opus 4.8 / Fable 5）で無視される問題を修正
  - セルフホストランナー: `--use-anthropic-git-proxy` をサーバー登録時に報告し、レガシープロキシ経由のクローンが残る場合はセッションごとに警告。ゲートウェイの `forward_user_identity` 上流は429をフェイルオーバーせずそのまま返し、ユーザー別レート制限を維持
  - VS Code: フォーク・メッセージ編集・トランスクリプトの巻き戻し時に拡張ホストがCPU 100%になる問題（循環親リンク起因）を修正。WSL2でのスクリーンショット貼り付け、CRLFファイルへの編集適用、RTLテキスト入力、Remote-SSHでのセッション一覧読み込み失敗、巨大ワークスペースでのripgrepプロセス暴走も修正
  - Claude Code on the web: GitHub Enterprise Serverでトークン期限切れ後にGitHubアカウントが切断表示される問題を修正（PR/issue操作時に自動リフレッシュ）。Claude GitHub App未導入組織では接続済みGitHubアカウントへフォールバック
  - Claude Tag: クレジット切れ時のエラー表示、トップレベルメッセージ編集・削除要求のルーティング、Toolアクセス承認フローの「Authorization failed」を修正

## マイナーリリース
- 該当なし（対象期間内のリリースは v2.1.267 のみ）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
