# Claude Code Changelog - 2026-09-25

> 対象期間: 2026-09-24 〜 2026-09-25（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.282（2026-09-24）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.282
- **概要**: 新設定の追加と大量の修正を含む大型リリース。会話履歴に起因する400エラー、`--continue`/`--resume` 時の extended thinking 消失、権限設定（Bash permission rules・managed settings）まわりの不具合など、実用上の影響が大きい修正が複数入った。動作変更として、テレメトリ無効の直接 API 接続では Auto mode がサーバー側 classifier をデフォルトで使うようになった。VS Code・クラウドセッション・Slack（Claude Tag）の修正も含む。
- **主要変更**:
  - 新設定 `maxProseWidth` でワイド端末での文章幅を上限化（表・コードブロックは従来どおり全幅）
  - 無視された・テレメトリを無効化するプロジェクト設定の変数を、起動時通知と `/status`・`claude doctor` に表示
  - managed 設定 `allowClaudeInChromeWithManagedMcp` を追加（排他的 `managed-mcp.json` との併用で `claude --chrome` を許可）
  - web search 結果を復号できない履歴を含む会話で毎リクエスト400エラーになる問題を修正
  - `--continue`/`--resume` セッションで過去メッセージが改変されて再送され、Claude の過去の推論が API 側で破棄される問題を追加修正
  - 「Invalid `data` in `redacted_thinking` block」エラーの解消。thinking blocks を落として1回リトライする
  - `/model` などのスラッシュコマンド実行時や、`--tools` 指定付きでの再起動時に extended thinking が失われる問題を修正
  - summarization リクエストが拒否された場合に fallback model でリトライするよう修正
  - Bash permission rules の中間に `:*` を含むパターンが設定ファイルで無視される問題を修正
  - managed settings の1つの不正なネスト値で `permissions`・`autoMode`・`worktree`・`attribution` ブロック全体が無効化される問題を修正
  - 非常に大きいセッションの resume を高速化（未コンパクションのセッションを含む）
  - 動作変更: テレメトリ無効の直接 Anthropic API 接続では Auto mode がサーバー側 classifier をデフォルト使用。`CLAUDE_CODE_AUTO_MODE_SERVER=0` でオプトアウト
  - 動作変更: プロジェクト・ローカル設定の OpenTelemetry 変数（`CLAUDE_CODE_ENABLE_TELEMETRY`、`OTEL_LOG_*` など）を無視するように
  - 動作変更: `Skill(anthropic-skills:*)`・`Skill(claude-ai:*)` の allow ルールを claude.ai 同期スキルのみに限定
  - 動作変更: `sandbox.excludedCommands` が managed settings や `--settings` の `allowUnsandboxedCommands: false` 適用時にはプロジェクト・ローカル設定のエントリを無視
  - Vim mode の多数の修正（`>>` が空行をインデントする問題、`dd` 後のカーソル位置、`2dd` などのカウント指定、折り返し行での `p`/`P`）
  - CJK 文字や絵文字の折り返しで diff の最終列にゴミが残る描画問題を修正
  - `/install-github-app` がキャンセル扱いでもブランチ push と API key secret の保存を続行する問題を修正
  - プラグインアンインストール時に保存済み options や secrets を誤って削除する問題を修正
  - [VS Code] 長い返信でストリーミングが lag する問題（パネルが毎回全文を再パースするため）や、Remote Control セッションが Web エントリから開けない問題などを修正
  - [Cloud sessions] GitHub App の状態を Settings › Connectors › GitHub に表示。インドなど30分オフセットの時間帯で routine の次回実行時刻が30分ずれる問題を修正
  - [Claude Tag / Slack] Enterprise Grid でのチャンネル自動参加パターンが無視される問題、引退済みモデルへのフォールバックが毎返信繰り返される問題、cloud worker 再起動後にコスト・トークン表示が倍増する問題などを修正

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
