# Claude Code Changelog - 2026-09-19

> 対象期間: 2026-09-18 〜 2026-09-19（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.277（2026-09-18）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.277
- **概要**: CLAUDE.mdが存在しないプロジェクトでAGENTS.mdを読むフォールバック対応を追加した大型リリース。Claude apps gateway向けにegress境界プロキシ設定と upstreamへの静的ヘッダー指定が加わり、非推奨だったTaskOutputツールを削除。`claude -p`・SDKのハングや`~/.claude.json`の不正値による起動クラッシュなど、多数の安定性修正を含む。
- **主要変更**:
  - 追加: AGENTS.mdサポート — CLAUDE.mdがないプロジェクトではAGENTS.mdを代わりに読む。切替は`/config`の「Project instructions」（Bedrock / Vertex / Foundryでは未対応）
  - 追加: `CLAUDE_GATEWAY_PROXY_IS_EGRESS_BOUNDARY=1` — egressがフォワードプロキシのみのClaude apps gateway向けに、外向きリクエスト全てでホスト名をローカル解決せずプロキシへ渡す
  - 追加: Claude apps gateway upstreamへの任意の`headers:`マップ（プロバイダー前段プロキシへの静的ヘッダー送信）
  - 削除: 非推奨のTaskOutputツール。背景タスクの出力はReadで読む方式に統一され、`taskOutputMaxChars`設定と`TASK_MAX_OUTPUT_LENGTH`は無効化
  - 動作変更: サブエージェントの結果を「サブエージェント出力」であることを示すヘッダー付き・インデント付きでmain agentへ届けるよう変更（結果内のテキストがセッション自身の指示になりすますのを防止）
  - 動作変更: Bedrock / Vertex / Foundry上のworkflowスクリプト`agent()`プロンプトは「スクリプトが書いたテキスト」として枠付けされ、safety classifierがユーザー発話と誤認しないように
  - 修正: `claude -p`・Agent SDKセッションが内部エラー後に結果なしでハングする問題 — エラーを報告して終了コード1でexit
  - 修正: `~/.claude.json`の不正な`customApiKeyResponses` / `theme` / `claudeAiMcpEverConnected`値による起動ハング・クラッシュ
  - 修正: Editツールがエスケープ済みバックスラッシュ+`uXXXX`を`\uXXXX`エスケープと誤解釈する問題、Writeツールがターゲットパスがディレクトリの場合に黙って権限拒否扱いでturn終了する問題、Grep / Globがリソース枯渇時に「一致なし」を返す問題
  - 修正: `sandbox.excludedCommands`のglobで複合Bashコマンド全体がサンドボックス免除になる問題（一部だけマッチしても全体は免除にしない）
  - 改善: プロンプト内の不可視Unicode書式・タグ文字を除去し、送信前にクリーニング済みプロンプトを確認表示
  - 改善: 危険な`rm`コマンドの権限プロンプトが該当コマンド名と`${VAR:?}`ガードを提示（headless実行でもリカバリ可能）
  - 改善: SDK・headless（`-p`）起動の初回turnがディレクトリ毎のCLAUDE.mdルックアップを待たないように
  - 変更: FableがAnthropic APIの`/model`に常に表示（組織設定で無効時のみグレーアウト）
  - 削除: SDK・IDE外で起動した`claude -p`実行でのバックグラウンドHaiku自動タイトル生成リクエスト
  - VS Code: エージェントマップに背景シェル等の実行中タスクを表示（Stop付き）+ typed `/tasks`、パネルメニューにSign out、レスポンスにCopy responseボタン + typed `/copy`、Account & usageダイアログにセッションのコスト・トークン使用量（Vertex / Bedrock / Foundry / APIキー時）
  - Claude Code on the web: 環境ピッカーにPersonal / Organizationセクション（Team・Enterprise）。管理者が個人環境を組織へ共有可能に

### v2.1.276（2026-09-18）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.276
- **概要**: 2.1.275の回帰修正のみのリリース。`ANTHROPIC_BASE_URL`がプロキシやgatewayを指す場合に全リクエストが`400 … Input tag 'advisor_20260301'`エラーで失敗する問題を修正した。
- **主要変更**:
  - 修正: `ANTHROPIC_BASE_URL`がプロキシ・gatewayを指す構成で全リクエストが`400 … Input tag 'advisor_20260301'`で失敗する問題（2.1.275回帰）

## マイナーリリース
- （該当なし）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
