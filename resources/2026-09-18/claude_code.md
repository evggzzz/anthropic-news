# Claude Code Changelog - 2026-09-18

> 対象期間: 2026-09-17 〜 2026-09-18（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.275（2026-09-17）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.275
- **概要**: 大型リリース。claude.ai アカウントで有効化した skills / plugins をターミナルセッションへ同期する機能、メッセージ一括送信の新キー、Claude apps gateway サインイン時のアカウント確認フローを追加。セッション復帰（`--resume` / `--continue`）まわりのクラッシュや transcript 破損への耐性強化が中心。VSCode 拡張にも多数の追加・修正がある。
- **主要変更**:
  - 追加: claude.ai アカウントで有効化された skills と plugins を、そのアカウントでサインインしたターミナルセッションへ同期（オプトアウト: `syncClaudeAiSkills: false` / `syncClaudeAiPlugins: false`）
  - 追加: send-now キー（ctrl+enter または ctrl+x ctrl+s）— 現在のターンを中断し、キュー済みメッセージを一括送信。送信済み・キュー中メッセージはグレー表示
  - 追加: `/plugin install <plugin> --marketplace <source>` — marketplace 未追加なら追加を提案してからインストール
  - 追加: Claude apps gateway サインインで、gateway が示すサインインアカウントを保存前に確認。`/status` にも表示
  - 追加: `otelHeadersHelper` が失敗した際の起動警告（テレメトリが黙って空になるのを防止）
  - セキュリティ: npm ソースのプラグインを `npm pack --ignore-scripts` で取得し整合性検証 — パッケージの install script を実行しない
  - セキュリティ: git / ssh / marketplace URL に含まれるパスワードやトークンをメッセージ・ログ・`claude plugin marketplace list` に表示しない
  - 変更: Claude in Chrome の auto モードが classifier 承認呼び出しの per-site check をスキップ（bypass モードと同様）— リダイレクト後の `browser_batch` "Permission denied" を修正
  - 変更: Artifact tool は初回 publish 時に emoji favicon ではなく1語のタブアイコンを尋ねる
  - 変更: `/logout` がトークン失効に対応した gateway ではセッションも終了
  - 修正: memory ファイル復元後の age note が compaction / resume 前後で変化し prompt cache miss を起こす問題
  - 修正: `--resume` / `--continue` / resume picker が、malformed な task-reminder・@-file・メッセージエントリを含むセッションで失敗・クラッシュする一連の問題
  - 修正: forked / background セッションでの `/rewind` がバックアップコピー失敗時にゼロ埋め・欠損ファイルを復元する問題
  - 修正: `/update-config` がファイル権限チェックに一致しない `Write(path)` ルールを書く代わりに `Edit(path)` を書くように
  - 修正: `--resume` / `--continue` が、セッション開始時に有効だった組み込みツールがサーバ側フラグで無効化されると以前の thinking を落とす問題
  - 改善: `__SYSTEM_PROMPT_DYNAMIC_BOUNDARY__` を含む `--system-prompt` のプロンプトキャッシュ（境界より上がグローバルにキャッシュされる）
  - VSCode: Memory dialog 内で保存済みメモリの閲覧・編集・削除、変更差分タブの変更ごと accept / reject ボタン、画像のみ添付送信、`claudeCode.scrollToBottomOnSend` 設定を追加
  - VSCode: リロード後も権限モード・プロンプトキャッシュ時計・バックグラウンドエージェント完了通知を保持するよう修正（regression in 2.1.269 のセッション名リネーム問題も修正）
  - Claude Code on the web: ルーチン関連の通知文・cloud environment の allowed-domains リスト検証を改善
  - Claude Tag: アクセスバンドルの attach 条件、CloudWatch / SNS / Google Cloud Monitoring などのCredentials プリセット、Datadog US3 / AP1 / AP2 / US1-FED 対応を追加
  - Code Review: 100 件超のレビューがある PR のマージ時再レビューを軽量化

