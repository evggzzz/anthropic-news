---
title: "Anthropic更新ダイジェスト - 2026年9月18日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月17日〜9月18日の2日間。
この期間のAnthropicの発表はライフサイエンスに向かっていた。
Newsでは、創薬や研究生物学のタスクを検証済み組織に開放する「Life Sciences Verification Program」のベータ開始を発表した。
Researchでは、Claudeがバイオ分子モデリングのオープンソースモデル30超を平均約4倍高速化した取り組みを公開し、同じ記事でこのプログラムの公開ベータと設計コンペの開始も伝えている。
制度づくりと技術実証が同時に動く展開で、バイオ分野への注力が一段と強まった2日間だった。

もう一本のNewsは別の軸で、フロンティアラボ内部の開発ペースそのものを外から測れるようにする3つの指標の公開である。
社内のAI R&D業務の何割をClaudeが担っているか、常時いくつのエージェントが稼働しているかといった数値が、具体的な値として示された。

道具の側も大きく動いた。
Claude Codeは9月17日にv2.1.274とv2.1.275の2版を連続リリースし、claude.aiで有効化したskillsとpluginsのターミナル同期、プラグイン取得まわりのセキュリティ強化、MCP起動の制御が相次いで入った。
Agent SDKもClaude Codeと同じ日のパリティ更新である。
Apps リリースノート、Engineeringブログ、ステータスは対象期間内の掲載がなく、該当セクションは掲載基準により省略する。

## 📰 News（Anthropic発表）

### フロンティアラボ内部のAI開発ペースを測る3つの指標（2026-09-17）

Anthropicは、フロンティアラボ内部のAI開発のペースへの外部からの可視性を高めるため、3つのプロトタイプ測定を公開した。
Dario Amodeiの「We must pace the frontier」論文を踏まえたフロンティアペーシング議論への材料とするもので、第三者評価者の受け入れと、他のフロンティア開発者が複製できる共通方法論の提案を合わせて掲げている。

1つ目は「Anthropic R&D Automation Index」で、社内のAI R&DタスクをEpoch AIのAutomation Level尺度（AL0〜AL5）で評価する。
2026年8月時点の値として、ClaudeがAnthropicのAI R&D業務の26%を「リード」に当たるAL4で担い、90%超の業務が「AI協働」のAL3以上、完全自律のAL5は該当なしとされている。
ラボの外からは推測するしかなかった自動化の実測値が、等級つきで示された最初期の事例である。

2つ目はAIエージェントの監視である。
最も利用される社内プラットフォーム上には、常時約30,000の研究・エンジニアリング向けエージェントが稼働している。
オンラインモニターが実行前アクションの100%をカバーし、2026年8月に分析された10億件超の決定のうち0.002%（約47,000件に1件）がブロックされた。

3つ目は計算資源の配分で、2026年7月13日〜20日の1週間スナップショットでは、AI R&D向け計算資源の約6%、AI駆動のAI R&D向けの約12%が安全性業務に充てられている。

開発者への影響は間接的だが無視できない。
自動化率、監視、安全性への計算資源配分が具体的な数値で公開される最初期の事例であり、この測定がペーシング規制や第三者検証の枠組みとして定着すれば、Claudeモデルのリリース運用そのものに反映される可能性がある。

- **URL**: https://www.anthropic.com/institute/measuring-pace-of-ai-development

### ライフサイエンス向け検証プログラム「Life Sciences Verification Program」のベータ開始（2026-09-17）

Anthropicはライフサイエンス専門家を対象とするベータプログラム「Life Sciences Verification Program（LSVP）」を開始した。
一般提供中のFableモデルではブロックされる創薬、研究生物学、臨床開発、製造などの生物学関連タスクを、検証済みの組織がMythos、Opus、Sonnetの各モデルで、より寛容なセーフガード付きアクセスのもと実行できるようにする仕組みである。

グラントは2種類ある。
「Standard Useグラント」はMythos 5.1、Opus 5、Sonnet 5が対象で、チーム単位の付与、年次更新。
アドオンの「High-risk Useグラント」はOpus 5とSonnet 5が対象で、生物学リクエストをブロックするセーフガードをすべて解除し、単一研究プロジェクト単位、6ヶ月ごとの更新になる。
申請時には研究資格、セキュリティ基準、倫理的監督体制が審査される。

セキュリティは「共有責任」モデルに切り替わる点が特徴的だ。
リアルタイムブロックから、フラグ対象アクティビティのデータを30日間保持するオフラインモニタリングへ移行する。
保持データは訓練には使われず、サイバー分類器など生物以外のセーフガードは維持される。

