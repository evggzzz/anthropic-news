---
title: "Anthropic更新ダイジェスト - 2026年09月24日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月23日から9月24日の2日分です。

この期間の中心は、Claudeエージェントが生物学の新規酵素系「ART」を発見したという発表です。

コード生成で磨かれてきた「大量のエージェントを並列実行して探索させ、自己批判で絞り込み、人間向けレポートにまとめる」というパターンが、湿式実験を伴う科学発見の現場に持ち込まれた事例で、エージェント活用の射程を測るうえで見逃せない内容です。

開発者ツール側は静かな2日間に見えますが、Claude Code v2.1.281とTypeScript SDK v0.3.281が`attribution`設定で同期して動いています。

`"attribution": false`でコミットやPRへの帰属表記をまとめて非表示にできるようになり、TS SDK側でも`Settings`型の破壊的な型変更として追随しました。

帰属表記をCIやリリースフローで制御しているチームは、この2点をセットで確認してください。

なおPlatform・Appsのリリースノート、Engineeringブログ、ステータスには対象期間内の新規エントリがありませんでした。

## 📰 News（Anthropic発表）

### ClaudeがCRISPR様リピートを持つ新規酵素系「ART」を発見

https://www.anthropic.com/news/claude-discovers-novel-enzyme-system

Anthropicが、Claudeエージェントによる自律的な探索の結果として、バクテリオファージ（細菌に感染するウイルス）に見られる新規酵素系「array-associated reverse transcriptases（ART）」の発見を発表しました。

ARTは、RNAをDNAにコピーする逆転写酵素（RT）、機能未知のパートナー遺伝子、等間隔に並ぶDNAリピート配列の長いアレイ、という3要素から構成されます。

リピートの配置はCRISPRアレイに類似しており、初期実験ではARTアレイが短いRNAとして発現することまで確認されています。

ただし一次機能は依然未知で、これはまだ「構造が見つかった」段階の発見です。

この発表の核は、発見に至ったプロセスの規模です。

約950個のClaudeエージェントを並列実行し、21時間・約2.1億トークンを使ってDNA配列データベースを探索しました。

収集したRTは20万超、そこから提案された候補系は3,500で、自己批判による絞り込みを経て最終的に20の有力候補が人間が読めるレポートにまとめられています。

リピートパターンを見つけたエージェントが「目で見てタンデムリピートアレイが分かる……CRISPR的な……リピートアレイ?!」と報告した記述も公開されており、探索の過程がそのまま見える点も珍しい発表です。

ハーネスにはClaude Scienceと、Claude Codeに加えて並列のClaudeセッションを束ねるカスタムハーネスが使われています。

「大量探索→自己批判による絞り込み→人間レポート化」という構成はゲノムマイニング固有のものではなく、探索空間が大きいタスク全般に転用できるワークフローパターンとして設計の参考になります。

安全性については、湿式実験はAnthropicのBay Areaラボで人間の科学者が実施しています（BSL-1/BSL-2、ヒト病原体は扱わない）。

CRISPR研究の第一人者であるFeng Zhang氏（MIT/Broad Institute）は「AIエージェントが生物学の発見に貢献できるエキサイティングな例」と評価しました。

成果はプレプリントとして公開されており、ライフサイエンス分野でのエージェント活用が実用段階に入りつつあることを示す事例です。

## ⌨️ Claude Code

### v2.1.281（2026-09-23）

https://github.com/anthropics/claude-code/releases/tag/v2.1.281

設定・ゲートウェイ・セキュリティの3方向に効く大型リリースです。

最も影響が広いのは、`settings.json`に追加された`"attribution": false`です。

コミットやPRへの帰属表記をまとめて非表示にできます。

共有のsettings.jsonで使う場合は注意が必要です。

この設定を含むファイルは旧バージョンのClaude Codeが丸ごとスキップするため、共有ファイルはオブジェクト形式のまま運用してください。

Claude apps gatewayまわりでは、Bedrock上流への接続設定が拡張されました。

`assume_role`でSTS経由のIAMロールとして呼び出せるようになり、別AWSアカウントや開発者ごとのセッションも任意で設定できます。

`guardrail: {id, version}`を指定すると、全リクエストにAmazon Bedrockのガードレールが適用されます。

加えて`telemetry.resource_attributes`でテレメトリに固定ラベルを付与でき、`desktop`ポリシーブロックでは`blockReadsOutsideWorkingDirectories`と`disableBypassPermissionsMode`に対応しています。

Bedrock経由のエンタープライズ運用では、ロール分離とガードレール強制が設定一枚で済むようになったのが実質的な改善です。

MCPではURL-mode elicitationに対応しました。

2026-07-28以降のプロトコル接続で、MCPサーバーがブラウザベースのフローを要求できるようになっています。

`claude plugin validate`も強化され、`.mcp.json`の読み込み時に黙って破棄されるエントリや未宣言の`${user_config.*}`参照、非安全URLを検出してくれるようになりました。

セキュリティ面の目玉は、コマンド置換のみを対象にした再帰`rm`の修正です。

`rm -rf "$(pwd)"`のようなコマンドが、auto modeや`--dangerously-skip-permissions`のもとで無確認で実行されてしまう問題がありました。

このケースではBash許可ルールがあっても確認を求める挙動に変わっています（`CLAUDE_CODE_DISABLE_SUBSTITUTION_RM_PROMPT=1`で無効化）。

あわせて、危険な`rm`プロンプトは2分待機後に拒否へ移行するようになり（`CLAUDE_CODE_DISABLE_DANGEROUS_RM_TIMEOUT=1`で無効化）、`/.vol`など特殊パスの権限チェック漏れも修正されました。