### v2.1.274（2026-09-17）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.274
- **概要**: 運用・可観測性系の追加が中心。メモリ使用量クリティカル時の警告、MCP 起動待ち時間の上限設定、OpenTelemetry 事件の拡充。"unexpected tool_use_id" 400 エラーの無限リトライなど、長時間稼働・MCP 接続まわりの修正が多数。
- **主要変更**:
  - 追加: メモリ使用量が危険域に達した際の警告表示と、解放・安全な再起動の手順
  - 追加: `CLAUDE_CODE_MCP_STARTUP_WAIT_MS` — 初回非対話ターンの MCP 接続待ち上限（`0` で待機しない）
  - 追加: `claude_code.llm_request` OTel span に `effort` 属性
  - 追加: `claude_code.managed_settings_resolved` OTel イベント（`OTEL_LOG_MANAGED_SETTINGS=1` で redacted 設定とダイジェストを出力）
  - 追加: Claude apps gateway 設定 `store.connect_timeout_seconds`（Postgres 接続タイムアウト、デフォルト5秒）
  - 追加: フルスクリーンで折りたたまれた teammate / agent メッセージのクリック展開
  - 変更: Bedrock / Vertex / Foundry・テレメトリ無効インストールがデフォルトで v2 MCP クライアント + MCP 2026-07-28 ネゴシエーションを使用（オプトアウト: `MCP_SDK_GENERATION=v1` または `MCP_PROTOCOL_NEGOTIATION=legacy`）
  - 変更: `/code-review` が個別チューニング設定のないモデルでは多数の review subagent ではなく leaner inline review prompts を使用
  - 変更: `.mcp.json`・settings・plugins・agent files の `"type": "sdk"` MCP エントリを警告付きでスキップ（SDK ホストアプリのみ登録可能）
  - 変更: plugin / marketplace のクローンは Git LFS ファイルをポインタのままに（`git lfs pull` で取得）
  - 修正: 破損 transcript による "unexpected tool_use_id" 400 の無限リトライ — 可能なら自己修復、不可能なら `/rewind` ヒント付きの明確なエラーで停止
  - 修正: MCP 関連 — legacy HTTP+SSE サーバが 4xx を返すと接続失敗する問題、Streamable HTTP の約5分タイムアウト（per-server `timeout` を尊重）、403 insufficient_scope を期限切れと誤表示する問題、`listChanged` 未宣言サーバの prompts / resources 更新
  - 修正: `claude agents` が auto-update 再起動後に `--model` / `--effort` / `--permission-mode` / `--allow-dangerously-skip-permissions` / `--agent` を失う問題
  - 修正: compaction 済みセッションの resume で有効な `/goal` が失われる問題、hook 駆動セッションの "Prompt is too long" で compact されない問題
  - セキュリティ: `${VAR}` プレースホルダ解決後のシークレットを MCP 接続エラー・ログに表示しない。特殊シェル変数へのループ・代入を含む Bash コマンドが権限を要求。worktree 分離セッションでネストされたシェル展開を拒否
  - 改善: `--input-format stream-json` の初回ターンが接続中 MCP を最大2秒待たない。headless / SDK セッションの background task 完了応答を1呼び出しに集約
  - VSCode: リロードで中断されたステップの継続（Claude Code: Continue After Reload 設定で無効化可）、Customize メニューに Memory / Instructions エントリ、`claudeCode.lockEditorGroups` 設定を追加
  - VSCode: `~/.claude/settings.json` の書き込み競合による破損・設定消失、High Contrast テーマのコード可読性などを修正
  - Claude Code on the web: diff ビューの "Compare against" ブランチピッカーを追加。ルーチンは GitHub 接続欠落時に最大72時間リトライするように変更
  - Code Review: 一時的な GitHub / 内部サービス障害時に待機・リトライ、finding 文言を簡潔化

## マイナーリリース
- 該当なし（対象期間内の2リリースはいずれも本文記載の実質的な変更を含む）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
