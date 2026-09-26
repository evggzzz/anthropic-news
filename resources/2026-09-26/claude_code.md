# Claude Code Changelog - 2026-09-26

> 対象期間: 2026-09-25 〜 2026-09-26（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.283（2026-09-25）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.283
- **概要**: LLMゲートウェイ向けのプロンプト単位リクエストグルーピングと、モデル制御のための新しい管理設定（`availableModelsMatch` / `deniedModels`）を追加。旧モデル向けに書かれたプロンプト資産を監査する `/doctor prompt-audit` が登場したほか、MCP・プラグイン・vim・キーバインド周りの修正が多数入った大型リリース。サードパーティプロバイダ利用時やテレメトリ無効時の権限モードの初期値が auto mode に変わる動作変更と、2.1.282で行った `claude-ai` 名前予約の撤回も含む。
- **主要変更**:
  - 新機能
    - ゲートウェイヒントヘッダに `x-claude-code-prompt-id` を追加。`CLAUDE_CODE_GATEWAY_HINT_HEADERS=1` で有効化すると、1つのユーザープロンプトに対応するリクエスト群をゲートウェイ側でグルーピングできる
    - 管理設定 `availableModelsMatch` を追加。`"exact"` を指定すると `availableModels` のエントリは名称通りのモデルバージョンのみ許可し、新リリースは明示登録までブロックされる
    - 管理設定 `deniedModels` を追加。`availableModels` が許可していても特定モデルをブロックできる
    - `/doctor prompt-audit`（別名 `/checkup prompt-audit`）を追加。CLAUDE.md・スキル・エージェント・コマンドに残る旧モデル向けのプロンプト記述を監査
    - `OTEL_LOG_TOOL_CONTENT=1` 時の OpenTelemetry `tool.output` スパンイベントに MCP ツール・WebFetch・WebSearch の出力も含めるよう拡張
    - Claude apps gateway にロードテスト用の `load_test_mode` ブロック（リクエストを構築・署名するが上流へ送らず、定形応答を返す）と、Amazon Bedrock の Mantle エンドポイント向け `mantle` upstream provider を追加
    - 全画面モードで他セッションの省略されたメッセージをクリック展開可能に
  - 動作変更
    - サードパーティプロバイダ利用時・テレメトリ無効時の対話セッションは、権限モード未設定だと auto mode で開始するように（`permissions.defaultMode` が優先）
    - 2.1.282 で予約した `claude-ai` という名前の予約を撤回。スキル・コマンド・ワークフロー等がこの名前で再び読み込める
    - `--system-prompt` / `--append-system-prompt` でテキスト指定と `-file` 指定の併用が可能に（ファイルの内容が先に適用）
    - `/model` ピッカーの Opus 行から「(1M context)」表記を削除（コンテキストウィンドウ自体は不変）
    - 自動で付けられた artifact の watch は3.5時間で無活動終了するように
    - `claude plugin eval` は git 2.31 以上を要求するように
  - 主な修正
    - MCP: バックグラウンド移行後のツールで progress 通知が破棄される問題、セッション終了時に stdio MCP サーバが起動中のまま残留する問題、stateless リモート MCP の一時的 404 でそのサーバがセッション中ずっと使用不能になる問題を修正。`/mcp` のツールリストも一覧性・マウス操作に対応して改善し、組織にブロックされたツールに警告アイコンを表示
    - MCP ツールが返す画像もファイルに保存され、Bash や Read から開けるように
    - プラグイン関連を大幅修正: `claude plugin validate` の検出漏れ（名前・パス検査）、`plugin details` の MCP サーバ数 0 表示、大文字小文字違いのプラグイン ID を `uninstall` が誤って削除する問題、`installed_plugins.json` の破損時の復旧など
    - vim mode・keybindings の修正（`.` リピート、`J` の挙動、1万字超プロンプトのカーソル位置、`ctl+k` のような誤字モディファイアの検知など）
    - `DISABLE_TELEMETRY` / `DO_NOT_TRACK` 設定時に有料プランで Remote Control が使えなくなっていた問題を修正
    - git リポジトリのサブディレクトリで起動した際、auto-memory の自分のメモ編集が機密ファイル書き込みとしてブロックされる問題を修正
    - worktree チェックアウト時の証明書検証（Git LFS 等）と、サンドボックス内 git がプロキシ認証情報を保存しようとする問題を修正
    - Windows: PowerShell ツールが `cmd /c rd` / `rmdir` / `del` 経由で `Remove-Item` が拒否するドライブルートやホームフォルダを削除できてしまう問題を修正
    - 起動と初回応答の高速化: `claude -p` と Claude Code Remote が対話 UI を読み込まなくなり、正規表現コンパイルや API 接続の再利用を見直し
    - [VSCode] 権限モード表示と実際のモードの不一致、Web からのセッション引き継ぎ時のメッセージ欠落、再読み込み後の表示崩れなどを修正
    - [Cloud sessions] 実行中セッションへのリポジトリ追加で読み取り専用のプライベートリポジトリもアタッチ可能に。サーバ再起動後のステップ再実行（重複コメント・重複 push）を修正
    - [Claude Tag] 「Channels Claude can search」管理者設定を追加（Slack 検索を追加済み公開チャンネルに限定）。重複返信やチャンネル ID 変更後のルーチン停止などを修正
    - [Code Review] GitHub が PR を返せない際に `@claude review` が無反応になる問題を修正（1回リトライ＋失敗時コメント）。時間制限で止まった未検証レビューは未完了表示で課金しない

## マイナーリリース

（該当なし）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
