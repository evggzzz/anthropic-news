# Claude Code Changelog - 2026-09-09

> 対象期間: 2026-09-08 〜 2026-09-09（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.266（2026-09-08）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.266
- **概要**: v2.1.265で発生した退行の緊急修正リリース。LLMゲートウェイ・プロキシ環境で全リクエストが失敗する問題を修正しており、v2.1.265に上げたゲートウェイ利用者は直ちにv2.1.266へ更新すべき内容。
- **主要変更**:
    - 非公開の環境変数 `CLAUDE_CODE_USE_GATEWAY` を単独で設定しただけでもCloudゲートウェイへのサインインが強制される退行を修正（v2.1.265で発生）。APIキー、`apiKeyHelper`、カスタム認証ヘッダーとの併用構成で "Not signed in to the Cloud gateway" エラーで全リクエストが失敗していた
    - この変数は従来どおり単独では無視される。設定変更は不要

### v2.1.265（2026-09-08）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.265
- **概要**: 50項目以上の大幅な更新。プラグイン管理、ワークフロー表示、セッション再開の高速化など機能強化が中心。一方でゲートウェイ環境に退行を混入させており、この修正が翌日のv2.1.266として出た。
- **主要変更**:
    - `--plugin-dir` でフォルダ指定に対応。マニフェストを持つ子フォルダが個別に読み込まれ、実行中の追加・削除も検知される
    - ディスク保存されるツール結果に1GB上限を導入。切り詰められた場合は会話内プレビューに明記
    - 非対話セッション（`-p` + stream-json、Agent SDK、クラウドセッション）でシェルの作業ディレクトリが毎メッセージでリセットされなくなり、`cd` がターンをまたいで保持される
    - `--worktree` が git 2.32以上で並列チェックアウトになり、大型リポジトリの起動が速く
    - `/workflows` のエージェント詳細を強化。ツール呼び出しの実行中/失敗/完了表示、サブエージェントのタスクリスト表示、Enterでの展開に対応
    - スラッシュコマンドを文中入力時に候補がリスト表示になり、プラグインスキルを裸の名前でも呼び出せる
    - サインインが必要なリモートMCPサーバーへのOAuthクライアント登録を、実際に認証するまで行わないように変更
    - MCP `http` サーバーがレガシーHTTP+SSEトランスポートしか話さない場合に接続しない問題を修正。MCP仕様どおりSSEへフォールバック
    - 2キーショートカットがtmux内など2打鍵間隔1秒超で静かにキャンセルされる問題を修正。3秒待ち、タイムアウト時は通知
    - `forceLoginGatewayUrl`（managed settings）があるマシンは起動時からClaude appsゲートウェイセッションになるよう変更（`forceLoginMethod: "gateway"` と同挙動）
    - Claude appsゲートウェイセッションがOpenTelemetryを、ゲートウェイ中継を経由せず managed settings が指定したコレクターへ直接エクスポートするように変更
    - 画像処理をランタイム内蔵の仕組みに変更し、一時ディレクトリへのネイティブイメージモジュール展開を廃止
    - `/model opusplan[1m]` が "Model not found" で拒否される問題を修正
    - `/login`・`/model`・`/clear` の表示や動作の不具合を複数修正（ゲートウェイ再ログイン時の誤エラー、設定書き込み失敗の隠蔽、Remote Controlからの `/clear` がフック待ちで止まる等）
    - advisorツールの採用判断がリクエストごとに再決定される問題を修正。判断は1回にまとめ、変わった時点で会話内で告知
    - Artifactツールが他人のアーティファクトを読む際、信頼できないコンテンツとして扱い、埋め込まれた指示をそのまま中継せず検知・警告するように
    - プラグインパスのバックスラッシュでmacOS/Linuxのシンボリックリンク閉込チェックをすり抜ける問題を修正
    - ワークフロー実行のコンテナ再起動後の再開を修正。実行ジャーナルが欠落している場合は全エージェントを再実行せず明確なエラーで失敗
    - `claude-api` スキルのエラーコード参照を修正（モデルアクセス失敗は404、利用不可betaヘッダーは400）
    - WindowsのAppContainer/制限トークンサンドボックス内でRead/Write/Editが全ファイルを拒否する問題を修正
    - [VS Code] 非アクティブセッションの自動アーカイブを追加（新設定 "Archive inactive sessions"、既定14日）。Reload Window後のサイドバーチャットが空白になる問題も修正

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
