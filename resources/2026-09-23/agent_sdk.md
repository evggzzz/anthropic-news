# Claude Agent SDK Changelog - 2026-09-23

> 対象期間: 2026-09-22 〜 2026-09-23（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.280（2026-09-22）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.280
- **概要**: スケジュールタスクやMCP Apps連携などホスト側制御まわりの機能追加が中心のリリース。プロンプトをそのまま渡す新オプションや、実行中ターンを参照できるようになった`askSideQuestion()`の改善も含む。Claude Code v2.1.280にパリティ。
- **主要変更**:
  - タスク通知オリジンにオプションの`fireReason`を追加。ローカルホストが宣言したスケジュールタスクの起動は、`CLAUDE_CODE_HOST_SCHEDULED_RUN=1`付きで起動されたプロセス内でのみカウントされる
  - `verbatimPrompts`オプションを追加。プロンプトが入力どおりそのままClaudeに届く（`@path`展開・スラッシュコマンド・アンビエント添付をすべてスキップ。Claude Code 2.1.248+が必要）
  - `mcpServerStatus()`のツールエントリに`_meta`を追加し、各ツールのMCP Apps `ui`メタデータ（`ui://`リソースの場所）をホストから参照可能に
  - MCP Appsの`ui://`リソースをClaude Code接続済みのMCPサーバーから読む`readMcpResource()`（alpha）を追加
  - `askSideQuestion()`を改善。ターン中に質問した場合、直前に完了したターンだけでなく実行中ターン（プロンプト・返信・ここまでのツール結果）を参照できるように
  - 無人実行のリトライ（`CLAUDE_CODE_RETRY_WATCHDOG`）改善。usage-limit待ちの開始時に`rate_limit_event`（`rejected` / `resetsAt`）を送出し、サブエージェントの待機中も`api_retry`ハートビートを継続
  - `session_state_changed`イベント（`CLAUDE_CODE_EMIT_SESSION_STATE_EVENTS=1`でオプトイン）が、MCP elicitationのユーザー待ちで`requires_action`を報告するよう変更（パーミッションプロンプトと同挙動）
  - ヘッドレスセッションで、MCPサーバーの保留中フォーム質問を、それを引き起こしたツール呼び出しの終了時にキャンセルするよう変更
  - Claude Code v2.1.280にパリティ更新

## Python SDK

## 対象バージョンなし
対象期間内の新しいリリースはありませんでした。（最新はv0.2.156・2026-09-18で前回分として処理済み）

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
