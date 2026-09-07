# Claude Code Changelog - 2026-09-08

> 対象期間: 2026-09-02 〜 2026-09-08（7日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.259（2026-09-02）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.259
- **概要**: 組織全体に MCP サーバーを配布する `managedMcpServers` 管理設定と、無人ヘッドレス運用向けの `--permission-prompts none` を追加。GitLab MR（glab）認識や `claude plugin validate --json` も入った。マルチセッションでの設定破壊など管理・権限周りの修正が多い。
- **主要変更**:
  - 追加: `managedMcpServers` 管理設定 — 組織が全ユーザーに HTTP/SSE MCP サーバーを提供（`.mcp.json` と同じ形式。コマンド実行型エントリはスキップ）
  - 追加: `--permission-prompts none` — プロンプトが出る操作を自動拒否してヘッドレスホストの無人運用を可能に（auto モード等の権限モード判定は継続）
  - 追加: `glab mr create/merge/close/reopen/note/update` を認識。GitLab MR がツール要計で `MR !N` 表示されフッターの MR バッジも更新
  - 追加: `claude plugin validate --json`（機械可読な検証レポート）
  - 変更: `allowedMcpServers` の適用範囲をユーザー追加サーバーのみに縮小。除外には `deniedMcpServers` を使う
  - 修正: セッション同時実行で `~/.claude.json` の変更が互いに黙って元に戻る問題（workspace trust のリセット、MCP/プロジェクト状態の消失）
  - 修正: 管理設定ファイルがパース不能のとき黙って未適用になる問題 — 起動を拒否し原因のソースを表示するように
  - 修正: カスタムコマンド/スキルの frontmatter `model:` が対話セッションで無視される問題
  - 修正: telemetry 無効セッションで OAuth トークン更新のたびにプロンプトキャッシュが失効する問題
  - [VSCode] セッションリストに Active クイックフィルターとステータスフィルターメニュー（Needs input / Working / Completed）を追加

### v2.1.260（2026-09-03）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.260
- **概要**: フルスクリーンで未コミット差分を見られる `/diff` パネルと、`/cost` へのプロンプトキャッシュミス原因表示を追加。前版 2.1.259 の `Read()` deny ルールの Bash 引数への適用は撤回。Fable 5.1 の 1M コンテキスト・キャッシュ周りの修正が目立つ。
- **主要変更**:
  - 追加: `/diff` — フルスクリーンモードで会話の横に未コミット変更の差分パネルを表示
  - 追加: `/cost` とステータスライン `prompt_cache` フィールドにキャッシュミスの推定原因（ツール定義やシステムプロンプトの変更、TTL 超過など）を表示
  - 追加: `/reload-plugins` がヘッドレスセッションで使用可能に。`/advisor` のテキスト形式（`/advisor`、`/advisor <model>`、`/advisor off`）を Desktop・Remote Control・`-p`/Agent SDK 向けに提供
  - 追加: Claude apps gateway に `oidc.scope_on_refresh`（refresh 時に `openid` 再要求が必要な IdP 向け）
  - 撤回: 2.1.259 の「`Read()` deny ルールを Bash 引数に適用」— `Read(./**/build/**)` ルール下で `npm run build` が全モードで拒否される等の誤動作
  - 修正: パスに括弧を含む `Edit`/`Write`/`Read` 権限ルールが無効としてドロップされ、"read-only" フォルダが実際には書き込み可能になる問題
  - 修正: `model: fable` エージェントが `[1m]` タグを無視して 200K コンテキストで動作する問題、および Fable 5.1 のプロンプトキャッシュがツール結果以降のコンテキストをカバーせず毎ターン再送していた問題
  - 修正: `/rewind` と `--rewind-files` がバックアップ欠落時に偽の成功を報告する問題
  - 修正: Bedrock のモデル検出・トークンカウント・SSO/STS 認証が企業ルート CA のみ環境で "unable to get local issuer certificate" になる問題
  - 変更: フルスクリーンの `ctrl+l` / `cmd+k` が terminal の `clear` 相当で transcript 表示をクリア（スクロールで過去は閲覧可）
  - 変更: `!` bash モードで入力したコマンドは strict sandbox（`sandbox.allowUnsandboxedCommands: false`）下でもサンドボックス外で実行
  - 変更: サブエージェントが開始したバックグラウンドコマンドの1時間上限を廃止、終了または停止まで実行
  - 改善: 1M コンテキストモデルの auto-compact がリミット直前に動作するように。非常に大きなコンテキストの復帰 compact が10分でタイムアウトしないように

### v2.1.261（2026-09-04）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.261
- **概要**: コマンド・タスク出力のインライン受信上限を最大128K文字まで引き上げる `bashOutputMaxChars`/`taskOutputMaxChars` 設定、未使用スキルの文脈コストを可視化する `/skill-doctor`、サブエージェントプロンプトをファイルから読む `--append-subagent-system-prompt-file` を追加。単語編集キーが Bash 準拠になり `keybindingFlavor` は無効化。Remote Control 修正が大量に含まれる。
- **主要変更**:
  - 追加: `bashOutputMaxChars` / `taskOutputMaxChars` 設定 — コマンドとバックグラウンドタスクの出力をファイル保存せずインラインで受け取る上限を最大128K文字まで拡張
  - 追加: `/skill-doctor` — ロード済みスキルのうち未使用のものとそのコンテキスト消費を表示し、整理を促す
  - 追加: `--append-subagent-system-prompt-file` — コマンドラインに載せきれない大きさのサブエージェントシステムプロンプトをファイルから読み込む
  - 追加: `/status` と `claude doctor` に "Organization policy" 行 — 組織ポリシーが読み込めない原因（プロキキがエンドポイントを通さない等）を表示
  - 変更: プロンプト入力の単語編集キーが Bash 準拠に（Ctrl+W は直前の空白まで削除、Alt+F/Alt+D は単語末で停止、句読点も区切り）。`keybindingFlavor` は効力なし（実質非推奨）
  - 変更: auto モードで、公開ダイアグラムレンダラーの URL にコンテンツを詰め込むリンクを当該サイトへのアップロードとみなし、明示指定なしでは自動承認しない
  - 修正: 高速入力・キーリピート時に文字が欠落したり順序が入れ替わる問題
  - 修正: Bedrock セットアップウィザードが AWS 認証情報ヘルパーの無応答でハングする問題（明確なエラーでタイムアウト）。TLS 検査プロキキ配下でのモデルチェック失敗も
  - 修正: セッション resume 時に並列ツール呼び出し周辺のフック出力等のコンテキストが失われ、再開後のリクエストが変わる問題
  - 修正: Remote Control の古い権限モード表示、スマホ/ブラウザから停止後もスピナーが止まらない問題、`/teleport` で取得したセッションのアップロード先誤りなど多数
  - 改善: `/model` ピッカーと VS Code のモデルピルが、認識済みモデルで生の Bedrock/Vertex/LLM gateway ID の代わりにモデル名を表示
  - 改善: `rm -rf` 安全プロンプトが位置パラメータとダブルクォート内 `sh -c` スクリプトのケースも検出
  - [VSCode] MCP サーバーダイアログに追加フォームと削除アクション（IDE 離脱なしでサーバー追加・削除）、セッションリスト右クリックに「Archive session」など

## マイナーリリース
- v2.1.263（2026-09-06） — バグ修正と安定性向上のみ

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
