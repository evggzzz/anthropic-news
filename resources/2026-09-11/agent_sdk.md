# Claude Agent SDK Changelog - 2026-09-11

> 対象期間: 2026-09-10 〜 2026-09-11（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.268（2026-09-10）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.268
- **概要**: resultメッセージの配信順を示す `result_index` や、ホスト再起動で中断されたターンの自動再実行を示す `resume_reason` など、実行結果のトレース性を高めるフィールドが相次いで追加された。プロンプトキャッシュを無効化するプラグインリロードを保留する `hold_on_cache_impact`、`canUseTool` の挙動ヒントも新設されている。注意点として、タスク管理ツール（TaskCreate等）が既定ツールになるモデルが Claude 3.x ・ Opus 4.0〜4.7 ・ Sonnet 4.0〜4.6 ・ Haiku 4.5 に限定され、それ以外では `tools`/`allowedTools` への明示指定が必要になった。
- **主要変更**:
  - Added `result_index` to result messages: the result's position in delivery order within the run, from 0
  - Added `local_command` to the result message of a turn that ran a slash command without entering the model loop, carrying the command's name
  - Added `hold_on_cache_impact` to the `reload_plugins` control request (`Query.reloadPlugins({ holdOnCacheImpact: true })`): holds a reload that would invalidate the session's prompt cache
  - Added `resume_reason` to assistant, stream-event and result messages, set only on the automatic re-run of a turn a host restart interrupted
  - Added `kind` (used, free, buffer, deferred) to each category in the `get_context_usage` control response, matching the `/context` result's `context_usage` rows
  - Added optional `defaultToNo` and `suppressAlwaysAllowRule` hints to `canUseTool` options: the prompt should open on its decline option, or offer no persistent "always allow" choice
  - Changed `setModel()` to confirm a model id the CLI doesn't know locally with the API the first time a session uses it, instead of refusing it as unrecognized
  - Changed `user_message_uuid` on the automatic re-run of an interrupted turn to name that turn's last user prompt
  - Changed the `initialize` success response to always include `pending_permission_requests` (empty when nothing is pending), so clients can tell that apart from an older CLI
  - Changed the task-tracking tools (TaskCreate/Get/Update/List, TodoWrite) to be default tools only on Claude 3.x, Opus 4.0–4.7, Sonnet 4.0–4.6 and Haiku 4.5; elsewhere list them in `tools`/`allowedTools`
  - Updated to parity with Claude Code v2.1.268

## Python SDK

### 対象バージョンなし
対象期間内の新しいリリースはありませんでした。最新は v0.2.152（2026-09-02、収集済み）で、今回の対象期間に入るリリースはありません。

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
