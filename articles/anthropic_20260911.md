---
title: "Anthropic更新ダイジェスト - 2026年9月11日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月10日〜9月11日の2日間。
この期間を貫くテーマは「AIの安全と統制」である。
9月10日、Anthropicは脅威インテリジェンス報告の2026年9月版と、Frontier Red Teamによる戦術標定・通常兵器能力の測定評価を同日に公開した。
2つの報告は相互にリンクされており、「攻撃側で何が起きているか」と「モデル自身の能力がどこまで測れているか」を並べて読める構成になっている。
開発者向けの変更も同じ方向を向いている。
Managed Agentsの権限ポリシーにはサーバー側でツール呼び出しを1件ずつ評価する`auto`モードが加わり、Claude Code v2.1.268はセキュリティ修正を多数含むリリースになった。
エンタープライズ向けには、利用実態を可視化するSmart reportsのベータ提供も始まっている。
次号は、進行中のClaude Cowork on Windowsの障害（Microsoft側の修正待ち）の解消と、`auto`評価を実運用に組み込んだ組織の反応を確認したい。

## 📰 News（Anthropic発表）

### 脅威インテリジェンス報告 2026年9月版（9月10日）

Anthropicは9月10日、脅威インテリジェンス報告の2026年9月版を公開した。
2025年3月・8月・11月に続く4回目で、今回の対象は2025年12月〜2026年8月の約9か月に検知・妨害した活動である。
内容はサイバー作戦、影響作戦、監視、詐欺、生物学的悪用、通常兵器開発、不正ディスティレーションの7分野に分かれ、追跡ID（GTG-xxxxx）付きの事例として記述されている。
悪用に使われたのはClaude Haiku・Sonnet・Opusで、Claude FableとMythosクラスのモデルは不正ディスティレーション1件を除き関与していない。

サイバー分野の記述は具体性が高い。
Microsoftの報告と整合するロシアの諜報活動（GTG-20006）は、ウクライナと欧州の政府機関、ドローン供給網など20以上の組織を標的にした。
ShinyHunters系（GTG-50014）はAWS EC2 10台で180万APKをスキャンし、1TB超を窃取している。
中国・長沙のオペレーター（GTG-10007）は、1か月で十数件のゼロデイ候補を生み出す自律的なエクスプロイト生成を行っていた。
ロシア語圏の犯罪者（GTG-50020）は約4日で約30社のAI企業を攻撃し、事前公開のClaudeモデルへのアクセスを試みたが、アクセスは得られずAnthropicのシステムも侵害されなかった。

影響作戦では6大陸・9件（選挙に合わせたものを含む）を紹介する。
中央アフリカ共和国のラジオ局Radio Lengo Songoを用いたロシアFIMI（GTG-04001、Breakout Scale Category 4）、フランスのLKM Companyによる約70の偽ニュースサイトと約20言語8,913本の記事（GTG-54002）、マレーシア向けの選挙操作プラットフォームを販売するイスタンブールのBBS Bilisim（GTG-84005）などである。

Anthropicの対応は、関連アカウント・組織の停止、振る舞い検知の自動化、当局・業界・被害者への情報共有に加え、無力化済みドメイン、egress IP、Telegram ID、ファイルハッシュなどのIOC（侵害の痕跡）の公開までを含む。
報告の論点として重要なのは、攻撃の変化は手法ではなく**「経済性」**にあるという指摘だ。
自律化が速度と規模を増幅させ、同じ手法がより安価に回るようになっているという。

開発者に直接効く記述も2点ある。
公開されたIOC一覧は、自組織のログ検索にそのまま利用できる。
また、正規外の「Claude APIリセラー」が認証情報を収集する事例（GTG-50021）が明示されたため、APIキーの調達・経由経路を公式チャネルに限定しているかを確認する機会になる。

- **URL**: https://www.anthropic.com/threat-intelligence-report-september-2026

## 🧩 Platform リリースノート（API・SDK・Console）

### Managed Agents権限ポリシーに`auto`評価、`ant` CLIからのセッション接続（9月10日付）

