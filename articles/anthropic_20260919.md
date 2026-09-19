---
title: "Anthropic更新ダイジェスト - 2026年9月19日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月18日〜9月19日の2日間。
この期間のAnthropicの発表は、フロンティアモデルの安全性を開発工程の内側から検証する仕組みづくりに向かった。
Newsでは、Accentureと組んで「埋め込み型評価（embedded evaluation）」を開始すると発表した。
Dario Amodeiのエッセイ「We Must Pace the Frontier」で表明した「評価者をAnthropic内部に組み込む」構想の実行で、両社は今後5年間でそれぞれ少なくとも10億米ドルを投じる。
同じ主題は道具の側にも表れた。
Claude Codeは大型リリースのv2.1.277を出し、サブエージェントの出力を枠付きでmain agentへ届けて指示になりすましを防ぐ変更や、サンドボックス免除の複合コマンド問題の修正など、エージェントへの信頼を担保する変更が並んだ。
あわせてCLAUDE.mdがないプロジェクトでAGENTS.mdを読むフォールバックも入り、他エージェントとの相互運用が一段進んだ。
Agent SDKも同日のパリティ更新である。
Platform リリースノート、Apps リリースノート、Engineeringブログ、Research、ステータスは対象期間内の掲載がなく、該当セクションは掲載基準により省略する。
次は「今後数週間で」と予告されている追加の埋め込み評価者の発表を注視したい。

## 📰 News（Anthropic発表）

### Accentureと提携し、フロンティアAIの「埋め込み型評価」を開始（2026-09-18）

AnthropicはAccentureと提携し、フロンティアAIの埋め込み型評価（embedded evaluation）を開始すると発表した。
事業はAccentureのAI専門部門であるFacultyが主導し、モデルの評価とレッドチーミング、アラインメント評価、セーフガードの検証を担当する。
Dario Amodeiのエッセイ「We Must Pace the Frontier」で表明した「評価者をAnthropic内部に組み込む」コミットメントの実行である。

埋め込み型評価者は、従来の外部評価者とはアクセスの深さが違う。
従業員に準じるアクセス権でモデルの学習過程を監視し、ビルド・デプロイの意思決定を追跡し、従業員と直接対話して安全へのコミットメントを検証し、盲点の特定やインシデント報告を行う。
リリース済みモデルを外から検査する通常の第三者評価では見えない開発工程そのものを、組織の内部にいながら独立した立場で観察できる仕組みである。

資金と独立性の設計も特徴的だ。
両社は今後5年間でそれぞれ少なくとも10億米ドルをこの分野の能力構築に投資する。
評価者のアクセス・報告・独立した資金づくりに関する標準がまだ存在しないため、当面はAnthropicがAccentureの業務を直接資金援助し、長期的にはプールされた資金や政府による資金を advocate する（2026年6月公開のAdvanced AI Frameworkに基づく）。

提携は非排他的である。
Anthropicは「今後数週間で」他の評価者を発表予定で、Accentureも他のAI開発者と協業する。
METRなど非営利評価者とも対話を進めている。

開発者への影響は直接的ではない。
APIや製品の変更はないが、Claudeモデルの安全性検証が社内に組み込まれた第三者評価者によって常時行われる体制が始まる。
評価結果やインシデント報告が今後のモデル改良・デプロイ判断に反映され、開発者が使うClaudeの信頼性向上につながる。

- **URL**: https://www.anthropic.com/news/accenture-embedded-evaluation

## ⌨️ Claude Code

対象期間内のリリースは9月18日付のv2.1.276とv2.1.277の2版で、v2.1.277が実質的な大型リリースである。

### v2.1.277（2026-09-18）: AGENTS.mdサポート、gateway向け強化、TaskOutputツール削除

#### AGENTS.mdサポート

CLAUDE.mdが存在しないプロジェクトで、AGENTS.mdを代わりに読むフォールバックが追加された。
切り替えは`/config`の「Project instructions」で行う（Bedrock / Vertex / Foundryでは未対応）。
AGENTS.mdは複数のコーディングエージェントで共有される指示ファイルとして普及が進む標準であり、リポジトリ側はCLAUDE.mdを二重に用意しなくてよくなる。
他エージェントと同じリポジトリで作業する開発者にとって、指示ファイルの相互運用が一段進んだ変更である。

#### Claude apps gateway向けのegress境界プロキシ設定

Claude apps gatewayを経由するエンタープライズ構成向けの設定が2つ加わった。
`CLAUDE_GATEWAY_PROXY_IS_EGRESS_BOUNDARY=1`は、egressがフォワードプロキシのみのClaude apps gateway向けに、外向きリクエストすべてでホスト名をローカル解決せずプロキシへ渡す。
あわせてupstreamへの任意の`headers:`マップが指定できるようになり、プロバイダー前段プロキシへの静的ヘッダー送信に対応した。
全トラフィックをプロキシに集約する運用での、egress制御の正確さを上げる変更である。

#### TaskOutputツールの削除（破壊的変更）

非推奨だったTaskOutputツールが削除された。
背景タスクの出力はReadで読む方式に統一され、`taskOutputMaxChars`設定と`TASK_MAX_OUTPUT_LENGTH`は無効化される。
TaskOutputを参照するスクリプトや自動化は、Readへの移行が必要になる。

#### サブエージェント出力の枠付けによるなりすまし防止（挙動変更）

