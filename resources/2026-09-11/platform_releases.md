# Claude Platform Release Notes - 2026-09-11

> 対象期間: 2026-09-10 〜 2026-09-11（2日分）／取得元: https://platform.claude.com/docs/en/release-notes/overview

## 今回の対象エントリ

### 2026-09-10 - Managed Agents権限ポリシーに`auto`評価を追加、`ant` CLIに`ant beta:sessions connect`
- **URL**: https://platform.claude.com/docs/en/release-notes/overview
- **概要**: Claude Managed Agentsの権限ポリシーに新しい`auto`モードが追加された。サーバー側がエージェントおよびMCPツール呼び出しを1件ずつ評価し、実行・拒否・承認待ちのいずれかを自動判定する。あわせて`ant` CLIに`ant beta:sessions connect`が追加され、ターミナルからManaged Agentsセッションへの接続・操作が可能になった。
- **破壊的変更**: なし
- **詳細**:
  - Managed Agents権限ポリシーに`auto`を追加: サーバーが各エージェント/MCPツール呼び出しを評価し、実行（run）・拒否（deny）・承認待ち（pause）を決定する
  - `agent.tool_use`イベントと`agent.mcp_tool_use`イベントに`evaluation`フィールドが追加され、`evaluated_permission`と並んで各呼び出しがどう評価されたかを報告する
  - ドキュメント: Let the server evaluate each call with `auto`（`/docs/en/managed-agents/permission-policies#let-the-server-evaluate-each-call-with-auto`）
  - `ant` CLIに`ant beta:sessions connect`を追加: ターミナルをManaged Agentsセッションにアタッチし、セッションのライブ追跡、メッセージ送信、承認待ち中のツール呼び出しの許可・拒否が可能
  - `--web`オプションを付けるとClaude Consoleのセッションビューアをローカルにサーブし、ターミナルではなくそちらでセッションを開ける（`/docs/en/cli-sdks-libraries/cli/sessions-connect`）

## 備考
- 取得時点で2026-09-11付のエントリは未掲載（ページの最新エントリは2026-09-10、次は2026-09-03）

## Source References
- Claude Platform Release Notes: https://platform.claude.com/docs/en/release-notes/overview