Claude Managed Agentsの権限ポリシーに、新しい**`auto`モード**が追加された。
サーバー側がエージェントとMCPツール呼び出しを1件ずつ評価し、実行（run）・拒否（deny）・承認待ち（pause）のいずれかを自動判定する。
静的な許可リストと違い、呼び出しの内容ごとに判定が変わるため、無人で動くエージェントに安全性の網をかけられる。
あわせて`agent.tool_use`イベントと`agent.mcp_tool_use`イベントに`evaluation`フィールドが追加され、既存の`evaluated_permission`と並んで各呼び出しがどう評価されたかを報告する。
イベントストリーム側に監査やアラートの条件を組みやすくなる。
詳細はドキュメントの`managed-agents/permission-policies`にある「Let the server evaluate each call with `auto`」セクションに記載されている。

もう一つの変更は、`ant` CLIへの`ant beta:sessions connect`の追加である。
ターミナルをManaged Agentsセッションにアタッチし、セッションのライブ追跡、メッセージ送信、承認待ち中のツール呼び出しの許可・拒否ができる。
`--web`オプションを付けると、Claude Consoleのセッションビューアをローカルにサーブし、ターミナルではなくブラウザでセッションを開ける。
`auto`評価で承認待ち（pause）になった呼び出しを、人間がその場で捌く運用が想定されていると読める。
ドキュメントは`cli-sdks-libraries/cli/sessions-connect`にある。

- **破壊的変更**: なし
- **URL**: https://platform.claude.com/docs/en/release-notes/overview

## 💬 Claude Apps リリースノート（Claude.ai・Cowork等）

### Smart reports（ベータ）— Claude Enterprise向け（9月10日）

Claude Enterpriseプラン向けに**Smart reports**がベータ版として提供開始された。
チームのClaude利用状況を自動的に分析し、達成された仕事の内容、コスト、セッションで発生した摩擦（つまずき）、繰り返し現れるパターンをレポートする。
繰り返しパターンは共有スキル化できる候補として提示されるため、単なる利用統計ではなく改善アクションの糸口を返す設計になっている。
管理者はこれを使い、ワークスペース全体の利用実態と改善ポイントを把握できる。
エンタープライズでの展開が進むほど「何がうまくいっていて、どこで詰まっているか」の把握は必須になるため、管理者にとって実用性の高い追加と言える。

- **URL**: https://support.claude.com/en/articles/12138966-release-notes
- **使い方ガイド**: https://support.claude.com/en/articles/16893491-get-started-with-smart-reports

## ⌨️ Claude Code

対象期間内のリリースはv2.1.268の1版のみである。
CLIゲートウェイの料金・セキュリティ連携、セキュリティ修正の塊、プロンプトキャッシュの修正を含む、内容の濃いリリースだ。

### v2.1.268（2026-09-10）: ゲートウェイ料金連携とセキュリティ修正

#### ゲートウェイの料金設定連携

`gateway.yaml`の`pricing:`で料金を設定すると、サインイン済みクライアントに契約レートが供給され、`/cost`とテレメトリのコスト値がスパンドメーター（実際の支出計測）と一致するようになった。
組織が独自料金でゲートウェイを運用している場合、メンバーのCLIに表示されるコストと実費がずれる問題が解消される。

#### ゲートウェイのセキュリティ警告強化

`access_control.allow_cidrs`が空のまま起動した場合と、パブリックアドレスから最初のリクエストが来た場合に、それぞれ警告を出すようになった。
新管理設定`gatewayInternalNetworks`で、組織所有のパブリックIPv4レンジからの`/login`を許可できる。

#### サードパーティエンドポイントでのHTTP 400回帰の修正

サードパーティ`ANTHROPIC_BASE_URL`エンドポイントで毎ターンHTTP 400が発生する問題が修正された。
2.1.265以降の回帰で、Artifactツールの入力スキーマ正規表現が原因だった。
外部ルーター経由で運用している環境では優先度の高い修正である。

#### セキュリティ修正

セキュリティ修正の密度が今号の特徴である。

- macOSの`/etc`・`/tmp`・`/var`、Linuxの`/bin`などシンボリックリンクされたディレクトリのdeny/askルールが、実パス指定で回避できていた問題を修正。Bashもシンボリックリンク表記のdenyルールを尊重するようになった
- プラグイン/マーケットプレイスのエラーで、gitソースURLのトークンやパスワードが漏れないよう修正
- `/mcp`・`claude mcp list`/`get`・MCPログインエラーで、`${VAR}`プレースホルダーのシークレットを露出しないように修正
- スレッド内で再生成されたエージェントが、信頼できない同名エージェントファイルのツール/システムプロンプトを継承しないよう修正

