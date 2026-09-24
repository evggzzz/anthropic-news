# Claude Code Changelog - 2026-09-24

> 対象期間: 2026-09-23 〜 2026-09-24（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.281（2026-09-23）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.281
- **概要**: 大型リリース。`settings.json` でコミット/PRの帰属表記をまとめて非表示にできる `"attribution": false` が追加されたほか、Claude apps gatewayの設定が拡張（Bedrock上流での `assume_role` / `guardrail` / `telemetry.resource_attributes` など）。MCPではURL-mode elicitation対応と `claude plugin validate` のMCPサーバーチェック追加、セッション再開時の履歴不整合やプロキシ切断時の応答扱いなど安定性修正が多数入った。安全性面では、コマンド置換のみを対象にした再帰 `rm` が無確認で実行される問題の修正が目玉。
- **主要変更**:
  - 新設定: `settings.json` の `"attribution": false` で全コミット/PR帰属を非表示に（旧CLIはこの設定を含むファイルをスキップするため、共有ファイルではオブジェクト形式を維持）
  - Claude apps gateway: Bedrock上流に `assume_role`（STS経由でIAMロールとして呼び出し、別AWSアカウント・開発者ごとのセッションも任意）と `guardrail: {id, version}`（全リクエストにAmazon Bedrockガードレール適用）を追加。`telemetry.resource_attributes` でテレメトリに固定ラベル付与、`desktop` ポリシーブロックで `blockReadsOutsideWorkingDirectories` / `disableBypassPermissionsMode` に対応
  - MCP: URL-mode elicitation対応（2026-07-28以降のプロトコル接続で、サーバーがブラウザベースフローを要求可能に）。`claude plugin validate` が `.mcp.json` の読み込み時に黙って破棄されるエントリや未宣言の `${user_config.*}` 参照、非安全URLを検出
  - `/insights` にauto modeの推奨表示: 直近セッションでauto modeが処理できたはずの許可プロンプト数を推定
  - セキュリティ修正: `rm -rf "$(pwd)"` のようなコマンド置換のみの再帰 `rm` がauto mode / `--dangerously-skip-permissions` で無確認実行されていた問題を修正（Bash許可ルールがあっても確認を求める。`CLAUDE_CODE_DISABLE_SUBSTITUTION_RM_PROMPT=1` で無効化）。危険な `rm` プロンプトは2分待機後に拒否へ変更（`CLAUDE_CODE_DISABLE_DANGEROUS_RM_TIMEOUT=1` で無効化）。`/.vol` など特殊パスの権限チェック漏れも修正
  - 動作変更: send now（ctrl+enter または ctrl+x ctrl+s）がターンをキャンセルせず実行中ツールをバックグラウンドへ移行するように。サーバー側分類器でauto modeを動かす場合、read-only/sandboxedコマンドもレビュー結果を待つように。`CLAUDE_CODE_AUTO_MODE_SERVER` が直接Anthropic API接続にも適用可能に（`0` でオプトアウト）
  - 安定性: セッション再開時の履歴不整合（並列tool-callターンやMCPツール入力の再送でAPIがprior reasoningを破棄する問題）、巨大セッション再開時のメッセージ欠落、プロキシ/ゲートウェイ切断時に応答が完了扱いになる問題、`--max-turns` 無視の無限リトライなどを修正
  - パフォーマンス: 起動時の最初のフレーム前処理を削減（git読み取り・起動テレメトリ・Bedrock/Vertexチェック）、長い/コンパクト済みセッションの再開を高速化、3MB超PDFの応答遅延（最大2分）を修正
  - UI: `/skills`・`/mcp`・`/plugin` のInstalledリストにスクロールバー追加、vim modeの `dj`/`dk`/`cw` 等の動作修正、ダイアログでのCtrl+C/Ctrl+D二押しによる誤終了を修正、キュー済みメッセージの表示位置をスピナ上に変更
  - その他: `--agents` がJSONファイルパス受付に対応、`/batch` がWorktreeCreateフック提供のworktreeで動作、セルフホストランナーのシステムプロンプトをファイル渡しに変更（`--system-prompt-file` / `--append-system-prompt-file` への移行が必要）、コマンドメニューに残っていた "(removed)" の `/agents` エントリを削除
  - 周辺: VS Code（auto modeのフォールバック時Continue/Stopプロンプト追加、セッション復元修正）、Claude Code on the web（Fast modeスイッチ、GitHubトリガーのルーチン修正）、Claude Tag/Slack（スレッド内停止通知、応答停止や遅延の多数の修正）

## マイナーリリース
- 該当なし（対象期間内のリリースは v2.1.281 のみ）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
