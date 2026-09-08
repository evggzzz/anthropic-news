ように---
title: "Anthropic更新ダイジェスト - 2026年9月8日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月2日〜2026年9月8日の7日間。
この期間、Anthropic News、Claude Appsのリリースノート、Engineeringブログのいずれにも新しい項目がなく、公式発表の面では静かな週だった。
開発者向けの更新はその逆で、エージェントを組織のインフラとして運用するための機能が各所に揃った。
プラットフォームでは`ant apply`によるリソースのコード管理が登場し、Claude Codeでは組織全体へのMCPサーバー配布と無人運用の仕組みが入り、Agent SDKにも同じ無人運用オプションが追加されている。
時期を考えると、この整備は9月1日リリースのClaude Fable 5.1 / Claude Mythos 5.1以降の利用を見込んだものと読める。
当ダイジェストは今号が初回で、この2モデルは未収集のためPlatformの節で期間外補足として扱う。
新モデルの直後という事情は不具合の面にも出ており、Claude Code各版には1Mコンテキストとプロンプトキャッシュの修正が集中し、ステータス面では新モデルを含む複数モデルのエラー率上昇が発生した。
その一方で研究部門からは、フェルマーの最終定理の証明をLeanでend-to-endに機械検証した成果が公開され、これが今週最大のトピックとなる。
来週は新モデルの安定化の状況と、Apps・Engineeringの更新再開を確認したい。

## 🧩 Platform リリースノート（API・SDK・Console）

### ant CLI 1.30.0: `ant apply`によるリソースのコード管理

`ant` CLI v1.30.0に`ant apply`コマンドが追加された。
リポジトリ内のファイルから、agents・environments・skills・memory stores・deploymentsを作成・更新できる。
実行するとまず適用内容のプランが表示され、承認してから適用する。
適用すると`claude-lock.json`ロックファイルが書き出され、これをコミットしておけば以降の実行はローカルでもCIでも、新規作成ではなく同じリソースの更新になる。
Console上の手動作業に頼っていたエージェント構成を、コードレビューの流程を通して変更・再現できるようになったことを意味する。
TerraformなどのIaCツールと同じ運用モデルをClaudeプラットフォームのリソースに持ち込む変更で、複数環境・複数人で運用するチームほど恩恵が大きい。

- **リリース日**: 2026-09-03
- **バージョン**: ant CLI 1.30.0
- **破壊的変更**: なし
- **ドキュメント**: "Manage resources as code with ant apply"
- **URL**: https://platform.claude.com/docs/en/release-notes/overview

### 期間外補足: Claude Fable 5.1 / Claude Mythos 5.1（2026-09-01）

対象期間の前日にあたる9月1日に、Claude Fable 5.1（`claude-fable-5-1`）とClaude Mythos 5.1（`claude-mythos-5-1`）がリリースされている。
1M contextがデフォルトで、価格は$10/$50 per MTok、cache readは$0.25/MTok。
当ダイジェストは今号が初回でこのリリースを扱っていないため、参考として記載する。
今週のClaude Codeやステータスの項目は、このローンチ直後の状況を前提に読むと理解しやすい。

- **発表日**: 2026-09-01（対象期間外）
- **モデルID**: `claude-fable-5-1` / `claude-mythos-5-1`
- **URL**: https://www.anthropic.com/claude-fable-and-mythos-5-1

## ⌨️ Claude Code

今週はv2.1.259（9/2）からv2.1.263（9/6）まで4版がリリースされた。
実質的な更新は9/2〜9/4の3版で、管理者向け機能の追加と、Fable 5.1を含む既存不具合の修正が中心である。

### v2.1.259（2026-09-02）: 組織へのMCP配布と無人運用

この版では管理者向けの機能追加が中心となっている。
`managedMcpServers`管理設定により、組織が全ユーザーにHTTP/SSEのMCPサーバーを提供できる。
形式は`.mcp.json`と同じで、コマンド実行型のエントリはスキップされる。
社内標準のツール群を各メンバーの手動設定に頼らず届けられるため、MCPの組織展開の敷居が下がる。
もうひとつの追加は`--permission-prompts none`で、権限プロンプトが必要な操作を自動拒否する。
ヘッドレスホストで人が応答できない場面のフェイルセーフとして機能し、権限モードの判定（auto モード等）は継続する。
CIでの実行や常駐エージェントの無人運用が安全にできるようになった。