#### タスク管理ツールの提供モデル限定（挙動変更）

タスク管理ツール（TaskCreate / Get / Update / List / TodoWrite）は、Claude 3.x・Opus 4.0〜4.7・Sonnet 4.0〜4.6・Haiku 4.5のみへの既定提供に変更された。
それ以外のモデルでは`CLAUDE_CODE_ENABLE_TODO_TOOLS=1`で有効化できる。
Agent SDKにも同じ変更が入っている。
新しいモデルでタスク管理が急に使えなくなった場合は、この変更の影響の可能性がある。

#### その他の修正

- `claude plugin install` / `uninstall` / `update` / `enable` / `disable`に`--json`を追加。`claude plugin list --json`に`errorDetails` / `noteDetails`行を追加
- WebFetch: レスポンスを閉じないサーバーでハングしなくなり、300秒のデッドラインを導入（`CLAUDE_CODE_WEBFETCH_DEADLINE_MS`で上書き、`0`で無効化）
- プロンプトキャッシュ: SDKセッションの`excludeDynamicSections`利用時にキャッシュと拡張思考がセッション途中で壊れる問題と、`/compact`・自動コンパクションの要約が`$`を含むテキストを破壊する問題を修正
- `WebFetch`のdeny/askルールはArtifactツールの読み書きには適用されなくなった（`Artifact`ルールまたは`WebFetch(domain:claude.ai)`を使用）
- PermissionRequestフックが`--print`モードでも発火するように。`CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS`がper-hookタイムアウト未設定のSessionEndフックにも適用されるように（以前は1.5秒で打ち切り）
- 3P（Bedrock / Vertex / Foundry）セッションのシステムプロンプトを環境・モデル・設定情報をアタッチメントとして配信し、ツールリストをバイト安定化
- Claude Code on the web: 約6時間を超えるクラウドセッションで永続フォルダー保存ファイルが失われる問題を修正（保存は最大1日保持）
- VS Code: `CLAUDE_CONFIG_DIR`設定時のセッション一覧・設定トグル・チャットタブの不具合などを修正
- Code Review: 検証エージェント途中失敗時にレビューが未完了で終わらないよう修正

- **リリース日**: 2026-09-10
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.268

## 🤖 Agent SDK

TypeScript SDKはv0.3.268の1版である。
Python SDKに期間内のリリースはなく、最新は2026-09-02のv0.2.152（処理済み）。

### TypeScript v0.3.268（2026-09-10）: 実行結果のトレース性強化

実行結果のトレース性を高めるフィールドが相次いで追加された。
`result_index`は、resultメッセージのラン内での配信順（0始まり）を示す。
複数の結果が流れるランで、出力の並び順を機械的に特定できる。
`resume_reason`は、ホスト再起動で中断されたターンを自動再実行したことをassistant/stream-event/resultメッセージに示す。
スラッシュコマンドでモデルループに入らず完結したターンのresultには、コマンド名を運ぶ`local_command`が付く。

`reload_plugins`コントロールリクエストには`hold_on_cache_impact`が加わった（`Query.reloadPlugins({ holdOnCacheImpact: true })`）。
プラグインの再読み込みがセッションのプロンプトキャッシュを無効化する場合、その再読み込みを保留する。
長いセッションでプラグイン更新のたびにキャッシュを失いたくないホスト側での制御に使える。

`canUseTool`オプションには`defaultToNo`と`suppressAlwaysAllowRule`のヒントが増えた。
前者は権限プロンプトを辞退側で開く指定、後者は「常に許可」の選択肢を出さない指定である。
権限UIの運用ポリシーをSDK側から表明できるようになった。

注記すべき挙動変更は、タスク管理ツール（TaskCreate等）が既定ツールになるモデルの限定である。
Claude 3.x・Opus 4.0〜4.7・Sonnet 4.0〜4.6・Haiku 4.5以外では、`tools`/`allowedTools`への明示指定が必要になった。
Claude Code v2.1.268と同じ変更で、SDK経由で新しいモデルを扱うコードには影響がある。

