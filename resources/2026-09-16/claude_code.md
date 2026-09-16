# Claude Code Changelog - 2026-09-16

> 対象期間: 2026-09-15 〜 2026-09-16（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.273（2026-09-15）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.273
- **概要**: ゲートウェイ向けのヒンターヘッダー、MCPサーバー切断時の通知、Claudeアプリからのリモートコントロールセッションのフォークなどが追加された。セキュリティ関連の重要な修正として、`permissions.blockReadsOutsideWorkingDirectories` の回避や危険な `rm` を隠すサブシェルなど権限チェックの穴が複数塞がれている。また2.1.268で導入された解析不能なBash行の拒否動作が revert され、`time -p make build` が再度プロンプトを表示するようになった。
- **主要変更**:
  - ゲートウェイ向けヒンターヘッダー（`x-claude-code-request-class`、エージェント種別、ツール実行時間、compaction）を追加。`CLAUDE_CODE_GATEWAY_HINT_HEADERS=1` で opt-in
  - MCPサーバーが切断され再接続に失敗した際に `/mcp` への導線付きで通知
  - `--remote-control` セッションを Claudeアプリからフォーク可能に。フォークはローカルのバックグラウンドで実行
  - 修正: `permissions.blockReadsOutsideWorkingDirectories` 下で解析不能なBashコマンドがプロンプトをスキップする問題、危険な `rm` を隠すサブシェル
  - 修正: 組織全体の Skills 無効化後も claude.ai 同期スキルが残る問題（回復可能なゴミ箱へ移動）
  - 修正: Bedrock / Vertex / Foundry での 401/403 エラーが誤って `/login` を案内する問題。メッセージが資格情報またはゲートウェイ管理者を明示するように
  - 修正: `/login`、`/upgrade`、`/extra-usage` がそれまでの thinking を破棄しキャッシュを書き直す問題
  - 修正: サブエージェントが最終応答に usage データや model id を含まない場合に失敗扱いになる問題
  - 修正: advisor ツールのターンが倍のサイズでカウントされ早期 auto-compact を引き起こす問題
  - 修正: `scheduled_tasks.json` コピー後に定期タスクが誤ったセッションで実行される問題
  - 修正: SDK / stream-json 出力で実行中のバックグラウンド化後にサブエージェントのメッセージが欠落する問題
  - revert: 2.1.268 の「解析不能なBash行の拒否」を取り消し。`time -p make build` が再びプロンプト表示
  - 長時間セッションの高速化: フックとサブエージェントの更新で全体の再処理をスキップ
  - 変更: Bedrock / Vertex / Foundry 上の auto mode をローカル分類器に変更。`CLAUDE_CODE_AUTO_MODE_SERVER=1` でサーバー側に戻す
  - `OTEL_LOG_TOOL_DETAILS=1` が実際のエージェント・スキル・プラグイン・MCP 名を含むように
  - Windows: マップドライブ併用時の UNC パス検査を改善
  - [VSCode] 組織でフィードバックが無効な場合に "Report a problem" が表示される問題、Windowsでの赤い終了コードバナーを修正
  - [Web] ルーチン接続消失や中途作成の環境を修正、「Share cloud sessions」を Data and privacy 配下へ移動、ダウンロード壁を撤去、ルーチン詳細ページを再デザイン
  - [Claude Tag] 再インストール後の沈黙、定期タスクの黙示的失敗、スレッド再開時の作業消失などを修正。Claude自身が関連チャンネルを監視、管理者用 Memory ページに自動設定チャンネルを一覧表示
  - [Code Review] ベースマージ時の再レビュー、REVIEW.md 全体無視、位置参照の途切れ、リトライ時の重複投稿などを修正

## マイナーリリース
- v2.1.272（2026-09-15） — バグ修正と安定性向上のみ

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
