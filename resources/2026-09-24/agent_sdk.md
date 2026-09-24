# Claude Agent SDK Changelog - 2026-09-24

> 対象期間: 2026-09-23 〜 2026-09-24（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.281（2026-09-23）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.281
- **概要**: 会話リセット(`conversation_reset`)メッセージに`trigger`・`user_message_uuid`・`timestamp`の各オプションフィールドが追加され、リセットの原因や対応する元メッセージをクライアント側で把握できるようになった。パッケージの軽量化（sdk.mjsが1.47MB→0.97MB）と起動の高速化、`close()`後の権限・ダイアログコールバック残存バグの修正が含まれる。`Settings`型の`attribution`フィールドの型変更は破壊的な影響があり得る。
- **主要変更**:
  - `conversation_reset`メッセージに`trigger`・`user_message_uuid`・`timestamp`の各オプションフィールドを追加。リセットのきっかけの把握、/clearと元メッセージの紐付け、発生時刻の表示が可能に
  - Fixed permission and dialog callbacks still being invoked for requests that arrived after `close()`
  - クエリの`close()`後に行われたコントロールリクエストがハング・リークしないよう修正。キャンセル済みリクエストの再配送後にキャンセルできない権限プロンプトも修正
  - `session_state_changed`が、重なる権限プロンプトとサンドボックスのネットワークアクセスプロンプトの両方に回答しても`requires_action`のまま残る問題を修正
  - sdk.mjs no longer bundles unused dependencies (1.47 MB → 0.97 MB)
  - `createSdkMcpServer`などのin-process MCPサーバーを使う`query()`セッションの起動が高速化。initializeステップがサーバーを最大250msまで待機するように
  - the CLI now answers the host's initialize request before starting its background start-up work
  - 破壊的な型変更: `Settings`型の`attribution`フィールドが`boolean | {...}`に。`attribution.commit`を読むコードは型の絞り込みが必要
  - Updated to parity with Claude Code v2.1.281

## Python SDK

### v0.2.159（2026-09-23）
- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.159
- **概要**: バンドル済みClaude CLIを2.1.281に更新したパッチリリース。CLIの新しいデフォルトモデルに起因するCI失敗を回避するため、e2eテストのデフォルトモデルを`claude-opus-5`に固定した。
- **主要変更**:
  - Updated bundled Claude CLI to version 2.1.281
  - Pinned default model for e2e tests to `claude-opus-5` to work around CI failures with the CLI's new default model (#1287)

### v0.2.158（2026-09-23）
- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.158
- **概要**: `ClaudeAgentOptions`に`verbatim_prompts`オプション（デフォルト`False`）が追加された。有効にするとユーザーメッセージが`@path`のファイル展開やスラッシュコマンドの実行をされずそのままCLIへ渡るため、プロンプトに埋め込まれた信頼できないテキストによる意図しないファイル読み込み・コマンド実行を防げる。バンドルCLIは2.1.280に更新。
- **主要変更**:
  - Added `ClaudeAgentOptions.verbatim_prompts` (default `False`). user messages are delivered to the CLI exactly as written — no `@path` file expansion and no slash-command dispatch
  - untrusted text inlined into prompts による意図しないファイル読み込み・コマンド実行を防止。`query()`、`ClaudeSDKClient.connect()`、`ClaudeSDKClient.query()`で利用可（文字列・非同期イテラブル両対応）
  - Requires CLI 2.1.248+; a warning is logged on older CLIs (#1269)
  - Updated bundled Claude CLI to version 2.1.280
  - CI improvements: recompressed wheels and raised the PyPI pre-flight threshold (#1283)

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