このほか、`get_context_usage`の応答に各カテゴリの`kind`（used / free / buffer / deferred）が付いた。
`setModel()`は、CLIがローカルで知らないモデルIDを、初回使用時にAPIへ確認してから受け入れるようになった（以前は未知のIDとして拒否）。
`initialize`の成功応答は`pending_permission_requests`を常に含むようになり、古いCLIとの区別がつく。
全体としてClaude Code v2.1.268とのパリティ更新である。

- **リリース日**: 2026-09-10
- **破壊的変更**: なし（タスク管理ツールの既定提供モデル限定は、対象外モデルで明示指定が必要になる点に注意）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.268

## 🔬 Research

### 戦術的インテリジェンス標定と通常兵器能力の測定（9月10日）

Frontier Red Teamが、AIモデルの戦術的インテリジェンス標定（「find／fix」タスク）と通常兵器開発能力を測定する評価を構築・実施した。
対象はClaude（Mythos Preview、Mythos 5、Opus 5、Sonnet 5）と、オープンウェイトのKimi K3（一部評価でGLM 5.2）である。
同日公開の脅威インテリジェンス報告からリンクされた、併催の報告にあたる。

標定評価は3系統ある。

- 架空シナリオのSNSコンテンツ200タスクからの個人特定（F1スコア評価。Mythos Previewが最高）
- 6,000枚のFlickr写真のジオロケーション（ツール・メタデータなし）。Mythos Previewは中央誤差37.0 km、1 km以内が23.7%で、GeoGuessr上位者代理との比較により、屋外写真では「超人的能力に近い」と評価された
- テキストベースの位置推定（GeoTextコーパス、検索付き）。複数モデルが利用者の8%を1 km以内に特定した

兵器開発評価はシミュレーションのみ（Betaflightファームウェアのクアッドコプター）で実施された。
終端誘導ではOpus 5が突出しており、駐車車両への80%命中、全540発中20%の成功を記録した。
コード編集量が小さく、比例航法とカルマンフィルタを早期に導入していたという。
ペイロード投下では強風下でもOpus 5が28%成功し、GPS妨害下の航行では15〜20 m以内に到達した。
一方、GPSスプーフィングの設定はどのモデルも解けなかった。

限界も明記されている。
シミュレーションのみでハードウェア検証がないこと、合成SNSデータの現実性が不足していること、人間のuplift（能力向上）を直接測定していないこと、写真ジオロケーションの人間ベースラインがGeoGuessr代理であることである。
結果は**「下限値」**として扱うべきとしている。

政策面では、クローズドウェイト開発者には配備後の安全策（AnthropicのSafeguardsチームが兵器開発リクエストをブロックする分類器を追加済み）、オープンウェイトの安全性研究の緊急性、民主主義国のコンピュート優位の保護を提起している。

- **URL**: https://www.anthropic.com/research/intelligence-targeting-conventional-weapons-capabilities

## 🚨 障害・ステータス

### Claude Cowork on Windowsの機能低下（進行中）

2026年9月8日配信のWindowsアップデートが原因で、Claude Cowork on Windowsがローカルコマンドを実行できなくなっている。
ワークスペースがコンピュータのドライブにアクセスできないためで、原因は9月10日15:54 UTCに判明した。
チャットやファイルの読み取り・編集はほぼ通常どおり利用できる。
アプリ内に回避策はなく、再起動・再インストールでも直らず、修正はMicrosoft側で対応中である（最終更新9月10日17:20 UTC、状態はIdentified）。

- **URL**: https://status.claude.com/incidents/r1pqn1kb4hvk

### Claude APIの一部ユーザーでの応答速度低下（解決済み）

米国中西部経由でトラフィックが流入する一部の顧客で、Claude APIの応答速度が通常より低下し、一部リクエストがタイムアウトした。
9月10日21:43 UTCに原因を特定し、23:24 UTCに解決を確認した。

- **URL**: https://status.claude.com/incidents/2pt83vlkk7x7

## 📝 まとめ

今号の中心は、9月10日に同時公開された脅威インテリジェンス報告とFrontier Red Teamの兵器能力評価の2報である。
悪用の実態をIOC付きで公開し、モデルの標定・兵器開発能力を「下限値」として測定した。
開発者には、公開IOCのログ検索への適用と、APIキー調達を公式チャネルに限定する確認が即効性のある対応になる。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。
追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