提供面はファーストパーティAPIコンソール、Claude for Enterprise、Teamプランで、応募は `claude.com/form/life-sciences-verification-program` から受け付ける。
バイオ分野のアプリやエージェントを扱う開発者は、検証済み組織としてFableでは拒否される生物学タスクをAPI経由で実行できるようになる。
ただしBAA有効な組織、個人プラン、サードパーティプラットフォームは現時点で対象外である。

- **URL**: https://www.anthropic.com/news/life-sciences-verification-program

## 🧩 Platform リリースノート（API・SDK・Console）

### Compliance APIがClaude in Chromeセッションのトランスクリプト取得に対応（2026-09-18）

Compliance APIのローカルセッションエンドポイントが、Claude in Chromeセッションのトランスクリプトも返すようになった。
対象はユーザーのマシン上で実行されたセッションで、応答内では `product_surface` 値 `claude_in_chrome` で識別される。

Claude Enterprise組織向けのベータ提供で、既存のCompliance Access Keyと `read:compliance_user_data` スコープをそのまま使える。
エンタープライズの監査では、これまでのエクスポート対象に加えてブラウザ内のセッションも証跡として取れるようになったことを意味する。
破壊的変更はない。
詳細はドキュメントの「Sessions on users' machines」を参照。

- **URL**: https://platform.claude.com/docs/en/release-notes/overview

## ⌨️ Claude Code

対象期間内のリリースは9月17日付のv2.1.274とv2.1.275の2版で、いずれも実質的な変更を含む。
バグ修正のみのマイナーリリースはない。

### v2.1.275（2026-09-17）: claude.aiのskills/plugins同期とセッション復帰の耐性強化

#### claude.aiで有効化したskillsとpluginsのターミナル同期

claude.aiのアカウントで有効化されたskillsとpluginsが、同じアカウントでサインインしたターミナルセッションへ同期されるようになった。
Web UIで入れたスキルを、ローカルのclaudeコマンドで使い始めるための再設定が不要になる。
オプトアウトは設定の `syncClaudeAiSkills: false` または `syncClaudeAiPlugins: false`。

#### メッセージ一括送信のsend-nowキー

send-nowキー（ctrl+enterまたはctrl+x ctrl+s）が追加された。
現在のターンを中断し、キューに溜めたメッセージを一括送信できる。
送信済みとキュー中のメッセージはグレー表示で区別される。

#### プラグインと認証情報まわりのセキュリティ強化

プラグインの取得経路と、認証情報の扱いが強化された。
npmソースのプラグインは `npm pack --ignore-scripts` で取得して整合性検証され、パッケージのinstall scriptは実行されない。
サプライチェーン攻撃の定番経路であるインストールスクリプトの実行を、取得の段階で断っている。
あわせて、git、ssh、marketplaceのURLに含まれるパスワードやトークンが、メッセージ、ログ、`claude plugin marketplace list` の出力に表示されなくなった。

#### セッション復帰とtranscript破損への耐性

`--resume`、`--continue`、resume pickerが、malformedなtask-reminder、@-file、メッセージエントリを含むセッションで失敗・クラッシュする一連の問題が修正された。
forked / backgroundセッションでの `/rewind` が、バックアップコピー失敗時にゼロ埋めや欠損のファイルを復元する問題も直っている。
memoryファイル復元後のage noteがcompactionとresumeの前後で変化してprompt cache missを起こす問題の修正も入った。

#### その他の変更

Claude in Chromeのautoモードが、classifier承認呼び出しのper-site checkをbypassモードと同様にスキップするようになり、リダイレクト後の `browser_batch` が "Permission denied" になる問題が修正された。
Claude apps gatewayへのサインインでは、gatewayが示すサインインアカウントを保存前に確認するフローが入り、`/status` にも表示される。
`--system-prompt` 内の `__SYSTEM_PROMPT_DYNAMIC_BOUNDARY__` より上の部分がグローバルにキャッシュされるようになり、システムプロンプトの一部だけを差し替える運用でキャッシュ効率が上がる。
`/plugin install <plugin> --marketplace <source>` は、marketplace未追加のときに追加を提案してからインストールする。
VSCode拡張では、Memory dialog内で保存済みメモリの閲覧、編集、削除、変更差分タブの変更ごとのaccept / rejectボタン、`claudeCode.scrollToBottomOnSend` 設定が追加され、リロード後の権限モード、プロンプトキャッシュ時計、バックグラウンドエージェント完了通知の保持が修正された（2.1.269のregressionだったセッション名リネーム問題を含む）。
Claude Code on the webでは、ルーチン関連の通知文とcloud environmentのallowed-domainsリスト検証が改善された。
Claude TagはCloudWatch / SNS / Google Cloud MonitoringなどのCredentialsプリセットと、Datadog US3 / AP1 / AP2 / US1-FEDに対応した。
Code Reviewは、100件超のレビューがあるPRのマージ時再レビューを軽量化している。

- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.275

### v2.1.274（2026-09-17）: MCP起動の制御、メモリ警告、OTel拡充

#### メモリ使用量の警告とMCP起動待ちの上限

メモリ使用量が危険域に達した際の警告表示と、解放・安全な再起動の手順が追加された。
環境変数 `CLAUDE_CODE_MCP_STARTUP_WAIT_MS` で、初回非対話ターンのMCP接続待ち時間の上限を設定できる（`0` で待機しない）。
CIやheadless実行で、MCPサーバーの起動の遅さに初回ターンが引き延ばされるケースを呼び出し側で制御できるようになった。

#### v2 MCPクライアントのデフォルト化（挙動変更）

Bedrock、Vertex、Foundry、テレメトリ無効の各インストールが、デフォルトでv2 MCPクライアントとMCP 2026-07-28ネゴシエーションを使うようになった。
オプトアウトは `MCP_SDK_GENERATION=v1` または `MCP_PROTOCOL_NEGOTIATION=legacy`。
独自のMCP統合を抱える環境では、プロトコルネゴシエーションの挙動確認が必要になる。

#### 可観測性の拡充

`claude_code.llm_request` OTel spanに `effort` 属性が追加された。
`claude_code.managed_settings_resolved` イベントが追加され、`OTEL_LOG_MANAGED_SETTINGS=1` でredacted設定とダイジェストを出力できる。
Claude apps gateway設定には、Postgres接続タイムアウト（`store.connect_timeout_seconds`、デフォルト5秒）が加わった。

#### MCPと長時間稼働まわりの修正

破損transcriptによる "unexpected tool_use_id" 400エラーの無限リトライが修正された。
可能な場合は自己修復し、不可能な場合は `/rewind` のヒント付きエラーで停止する。
MCP関連では、legacy HTTP+SSEサーバが4xxを返すと接続失敗する問題、Streamable HTTPの約5分のタイムアウト（per-serverの `timeout` を尊重するように修正）、403 insufficient_scopeを期限切れと誤表示する問題、`listChanged` 未宣言サーバーのprompts / resources更新が修正対象に入った。
`claude agents` がauto-update再起動後に `--model`、`--effort`、`--permission-mode`、`--allow-dangerously-skip-permissions`、`--agent` を失う問題も直っている。

#### セキュリティ

`${VAR}` プレースホルダ解決後のシークレットが、MCP接続エラーとログに表示されなくなった。
特殊シェル変数へのループや代入を含むBashコマンドは権限を要求する。
worktree分離セッションでは、ネストされたシェル展開を拒否する。

#### VSCodeとその他

VSCode拡張では、リロードで中断されたステップの継続（Claude Code: Continue After Reload設定で無効化可）、CustomizeメニューのMemory / Instructionsエントリ、`claudeCode.lockEditorGroups` 設定が追加され、`~/.claude/settings.json` の書き込み競合による破損や設定消失が修正された。
Claude Code on the webはdiffビューの "Compare against" ブランチピッカーに対応し、ルーチンはGitHub接続の欠落時に最大72時間リトライする。
Code Reviewは、一時的なGitHubや内部サービスの障害時に待機してリトライする。

- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.274

## 🤖 Agent SDK

### TypeScript SDK v0.3.275（2026-09-17）: セッション再開とフォーク周りの修正

セッションの再開とフォークの不整合に集中した修正リリースで、Claude Code v2.1.275とパリティである。
resumed turnの冒頭でdeferred tool callが再実行され、`tool_use_result` であるべき結果が内部キー形式（`toolUseResult`）で出力される問題を修正した。
`getSessionMessages()` と `forkSession()` が、直前のターンの `result` メッセージの直後に呼ばれるとそのターンのassistantメッセージを取りこぼす複数のバグも直っている。
このほか、`forkSession({ upToMessageId })` がUUID形式でない `SDKUserMessage.uuid` を拒否する問題、Claudeの動作中に送信されたメッセージに対して `getSessionMessages` が返すidを `forkSession` が拒否する問題、forkで再実行プロンプトが2回表示される問題、ツール実行中にClaudeが消費したキューメッセージ（タスク通知など）が `getSessionMessages()` から漏れる問題が修正された。
セッションの保存、再開、分岐をアプリの機能として提供しているホストにとっては、取りこぼしの修正が揃った更新である。

- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.275

### TypeScript SDK v0.3.274（2026-09-17）: MCPサーバーの信頼判定情報と起動の可視化