- **追加**: `managedMcpServers` — 組織が全ユーザーにHTTP/SSE MCPサーバーを提供（`.mcp.json`と同じ形式。コマンド実行型エントリはスキップ）
- **追加**: `--permission-prompts none` — 権限プロンプトを自動拒否し、ヘッドレス運用を可能に（auto モード等の権限モード判定は継続）
- **追加**: `glab mr create/merge/close/reopen/note/update`を認識。GitLab MRの`MR !N`表示とフッターのMRバッジ更新に対応
- **追加**: `claude plugin validate --json`（機械可読な検証レポート）
- **変更**: `allowedMcpServers`の適用範囲をユーザー追加サーバーのみに縮小。除外には`deniedMcpServers`を使用
- **注意**: この`allowedMcpServers`の変更は、既存の管理設定ではサーバーの許可・除外の挙動が変わる点に注意
- **修正**: セッション同時実行で`~/.claude.json`の変更が互いに黙って元に戻る問題（workspace trustのリセット、MCP/プロジェクト状態の消失）
- **修正**: 管理設定ファイルがパース不能のとき黙って未適用になる問題 — 起動を拒否し原因のソースを表示するように
- **修正**: カスタムコマンド/スキルのfrontmatter `model:`が対話セッションで無視される問題
- **修正**: telemetry無効セッションでOAuthトークン更新のたびにプロンプトキャッシュが失効する問題
- **VSCode**: セッションリストにActiveクイックフィルターとステータスフィルターメニュー（Needs input / Working / Completed）を追加
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.259

### v2.1.260（2026-09-03）: /diffパネルとキャッシュミス診断

この版では、長時間セッションの運用に効く差分確認とキャッシュ診断が追加された。
`/diff`はフルスクリーンモードで会話の横に未コミット変更の差分パネルを表示する。
`/cost`とステータスラインの`prompt_cache`フィールドには、キャッシュミスの推定原因（ツール定義やシステムプロンプトの変更、TTL超過など）が表示されるようになった。
プロンプトキャッシュの効きはコストに直結するため、ミスの原因が特定できるのは1Mコンテキスト時代の実コスト調査として有用だ。
前版2.1.259で入った「`Read()`のdenyルールをBash引数に適用」は、この版で撤回された。
`Read(./**/build/**)`ルール下で`npm run build`が全モードで拒否される等の誤動作があったためである。
Fable 5.1関連では、`model: fable`エージェントが`[1m]`タグを無視して200Kコンテキストで動作する問題と、プロンプトキャッシュがツール結果以降のコンテキストをカバーせず毎ターン再送していた問題が修正された。
後者はキャッシュが効かないぶんコストが増える問題で、1Mコンテキスト運用の実効コストに影響する。

- **追加**: `/diff` — フルスクリーンで会話の横に未コミット差分パネルを表示
- **追加**: `/cost`とステータスライン`prompt_cache`にキャッシュミスの推定原因（ツール定義・システムプロンプトの変更、TTL超過など）を表示
- **追加**: `/reload-plugins`がヘッドレスセッションで使用可能に。`/advisor`のテキスト形式（`/advisor`、`/advisor <model>`、`/advisor off`）をDesktop・Remote Control・`-p`/Agent SDK向けに提供
- **追加**: Claude apps gatewayに`oidc.scope_on_refresh`（refresh時に`openid`再要求が必要なIdP向け）
- **撤回**: 2.1.259の「`Read()` denyルールをBash引数に適用」— `npm run build`等が誤って拒否される誤動作のため
- **修正**: パスに括弧を含む`Edit`/`Write`/`Read`権限ルールが無効としてドロップされ、"read-only"フォルダが実際には書き込み可能になる問題
- **修正**: Fable 5.1のプロンプトキャッシュがツール結果以降をカバーせず毎ターン再送する問題、`model: fable`エージェントが`[1m]`タグを無視する問題
- **修正**: `/rewind`と`--rewind-files`がバックアップ欠落時に偽の成功を報告する問題
- **修正**: Bedrockのモデル検出・トークンカウント・SSO/STS認証が企業ルートCAのみの環境で"unable to get local issuer certificate"になる問題
- **変更**: フルスクリーンの`ctrl+l` / `cmd+k`がterminalの`clear`相当でtranscript表示をクリア（スクロールで過去は閲覧可）
- **注意**: `!` bashモードで入力したコマンドは、strict sandbox（`sandbox.allowUnsandboxedCommands: false`）下でもサンドボックス外で実行される変更が入った
- **変更**: サブエージェントが開始したバックグラウンドコマンドの1時間上限を廃止。終了または停止まで実行
- **改善**: 1Mコンテキストモデルのauto-compactがリミット直前に動作するように。巨大コンテキスト復帰時のcompactが10分でタイムアウトしないように
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.260

### v2.1.261（2026-09-04）: 出力上限128K文字と/skill-doctor

