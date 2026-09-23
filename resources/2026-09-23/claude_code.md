# Claude Code Changelog - 2026-09-23

> 対象期間: 2026-09-22 〜 2026-09-23（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.280（2026-09-22）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.280
- **概要**: 新モデル「Claude Opus 5.5」（`claude-opus-5-5`）を追加し、デフォルトのOpusモデルに据えた大型リリース。Pro・Team StandardプランのデフォルトモデルもSonnetからOpusへ変更された。機能面ではフルスクリーンモードのマウス操作拡大やMCPツール説明文の上限を変える環境変数が追加され、ダイアログ操作まわりのキーボード不具合とシンボリックリンク経由の書き込み判定を中心に多数の修正が入った。VS Code拡張には`/status`・`/sandbox`・`/chrome`・`/export`などの新ダイアログ、Claude Tag（Slack連携）にはWorking表示とStopボタンが加わった。
- **主要変更**:
  - 新モデル: Claude Opus 5.5（`claude-opus-5-5`）を追加し、デフォルトのOpusモデルに変更。1Mコンテキスト、$4/$20 per Mtok、キャッシュ読み$0.20/Mtok
  - Pro・Team StandardプランのデフォルトモデルをSonnetからOpusに変更（Max・Team Premium・Enterpriseと挙揃え）
  - `CLAUDE_CODE_MAX_MCP_DESCRIPTION_LENGTH` を追加。セッション内の全MCPサーバーを対象に、MCPツール説明文とサーバー指示の2,048文字上限を変更できる
  - `hook_execution_complete` OpenTelemetryイベントに、フック出力サイズと保存された oversized 出力の数を追加
  - フルスクリーンモードのリストにマウス対応を拡大。ホイールで`/skills`一覧をスクロール、`/plugin`のスキル状態オプションをクリック可能に
  - シンボリックリンク経由の書き込みをリンク先の実体で判定するよう修正。`acceptEdits`・allowルール・auto modeがツリー外への書き込みを承認しなくなった
  - auto modeの修正: 安全性チェックに拒否されたアクションを再試行し続ける問題を修正（1回で拒否を通知）、無回答時に無制限に拒否し続ける問題もバックオフと10連続で停止する挙動に修正
  - ほぼすべてのダイアログ（`/model`、`/effort`、`/config`、`/status`、`/usage`、`/plugin`、`/sandbox`、`/permissions` ほか）で、Ctrl+C / Ctrl+Dの2回押しがダイアログを閉じずClaude Code自体を終了する問題を修正
  - ダイアログで押した`n`/`y`が確定・キャンセルとして作用する問題を修正。Enter=確定、Esc=キャンセルに統一（`keybindings.json`で`confirm:yes`/`confirm:no`に割り当てれば旧挙動に戻せる）
  - 「role 'system' must precede an 'assistant' message」エラーで毎ターン会話が失敗する問題、アドバイザー非対応のプロキシ/ゲートウェイ背後でAPI Error 400が出る問題（アドバイザー無しでリトライ）を修正
  - バックグラウンドサブエージェントの修正: ヘッドレス/SDKセッションで送信メッセージが消失、起動元の会話がコンパクションされると完了レポートが失われる、LSPプラグイン有効時にLSPツールを使えない問題など
  - 2.1.260で追加されたフルスクリーン時の`ctrl+l` / `cmd+k`によるトランスクリプト表示クリアを取り消し（再び画面再描画の動作に戻した）
  - `/permissions`改善: ルール閲覧・追加・削除後にフォーカスがルール一覧へ戻り、削除確認のデフォルトがNoに。←/→やTabでタブを直接切り替え可能に
  - 旧モデル向けに保存されたeffortレベルが、Opus 5.5などの新モデルには適用されないよう変更（デフォルトから開始）
  - VS Code: `/status`・`/sandbox`・`/chrome`・`/export`・`/skills`・`/plan`の各ダイアログを追加。Python拡張がアクティベーション中にハングしてもClaude Codeが起動しない問題を修正（60秒後に起動）
  - Claude Code on the web: GitHub Enterprise Serverリポジトリのクラウドセッションで約8時間後に`gh`やGitHub API呼び出しが失敗する問題を修正（トークン自動更新）。管理者のRoutines設定をAdmin settings → Capabilities → Remote sessionsへ移動
  - Claude Tag（Slack）: チャンネルのSlackスレッドにWorking表示・Stopボタン・スレッドタイトルを追加。Stopでタスクを中断できる

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