MCPサーバーの起動まわりの制御と、スタートアップの可視化が中心の機能追加リリースで、Claude Code v2.1.274とパリティである。
ホスト側の信頼判定に必要な情報として、`canUseTool` のoptionsには `mcpServer: {name, source}` が、tool hookの入力には `mcp_server` が渡るようになり、MCP status行にも `source` が付いた。
どのサーバーがSDK由来かを `source === "sdk"` で判別できるため、SDKホストは設定ファイル由来のサーバーと区別して権限判定を実装できる。
`CLAUDE_CODE_MCP_STARTUP_WAIT_MS` で初回ターンのMCP接続待ちを制御・無効化でき、`CLAUDE_CODE_EMIT_STARTUP_TIMING=1` でstream-jsonホストが最初の `system/init` でフェーズごとの `startup_timing` 内訳を受け取れる。
既知の起動失敗で終了する前に書き出すエラー結果に `startup_failure_reason` が加わり、失敗の原因を機械的に取れるようになった。
ターン1が、searchでツール登録を遅らせるsettings / pluginsのMCPサーバーを最大2秒待たなくなる起動高速化も入っている（`options.mcpServers` のサーバーは引き続き待機する）。

- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.274

### Python SDK v0.2.155 / v0.2.154（2026-09-17）

両版ともバンドルClaude CLIの更新のみで（v0.2.155はClaude CLI 2.1.275、v0.2.154は2.1.274）、SDK自身の機能変更とバグ修正はない。

- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.155
- **URL**: https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.154

## 🔬 Research

### Claudeによるバイオ分子モデリングの高速化（2026-09-17）

#### OSS深層学習モデル30超を平均約4倍に高速化

Claudeが、構造予測、タンパク質設計、タンパク質言語モデル、ゲノミクス向けのオープンソース深層学習モデル30以上を高速化した。
推論最適化やカーネル開発の経験を持たないバイオ分子モデリング経験者2名の監督のもとで、4週間弱で完了している。
平均で約4倍（出力が完全一致する場合でも約2倍、構造予測モデルでは約1.6倍）の速度向上を、最小限の精度低下で達成した。

計算ボトルネックのtriangle attention / triangle multiplication向けに、独自GPUカーネル「FlashPairformer」を開発した点が技術的な中心である。
従来の標準を、triangle attentionで2.7〜2.9倍、triangle multiplicationで1.7〜3.2倍上回る新しいstate-of-the-artになった。
低メモリの「Big」モードにより、単一のNVIDIA GPUノードで10,000トークン超の分子機械（ヒトミトコンドリア複合体I、TRiCシャペロン複合体、プロテアソーム、細菌リボソーム）を正確に予測でき、31,000〜70,000トークン超のウイルスカプシドなどでも推論自体は成功した。

#### タンパク質設計を約150ドルで以前のキャンペーンと同等に

タンパク質設計では、Mythos 5.1、Mythos 5、Opus 5の3モデルが、サブエージェントなし、H200 1台、24時間、約1,100語のプロンプトという条件で16ターゲットに取り組んだ。
in silico結合スコアのipSAEで、約100倍のGPU時間を使った以前のキャンペーン（1ターゲット最大$10,000）と同等の結果に達している。
GPUとトークンの合計支出は約$150だった。

限界も明示されている。
訓練コンテキストの約2桁上の規模のシステムについては正しく予測できず、より大きな系への一般化の限界が示された。
最適化コードは全モデル分がGitHubで公開されている。
あわせて、Adaptyv Bioとのタンパク質設計コンペ（Claudeクレジット最大$100万、Modal計算クレジット$25万、5,000以上のデザインのウェットラバリデーション）と、Life Sciences Verification Programの公開ベータ開始が発表された。

- **URL**: https://www.anthropic.com/research/claude-uplifts-biomolecular-modeling
- 技術報告書（PDF）: https://www-cdn.anthropic.com/c03643714397d9d396fa1ce1794f5f9f7863a82c.pdf
- コード: https://github.com/anthropics/uplifting-biomolecular-modeling

## 📝 まとめ

対象期間の中心はライフサイエンスへの展開だった。創薬や研究生物学のタスクを検証済み組織に開放するLife Sciences Verification Programのベータ開始と、Claudeによるバイオ分子モデリング高速化の研究発表が同日に出揃い、コード公開とクレジット総額最大125万ドルの設計コンペまで動いた。あわせて社内AI R&Dの26%をClaudeがリードレベルで担うなど、開発ペースの測定値公開も初めて行われた。Claude Codeはv2.1.274/275の大型2本である。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。
追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