この版はコンテキストの使い方を制御する設定が中心である。
`bashOutputMaxChars` / `taskOutputMaxChars`設定により、コマンドとバックグラウンドタスクの出力をファイル保存せずインラインで受け取る上限を最大128K文字まで引き上げられる。
大量出力を読ませる処理で、ファイル経由の迂回が不要になる。
`/skill-doctor`は、ロード済みスキルのうち未使用のものとそのコンテキスト消費を表示する。
スキルを増やすほどコンテキストを圧迫する問題への対処が、ツール側に用意された形だ。
単語編集キーがBash準拠になり、`keybindingFlavor`は効力を持たない（実質非推奨）。

- **追加**: `bashOutputMaxChars` / `taskOutputMaxChars` — コマンドとバックグラウンドタスク出力のインライン受信上限を最大128K文字に拡張
- **追加**: `/skill-doctor` — 未使用スキルとそのコンテキスト消費を表示し、整理を促す
- **追加**: `--append-subagent-system-prompt-file` — コマンドラインに載せきれない大きさのサブエージェントシステムプロンプトをファイルから読み込み
- **追加**: `/status`と`claude doctor`に"Organization policy"行 — 組織ポリシーが読み込めない原因（プロキシがエンドポイントを通さない等）を表示
- **変更**: 単語編集キーがBash準拠に（Ctrl+Wは直前の空白まで削除、Alt+F/Alt+Dは単語末で停止、句読点も区切り）。`keybindingFlavor`は効力なし
- **変更**: autoモードで、公開ダイアグラムレンダラーのURLにコンテンツを詰め込むリンクを当該サイトへのアップロードとみなし、明示指定なしでは自動承認しない
- **修正**: 高速入力・キーリピート時に文字が欠落したり順序が入れ替わる問題
- **修正**: BedrockセットアップウィザードがAWS認証情報ヘルパーの無応答でハングする問題。TLS検査プロキシ配下でのモデルチェック失敗も
- **修正**: セッションresume時に並列ツール呼び出し周辺のコンテキストが失われ、再開後のリクエストが変わる問題
- **修正**: Remote Controlの古い権限モード表示、スマホ/ブラウザから停止後もスピナーが止まらない問題、`/teleport`で取得したセッションのアップロード先誤りなど
- **改善**: `/model`ピッカーとVS Codeのモデルピルが、認識済みモデルで生のBedrock/Vertex/LLM gateway IDの代わりにモデル名を表示
- **改善**: `rm -rf`安全プロンプトが位置パラメータとダブルクォート内`sh -c`スクリプトのケースも検出
- **VSCode**: MCPサーバーダイアログに追加フォームと削除アクション、セッションリスト右クリックに「Archive session」など
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.261

このほかv2.1.263（2026-09-06）はバグ修正と安定性向上のみのリリース。

## 🤖 Agent SDK

TypeScript SDKが今週3版の実質更新を重ね、Claude Code本体とほぼ同期している。
各版はそれぞれClaude Code v2.1.259〜v2.1.261とのパリティ更新を含む。
Python SDKはバンドルCLIの更新のみ。

### TypeScript v0.3.259（2026-09-02）: 無人運用オプション

無人運用のためのオプションがSDKにも入った。
`permissionPrompts: 'none'`は、応答できる人がいないセッションで権限プロンプトを自動拒否する。
Claude Code v2.1.259の`--permission-prompts none`と同じ機能で、auto modeの分類器は動作を維持する。
このほか、ターン最初のreplyフレームと結果に`user_message_uuids`フィールドが追加され、マージされた複数のユーザーメッセージへの応答紐付けが可能になった。

- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.259

### TypeScript v0.3.260（2026-09-03）: レイテンシー計測とrewindFiles修正

成功結果に、リモートセッション向けのレイテンシー内訳フィールドが追加された。
`first_content_frame_ms`、`first_stream_post_ms`、`first_stream_post_ack_ms`、`first_stream_post_wall_ms`の4つで、エージェントの応答がどこで遅れているかを計測する材料が揃う。
`rewindFiles()`が、チェックポイントバックアップ不在などで復元できなかったのに成功を報告していた問題は修正され、正しく失敗するようになった。
`rate_limit_event`は429の継続中に制限ウィンドウごと（約30秒ごと）に再送され、ストリーム消費側が古い状態をリフレッシュできる。

- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.260

### TypeScript v0.3.261（2026-09-04）: pluginDeliveryとテスト環境修正

`pluginDelivery: 'initialize'`オプションで、プラグインをコマンドラインではなくstdin経由で渡せるようになった。
プラグイン数の増加に伴うコマンドラインの肥大化を防ぎ、プラグインを多数積んだWindows環境での起動失敗が解消される。
テストランタイム周りでは、ネイティブの`Symbol.dispose`がないランタイム（Node 22以下のVMベース環境 — Jestのnode environment、vitestのvmThreads/vmForks — および18.18未満のNode）で`query()`が"Object not disposable"を投げる問題が修正された。

- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.261

v0.3.263（2026-09-06）はClaude Code v2.1.263とのパリティ更新のみ（v0.3.262もパリティ更新のみでGitHub Releasesには未公開）。

### Python v0.2.152（2026-09-02）

バンドルされるClaude CLIを2.1.259に更新したメンテナンスリリースで、新機能・バグ修正はない。

- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.152

## 🔬 Research

### フェルマーの最終定理をLeanで機械検証（2026-09-04）

Anthropicは9月4日、フェルマーの最終定理（FLT）の証明をLean証明支援系でend-to-endに機械検証した初の成果を公開した。
Claudeが主体として約11日間で約1,300万行のLeanコードを生成し、最終証明で用いる29,500個の中間定理を含む計30,300個の検証可能な証明を完成させた。
証明の規模はベースとなったコミュニティ数学ライブラリMathlibの5倍以上で、依存する公理はLeanの標準3公理のみである。
比較ツールでMathlibのFLTステートメントとの一致も確認済みで、証明の道筋はWilesの証明のDarmon–Diamond–Taylorによる簡略版に沿っている。
実行体制は、Claude Codeベースのマルチエージェント基盤上で数十のエージェントが、コロンビア大学のTianyi Pengらが設計したオープンプラットフォーム「Prove2Me」を通じて協調した。
Prove2Meは定理ステートメントのDAG管理、ステートメントと証明の分離によるLeanコンパイル高速化、定理の検索・再利用を実現している。
人間の関与はPengによる散発的な高レベル指示に留まった。
限界も明記されている。
初期のマルチエージェント試行はプロジェクト状態を喪失して協調に失敗し、失敗分は非ボイラープレート行の約7%を占める。
証明は必要以上に長く、検証負担が消えるのではなく移動するだけである点も挙げられている。
Imperial College LondonのKevin Buzzardは、数学の公理以外の仮定なしにFLTを証明するautoformalizationの達成と評価するコメントを寄せた。

- **記事**: https://www.anthropic.com/research/formalizing-fermats-last-theorem
- **Prove2Me論文**: https://doi.org/10.48550/arXiv.2608.28433
- **証明コード**: https://github.com/anthropics/fermats-last-theorem

## 🚨 障害・ステータス

### 複数モデルでエラー率上昇（2026-09-03、解決済み）

9月3日に、新旧7モデルを巻き込むエラー率上昇が発生した。
対象はClaude Mythos 5.1 / Fable 5.1 / Mythos 5 / Fable 5 / Opus 5 / Opus 4.8 / Opus 4.6。
13:26 UTCに調査を開始し、13:41に原因を特定した。
15:25時点で影響はOpus 4.8とOpus 5のみに縮小し、16:06に修正をデプロイ、16:23に解決した。
調査開始から解決まで約3時間を要した障害である。
前々日の9月1日にリリースされたMythos 5.1 / Fable 5.1が影響範囲に含まれており、ローンチ直後の週に起きた障害と位置づけられる。

- **影響**: Claude Mythos 5.1 / Fable 5.1 / Mythos 5 / Fable 5 / Opus 5 / Opus 4.8 / Opus 4.6
- **状態**: 解決済み（2026-09-03 16:23 UTC。実際の影響は16:16 UTCまで）
- **URL**: https://status.claude.com/incidents/461yvfrzpwtt

### クレジット購入の反映遅延（2026-09-02解決）

残高ゼロのユーザーで、購入したクレジットの反映が遅延し、誤った「クレジット残高が不足しています」エラーが発生した。
9月1日12:10〜21:35 UTCの購入が影響対象で、9月1日23:26 UTCにモニタリング状態に入り、9月2日01:24 UTCに解決した。

- **状態**: 解決済み（2026-09-02 01:24 UTC）
- **URL**: https://status.claude.com/incidents/620swtqyn24k

このほか、9月2日と9月3日にClaude Sonnet 5のエラー率上昇が計2回発生したが、いずれも短時間で解決している（https://status.claude.com/incidents/ls6bn1x81m0w 、https://status.claude.com/incidents/288w7p4hk1l1 ）。

## 📝 まとめ

今週の最重要ポイントは、フェルマーの最終定理の証明をLeanでend-to-endに機械検証した研究だ。
Claudeが約11日間で約1,300万行のLeanコードを生成し、29,500個の中間定理を含む計30,300個の検証済み証明を完成させた。
依存公理はLean標準の3つのみで、Wiles証明のDarmon–Diamond–Taylor簡略版をマルチエージェントとProve2Meで協調検証した。
人間の関与は高レベル指示のみであり、形式数学の検証がLLMで実行できる領域になったことを示す成果だ。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。
追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