動作変更として、send now（ctrl+enter または ctrl+x ctrl+s）がターンをキャンセルせず、実行中ツールをバックグラウンドへ移行するように変わりました。

サーバー側分類器でauto modeを動かしている場合、read-only/sandboxedコマンドもレビュー結果を待つ挙動になります。

`CLAUDE_CODE_AUTO_MODE_SERVER`は直接Anthropic API接続にも適用可能になり、`0`でオプトアウトできます。

安定性の修正も充実しています。

セッション再開時の履歴不整合（並列tool-callターンやMCPツール入力の再送でAPIがprior reasoningを破棄する問題）、巨大セッション再開時のメッセージ欠落、プロキシ/ゲートウェイ切断時に応答が完了扱いになる問題、`--max-turns`が無視される無限リトライなどが直りました。

パフォーマンスでは、起動時の最初のフレーム前処理（git読み取り・起動テレメトリ・Bedrock/Vertexチェック）が削減され、長い/コンパクト済みセッションの再開が高速化、3MB超PDFで最大2分応答が遅くなる問題も解消されています。

UIでは`/skills`・`/mcp`・`/plugin`のInstalledリストにスクロールバーが付き、vim modeの`dj`/`dk`/`cw`等の動作が修正され、ダイアログでのCtrl+C/Ctrl+D二押しによる誤終了も直りました。

`--agents`がJSONファイルパスを受け付けるようになり、`/batch`がWorktreeCreateフック提供のworktreeで動作するようになっています。

移行が必要な変更として、セルフホストランナーのシステムプロンプトがファイル渡しになり、`--system-prompt-file` / `--append-system-prompt-file`への移行が求められます。

周辺では、VS Codeにauto modeフォールバック時のContinue/Stopプロンプトが追加され、Claude Code on the webにFast modeスイッチが入っています。

## 🤖 Agent SDK

### TypeScript v0.3.281（2026-09-23）

https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.281

Claude Code v2.1.281へのパリティリリースです。

機能面では、`conversation_reset`メッセージに`trigger`・`user_message_uuid`・`timestamp`の各オプションフィールドが追加されました。

リセットのきっかけの把握、/clearと元メッセージの紐付け、発生時刻の表示がホスト側でできるようになります。

会話履歴を持つホストアプリでは、リセットがいつ・なぜ起きたかをUIに反映しやすくなる有用な変更です。

破壊的な型変更があります。

`Settings`型の`attribution`フィールドが`boolean | {...}`になり、`attribution.commit`を読むコードは型の絞り込みが必要です。

Claude Code側の`"attribution": false`設定に対応する変更なので、v2.1.281とセットで対応してください。

パフォーマンス面では、未使用の依存関係がバンドルから除かれ、sdk.mjsが1.47MBから0.97MBへ縮小しました。

`createSdkMcpServer`などin-process MCPサーバーを使う`query()`セッションの起動も高速化されています（initializeステップがサーバーを最大250ms待機）。

CLIも、バックグラウンドの起動処理より先にホストのinitializeリクエストへ応答するようになりました。

ライフサイクル系の修正として、`close()`後に権限・ダイアログコールバックが呼ばれ続ける問題、コントロールリクエストのハング・リーク、重なる権限プロンプトとサンドボックスのネットワークアクセスプロンプトに両方回答しても`session_state_changed`が`requires_action`のまま残る問題が直っています。

### Python SDK

#### v0.2.159（2026-09-23）

https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.159

バンドル済みClaude CLIを2.1.281へ更新したパッチリリースです。

e2eテストのデフォルトモデルを`claude-opus-5`に固定し、CLIの新デフォルトモデルに起因するCI失敗を回避しています（#1287）。

機能追加はないため、CLIの追従だけが必要なチームはこのバージョンへ更新するだけで済みます。

#### v0.2.158（2026-09-23）

https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.158

`ClaudeAgentOptions`に`verbatim_prompts`オプション（デフォルト`False`）が追加されました。

有効にするとユーザーメッセージが`@path`のファイル展開もスラッシュコマンド実行もされず、書かれたとおりそのままCLIへ渡ります。

プロンプトに埋め込まれた信頼できないテキストが意図しないファイル読み込みやコマンド実行を引き起こすのを防げるため、外部入力をプロンプトに流すアプリでは押さえておきたいセキュリティオプションです。

`query()`、`ClaudeSDKClient.connect()`、`ClaudeSDKClient.query()`で利用でき、CLI 2.1.248以上が必要です（旧CLIでは警告が出ます）。

バンドルCLIは2.1.280へ更新されています。

## 🔬 Research

### Claude discovers a novel enzyme system with CRISPR-like repeats（Researchインデックス掲載）

https://www.anthropic.com/news/claude-discovers-novel-enzyme-system

今回の発表はNewsとResearchの両インデックスに掲載されています。

内容の解説は冒頭のNewsセクションにまとめたため、重複を避けて要点だけ触れます。

プレプリント（PDF）は https://www-cdn.anthropic.com/22573675ada52a8ca8a97a1a4b4326b2f208a071.pdf で公開されています。

査読前の初期結果であり、ARTの一次機能は未確定という点には留意してください。

## 📝 まとめ

最大のトピックは、約950個のClaudeエージェントによる大規模ゲノム探索で新規酵素系「ART」を発見したという発表です。21時間・2.1億トークンで20万超の逆転写酵素から有力候補20件へ絞り込み、湿式実験は人間の科学者が実施する、エージェント×科学発見の具体的なワークフローが示されました。開発者ツールではClaude Code v2.1.281とTS SDK v0.3.281がattribution設定で同期した点も押さえてください。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。

追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
