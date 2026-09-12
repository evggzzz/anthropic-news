# Claude Code Changelog - 2026-09-12

> 対象期間: 2026-09-11 〜 2026-09-12（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.269（2026-09-11）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.269
- **概要**: プラグインの評価をスコア付きで実行する `claude plugin eval` や、出力スタイルの切り替えコマンド `/output-style` を追加した大型リリース。プロンプトキャッシュの部分的な失效や `/goal` のサイレント停止、日本語など単語間スペースのない言語でのプロンプトサジェスト欠落といった長年の問題を多数修正している。VS Code拡張にはエージェントマップ、Hooksダイアログ、権限ルールダイアログが揃い、Claude Tag（Slack連携）も安定性が大きく向上した。
- **主要変更**:
  - 新機能:
    - `claude plugin eval`: プラグインのevalスイートをClaude Code上で実行し、再現可能なスコア付き結果（JSON + HTMLレポート）を取得
    - `/output-style [name]`: 出力スタイルの一覧表示と切り替え。Remote Control・クラウド・headlessセッションでも動作
    - Bashツールがファイル編集を扱った際、変更ファイルのdiffを結果に表示（設定 `bashEditDiffEnabled`）
    - `OTEL_METRICS_INCLUDE_REPOSITORY`: OpenTelemetryのメトリクス/イベントに `vcs.*` リポジトリ属性を付与
    - `CLAUDE_CODE_GATEWAY_MODEL_DISCOVERY_TIMEOUT_MS`: LLMゲートウェイの `/v1/models` 探索タイムアウト延長（デフォルト3秒）
    - `CLAUDE_CODE_WORKFLOW_MAX_CONCURRENT_AGENTS`（1–256）: Workflowツールの同時エージェント数上限を引き上げ可能
    - `/focus`（プロンプトと応答だけのビュー）を提案するスピナーチップ
  - 挙動変更:
    - `!` で始まるdeny/ask権限ルールは、書き込み元の設定ソース内でのみ適用されるよう変更（裸の `!` 否定は無視）
    - Bashの `tee` 先ファイルに `Edit()` denyルールと書き込みパス検査を適用。`Bash(tee:*)` のallowルールでは作業ディレクトリ外への書き込みをカバーしなくなった
    - 帰属表示リマインダーがCLAUDE.mdやメモリの「commit/PRに帰属表記しない」ルールを上書きしないよう修正（managed settingsで設定された行は引き続き有効）
    - クラウドセッションでclaude.aiから同期したスキルは `anthropic-skills:<name>` 形式に命名変更（bare名も他と衝突しなければ有効）
    - `/ultrareview --post` が2つ目のクラウドセッションを起動せず、結果到着時にPRコメントを直接投稿してリンクを表示
  - 重要な修正:
    - 出力トークン上限で打ち切られ自動再開された次のターンでプロンプトキャッシュが部分的に失效する問題を修正
    - `/goal` がAPIエラーやネットワーク断、トークン上限後にサイレントに停止する問題を修正（バックオフ付きリトライ、または理由付きで一時停止）
    - 日本語・中国語・タイ語など単語間スペースなしの言語でプロンプトサジェストが落ちる問題を修正し、日中韓のサジェストフィルタリングも改善
    - 「Prompt is too long」でセッションが恒久的に固まる問題（主に巨大プロンプトのAgent SDKセッション）を修正
    - モデル切り替えやリトライ中に、再開したheadlessセッションがターンの応答を失う問題を修正
    - kittyプロトコル端末のF1/F2/F4、stのDelete、rxvt-unicodeのAlt+矢印、WezTermのShift+句読点（2.1.247でのリグレッション）を修正
    - CMYK JPEGが「cannot decode」で添付失敗する問題を修正
- **VS Code拡張**:
  - エージェントマップを追加: フッターの「N agents」ピルからサブエージェントのマップ（エージェント別カード・Stop agent・読み取り専用トランスクリプト）を開ける
  - Hooksダイアログ（ユーザー/プロジェクト/ローカル設定の閲覧・追加・編集・削除）とPermission rulesダイアログを追加
  - Focusビューで実行中サブエージェントのライブ進捗行を表示
  - ドキュメントやメッセージをユーザー以外の読み手向けに執筆する場合、その読み手を明示して書くよう改善
- **Claude Code on the web**:
  - クラウドセッションでClaudeが読む前にキューのメッセージを取り戻せるように（Escまたは↑でメッセージボックスに復帰）
  - サブエージェントを使うルーティン実行が早まに完了扱いになる問題などを修正

## マイナーリリース
- なし（対象期間内にプレースホルダリリースなし）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