サブエージェントの結果が、「サブエージェント出力」であることを示すヘッダー付き・インデント付きでmain agentへ届くようになった。
結果内のテキストがセッション自身の指示になりすますのを防止する、プロンプトインジェクション対策である。
同じ趣旨で、Bedrock / Vertex / Foundry上のworkflowスクリプト`agent()`プロンプトは「スクリプトが書いたテキスト」として枠付けされ、safety classifierがユーザー発話と誤認しないようになった。

#### 安定性とツール修正

`claude -p`・Agent SDKセッションが内部エラー後に結果なしでハングする問題が修正され、エラーを報告して終了コード1でexitするようになった。
`~/.claude.json`の不正な`customApiKeyResponses` / `theme` / `claudeAiMcpEverConnected`値による起動ハング・クラッシュも直っている。
ツール類では、Editツールがエスケープ済みバックスラッシュ+`uXXXX`を`\uXXXX`エスケープと誤解釈する問題、Writeツールがターゲットパスがディレクトリの場合に黙って権限拒否扱いでturn終了する問題、Grep / Globがリソース枯渇時に「一致なし」を返す問題が修正された。
特にGrep / Globの修正は、検索結果が黙って空になるという気づきにくい誤動作の解消である。

#### サンドボックスと権限プロンプスの強化

`sandbox.excludedCommands`のglobで、複合Bashコマンド全体がサンドボックス免除になる問題が修正された。
一部だけがマッチしても全体は免除にしない、セキュリティ上重要な修正である。
プロンプト内の不可視Unicode書式・タグ文字を除去し、送信前にクリーニング済みプロンプトを確認表示する改善も入った。
危険な`rm`コマンドの権限プロンプトは該当コマンド名と`${VAR:?}`ガードを提示し、headless実行でもリカバリできる。
SDK・headless（`-p`）起動の初回turnが、ディレクトリ毎のCLAUDE.mdルックアップを待たないようにもなった。

#### その他の変更

FableがAnthropic APIの`/model`に常に表示される（組織設定で無効時のみグレーアウト）。
SDK・IDE外で起動した`claude -p`実行での、バックグラウンドHaiku自動タイトル生成リクエストが削除された。
VS Codeでは、エージェントマップに背景シェル等の実行中タスクの表示（Stop付き）とtyped `/tasks`、パネルメニューへのSign out、レスポンスのCopy responseボタンとtyped `/copy`、Account & usageダイアログへのセッションのコスト・トークン使用量（Vertex / Bedrock / Foundry / APIキー時）が加わった。
Claude Code on the webでは、環境ピッカーにPersonal / Organizationセクション（Team・Enterprise）が入り、管理者が個人環境を組織へ共有できるようになった。

- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.277

### v2.1.276（2026-09-18）

2.1.275の回帰修正のみのリリース。
`ANTHROPIC_BASE_URL`がプロキシやgatewayを指す構成で全リクエストが`400 … Input tag 'advisor_20260301'`エラーで失敗する問題を修正した。

- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.276

## 🤖 Agent SDK

### TypeScript SDK v0.3.277（2026-09-18）: ホストアプリ実装向けの情報拡充

Claude Code v2.1.277とのパリティリリースで、ホストアプリ実装に役立つ情報追加が中心である。
`SlashCommand`にoptionalの`builtin`フィールドが加わり、コマンドがClaude Code組み込みかを判別できる。
`SDKUserMessage`には`pasted_content`が追加され、ユーザーがタイプしたのではなくペーストしたテキストを、typed promptの後に続く形で取れるようになった。
リモートセッションのレイテンシ計測フィールド（`first_text_post_ms`、`first_text_post_wall_ms`、`first_stream_post_queue_wait_ms`、`first_stream_post_queued_behind`）がsuccess result messageに追加され、応答までの所要時間を機械的に計測できる。
`updateSettings()`のsourceに`'userSettings'`が加わり、`effortLevel`のみを受け付けて、セッションの現在のモデルに対して`/effort`が保存するのと同じ形で保存される。

重要な修正が1つ入っている。
resume/forkしたセッションの`total_cost_usd`、`modelUsage`、`get_usage`の合計がゼロから始まってしまうバグが修正され、以前のターンから継続するようになった（`maxBudgetUsd`は変更なし）。
セッション再開を跨いだコスト集計や予算管理をホスト側で実装しているアプリにとって、金額計上の正確性に直結する修正である。
このほか、`SDKUsageReport`のusage行は常に`severity`と`is_active`を持ち、レポートはライブサーバー応答からの行のみを中継する（usage取得の失敗中は何も返さない）ように変更された。

- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.277

### TypeScript SDK v0.3.276 / Python SDK v0.2.156（2026-09-18）

TypeScript v0.3.276はClaude Code v2.1.276とのパリティ更新のみで、SDK単独の変更はない。
Python v0.2.156はバンドル済みClaude CLIを2.1.276へ更新したメンテナンスリリースで、SDK API側の変更はない。

- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.276
- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.156

## 📝 まとめ

対象期間の最重要はClaude Code v2.1.277だ。CLAUDE.mdがないプロジェクトでAGENTS.mdを読むフォールバックが入り、他のコーディングエージェントとの指示ファイル相互運用が進んだ。非推奨のTaskOutputツールは削除され、背景タスクの出力はReadに統一されるため、参照する自動化は移行が要る。サブエージェント出力の枠付けやサンドボックス免除の修正など、信頼性・セキュリティ面の強化も厚い。NewsではAccentureとの埋め込み型評価の提携開始を発表した。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。
追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
