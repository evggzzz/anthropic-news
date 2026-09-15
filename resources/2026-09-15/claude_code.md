# Claude Code Changelog - 2026-09-15

> 対象期間: 2026-09-14 〜 2026-09-15（2日分）／取得元: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md

## 今回の対象バージョン

### v2.1.271（2026-09-14）
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.271
- **概要**: 大規模な機能追加リリース。Claude Code Remoteセッションでのfast mode対応、フルスクリーン`/config`パネルのマウス操作対応、auto modeサンドボックスでのコマンド単位の`allowed_domains`、subagent用の`omitClaudeMd`設定などが加わった。Bash権限チェックの複数の抜け穴、MCP OAuthのクライアント登録破壊、`--resume`時の1Mコンテキスト(`[1m]`)喪失など、多数の修正も含む。
- **主要変更**:
  - **fast mode（Remoteセッション）**: クラウド・セルフホストランナーの両方で、ホストのfast-mode設定またはセッション内の`/fast`が組織が許可する範囲で適用される
  - **`/config`パネルのマウス対応**（フルスクリーン）: ホイールで設定リストをスクロール、値クリックで変更、ポインタ下の行をハイライト
  - **コマンド単位の`allowed_domains`**: auto mode + サンドボックスのBash / PowerShell / Monitorで、コマンドが必要とするホストのみをレビュー伴いで開放し、他は拒否
  - **`omitClaudeMd`**: agent frontmatterと`--agents` JSONに追加。カスタム・プラグインsubagentをCLAUDE.md群なしで動かせる（managed policyは引き続き読み込まれる）
  - **`claude self-hosted-runner --drain-marker-file <path>`**: SIGTERMドレイン時にファイルが存在すれば host drain として報告（テレメトリのみ）
  - **`claude plugin install/update --accept-command <sha256>`**: `--json`実行が表示したコマンドを正確に受け入れる指定が可能に（`-y`の代替）
  - **`modelPricing`とgateway `pricing`ブロックに`multiplier`（最大10）**: 加算済み内部チャージバックレート用
  - **auto modeの権限扱い変更**: スキル・スラッシュコマンド内のインライン`!`シェルコマンドが分類器ではなくデフォルトモードの権限ルールに従うように
  - **subagentの報告経路変更**: 最後のメッセージの事後レビューから、safty classifierがレビューする専用のhand-back呼び出しに変更
  - **Monitorウォッチに必ずデッドライン**: 最大30分（`-p`実行では10分）でClaudeへの再設定通知へ。タイムアウトなしの`persistent`オプションは廃止
  - **dynamic workflow**: 既定サイズがProプランでsmallに、mediumの目安が15から10エージェントに。使用制限到達時はエージェントを落とさず一時停止して復帰時に再開
  - **主な修正**:
    - アカウント・組織・APIキー切替後もキャッシュされた組織ポリシーが再利用され、資格情報変更時に更新されない問題
    - 読めない・パースできない企業の`managed-mcp.json`が無視される問題（排他的MCP制御を維持し起動時に警告）
    - ワークフロー・エージェント承認適用後にクラウドセッションの全subagentツール呼び出しが"updatedInput … failed schema validation"で失敗する問題
    - Bash権限チェックの抜け穴3件（`fmt`/`column`等の読むファイル、ワイルドカード展開先、シェル変数宣言フラグによる偽装）
    - MCP OAuthのクライアント登録破壊（同意拒否・redirect URI不一致・競合書き込みで有効登録が消える）
    - `--resume`で再開セッションのモデルファミリーが既定と異なる場合に1Mコンテキスト(`[1m]`)が落ちる問題
    - `/resume`・`/teleport`が前会話のファイル既読追跡を引き継ぎ、未読ファイルを編集できる問題
    - 圧縮（compaction）後も実行中のバックグラウンドコマンドの2重起動
    - ホスト設定ディレクトリが64 MiB超でセルフホストランナーの設定が黙って失われる問題（`--host-config-snapshot disk|memory`追加）
    - Windows: 一時パスが260文字に達するとPowerShellコマンドが"Exit code 1"で失敗する問題
  - **パフォーマンス・UX改善**: 大きなdiffと長いトランスクリプトの描画高速化、フック実行中のスピナー表示（経過時間付き）、`claude mcp serve`が実行中ツール呼び出しを30秒ごとに進捗報告、Markdownアーティファクトのスタイル付きドキュメント表示、アーティファクト監視上限5→10
  - **VSCode**: Attach Open File設定を追加。Hooks/Permissionダイアログの保存失敗報告、セッション履歴・新規チャット切替、Windowsでのコンソールウィンドウ点滅などを修正
  - **Claude Code on the web**: プロセス終了後もセッションが生きているように見え約10分無応答になる問題を修正（メッセージ送信で即再起動）。Routinesページを新レイアウトに変更（カレンダー表示は削除）。Cloud environmentsエディタにCustom network access（allowed-domainsリスト）を追加
  - **Claude Tag**: スレッド中心の会話で約1時間ごとに作業コンテキストを失う問題、PR監視スレッドがCI失敗・コメントを拾わなくなる問題などを修正
  - **Code Review**: レビュー待ち中のコミットでレビューされない問題、同一コメントの2・3重投稿、解決済みセキュリティ指摘の再投稿などを修正

## マイナーリリース
- 対象期間内に該当なし（バグ修正のみのリリースはなし）

## Source References
- Claude Code CHANGELOG: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Releases: https://github.com/anthropics/claude-code/releases.atom
