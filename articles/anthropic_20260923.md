---
title: "Anthropic更新ダイジェスト - 2026年09月23日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月22日から9月23日の2日分です。

この期間の更新は一言でいえば「Claude Opus 5.5のローンチ」一色でした。

公式発表からPlatformのリリースノート（破壊的変更を含む）、claude.aiへの搭載、Claude Code v2.1.280でのデフォルトモデル化まで、単一のモデル発表がスタック全体を一気に貫いた珍しい2日間になっています。

APIを直接叩く開発者にとっては、thinking無効化の廃止や`tool_choice`の制限といった移行作業が即座に効いてくるため、マイグレーションガイドの確認が最優先です。

一方でClaude Codeのv2.1.280は、モデル追従以外にもシンボリックリンク経由の書き込み判定修正やダイアログ操作の統一など、セキュリティと操作感に効く変更が多数入っています。

来週以降はSonnet 5.5とHaiku 5.5が「数週間中」に続く予定なので、5.5ファミリーへの移行計画はこの時点で立てておくのが良さそうです。

## 📰 News（Anthropic発表）

### Claude Opus 5.5発表 — 新ファミリー「Claude 5.5」の第1弾

https://www.anthropic.com/claude-opus-5-5

Anthropicが新ファミリー「Claude 5.5」の最初のモデルとしてClaude Opus 5.5を公開しました。

APIモデルIDは`claude-opus-5-5`で、Sonnet 5.5とHaiku 5.5が数週間中に続きます。

価格は100万トークンあたり入力$4／出力$20で、Opus 5（$5／$25）から約20%の値下げです。

キャッシュ読み取りは$0.20まで下がっており、こちらは60%の低減になっています。

これらを合算した通常ワークロードでの総コストはOpus 5比でおよそ40%低下し、出力速度も30%超の高速化を主張しています。

なお最大2.5倍速のFastモードは入力$8／出力$40で提供されます。

ベンチマークでは、Terminal-Bench 4.0で66.4%（xhigh effort）を記録し、Fable 5.1の55.8%やGPT-6 Astraの57.9%を上回りました。

FrontierCode v1.1でも54.4%となっており、コーディング・エージェントworkloadでの競争力が価格面と性能面の両方で強化されています。

提供はAWS・Google Cloud・Microsoft Azure・Claude Platformの全プラットフォームで即日開始です。

Pro／Max／Team／シート制Enterpriseプランでは5時間あたりの利用上限が引き上げられ、レート制限のリセットを保存できるようになりました。

上限に達して待たされる時間が減るのは、長時間のエージェント実行を実運用しているチームにとって実質的なスループット向上です。

安全性についても、約2,000シナリオの自動行動監査で包囲回避（containment circumvention）の試みがOpus 5やClaude Mythos 5.1比で約85%少ないと報告されています。

セーフガードはFable 5.1と同等の水準（サイバー、バイオ、蒸留耐性）で、ゼロデータリテンションとEU AI Act対応のウォーターマークを備えます。

ただしthinkingモード無効化オプションは提供されません。

この点はPlatform側の破壊的変更として後述します。

## 🧩 Platform リリースノート（API・SDK・Console）

### Claude Opus 5.5 ローンチ（破壊的変更あり）

https://platform.claude.com/docs/en/release-notes/overview

長時間稼働のエージェント型コーディングとナレッジワーク向けの新モデルClaude Opus 5.5（`claude-opus-5-5`）が公開されました。

コンテキストウィンドウはデフォルトで100万トークン、最大出力は128kトークンで、アダプティブシンキングが常時有効です。

価格は入力$4／出力$20 USD per MTokで、Opus 5（$5／$25）より約20%低価格です。

Claude API、Amazon Bedrock、Claude Platform on AWS、Google Cloud（Vertex AI）、Microsoft Foundryで利用できます。

あわせてFast mode（research preview）と、会話途中のsystemメッセージ内でのツール定義（beta）が発表されました。

**破壊的変更** — APIユーザーは移行前に必ず確認してください。

1つ目は、Opus 5.5ではthinkingを無効化できない点です。

`thinking: {"type": "disabled"}` および `thinking: {"type": "enabled", ...}` は400エラーを返します。

`thinking`フィールドを省略し、effortパラメータで深さを制御してください。

2つ目は、`tool_choice`の`any`と`tool`がFable 5.1と同様に400エラーとなる点です。

`auto` + strict tool useへの移行が求められます。

3つ目は、computer useに関して、APIとGoogle Cloudでは`computer_toolset_20260801`ツールセットが必須になった点です。

旧`computer_20251124`は400エラーになりますが、Amazon Bedrockでは`computer_20251124`が引き続き動作します。

プロバイダ間で挙動が異なるため、マルチクラウド構成ではコードパスの分岐が必要です。

Fast mode（research preview）はClaude API上のOpus 5.5で利用可能になりました。

レイテンシ重視のワークロードで、通常モードの最大2.5倍速（News発表の数値）を選べるようになっています。

インラインツール定義（beta、Claude API、beta header: `inline-tools-2026-09-15`）は、会話途中のsystemメッセージ内でツールを定義できる機能です。

`tool_addition`ブロックがツールの完全な定義を運べる（`tool: {"type": "tool_definition", "definition": {...}}`）ため、`tools`を編集せずにツール追加・スキーマ変更・サーバーツールの新バージョンへの移行が可能です。

しかもプロンプトキャッシュを無効化しません。

長い会話でツール構成を変えたい場合、これまではキャッシュ失効と引き換えになっていた場面を、コスト増なしに扱えるようになったのが本質的な価値です。

同じヘッダで参照によるツールの追加・削除もカバーしています。

MCP connectorと組み合わせる場合（beta header: `mcp-client-2026-09-15` も付与）は、定義としてMCPツールセットを指定できます。

レスポンスは各サーバーが取得したツールリストを`mcp_tool_listing`ブロックに記録し、送り返すとそのリストが固定される仕組みです。

マイグレーションガイドは https://platform.claude.com/docs/en/models/opus-5-5/migration-guide に、What's newは https://platform.claude.com/docs/en/models/opus-5-5/whats-new-opus-5-5 にあります。

## 💬 Claude Apps リリースノート（Claude.ai・Cowork等）

### Claude Opus 5.5 が各アプリのモデル選択肢に追加

https://support.claude.com/en/articles/12138966-release-notes

Claude 5.5ファミリーの第1弾となる新フラッグシップモデル「Claude Opus 5.5」が、claude.aiなど各アプリのモデル選択肢に加わりました。

ほとんどのワークロードでFable 5.1に匹敵する性能を持ちながら、実行コストはClaude Opus 5比40%削減という価格効率が特徴です。

最上位クラスのモデルを従来より低コストで使えるようになるため、利用頻度の高いPro／Maxユーザーほど恩恵は大きくなります。

関連リンク: https://www.anthropic.com/claude-opus-5-5

## ⌨️ Claude Code

### v2.1.280（2026-09-22）— Opus 5.5をデフォルトモデルに

https://github.com/anthropics/claude-code/releases/tag/v2.1.280

新モデルClaude Opus 5.5（`claude-opus-5-5`）を追加し、デフォルトのOpusモデルに据えた大型リリースです。

1Mコンテキスト、$4/$20 per Mtok、キャッシュ読み$0.20/MtokがCLI側の表記としても反映されています。

さらにPro・Team StandardプランのデフォルトモデルがSonnetからOpusへ変更されました。

Max・Team Premium・Enterpriseと揃いです。

デフォルトでOpusクラスが動くようになるため、プランの利用上限消費が速くなる可能性があります。

コストを意識する場合は明示的にSonnetへ戻す設定を検討してください。

機能面では、`CLAUDE_CODE_MAX_MCP_DESCRIPTION_LENGTH` 環境変数が追加されました。

セッション内の全MCPサーバーを対象に、MCPツール説明文とサーバー指示の2,048文字上限を変更できます。

独自のMCPサーバーで詳細なツール説明を配りたい場合の詰まりどころが解消されます。

セキュリティ関連では、シンボリックリンク経由の書き込みをリンク先の実体で判定するよう修正されました。

これにより`acceptEdits`・allowルール・auto modeが、ツリー外への書き込みを承認しなくなっています。

プロジェクト内のファイルへのsymlinkがリポジトリ外を指していた場合に、実質的な脱獄経路になっていた問題の修正です。

auto modeまわりも堅牢化されています。

安全性チェックに拒否されたアクションを再試行し続ける問題が修正され（1回で拒否を通知）、無回答時に無制限に拒否し続ける問題もバックオフと10連続で停止する挙動に変わりました。

操作性では、ほぼすべてのダイアログ（`/model`、`/effort`、`/config`、`/status`、`/usage`、`/plugin`、`/sandbox`、`/permissions` ほか）で、Ctrl+C / Ctrl+Dの2回押しがダイアログを閉じずClaude Code自体を終了してしまう問題が修正されました。

またダイアログで押した`n`/`y`が確定・キャンセルとして作用する問題も修正されています。

Enter=確定、Esc=キャンセルに統一され、旧挙動に戻したい場合は`keybindings.json`で`confirm:yes`/`confirm:no`に割り当てることで戻せます。

安定性では、「role 'system' must precede an 'assistant' message」エラーで毎ターン会話が失敗する問題と、アドバイザー非対応のプロキシ/ゲートウェイ背後でAPI Error 400が出る問題（アドバイザー無しでリトライ）が直りました。

バックグラウンドサブエージェントについては、ヘッドレス/SDKセッションで送信メッセージが消失する問題、起動元の会話がコンパクションされると完了レポートが失われる問題、LSPプラグイン有効時にLSPツールを使えない問題などが修正されています。

フルスクリーンモードのリストにマウス対応が拡大し、ホイールで`/skills`一覧をスクロール、`/plugin`のスキル状態オプションをクリックできるようになりました。

一方で2.1.260で追加されたフルスクリーン時の`ctrl+l` / `cmd+k`によるトランスクリプト表示クリアは取り消され、再び画面再描画の動作に戻っています。

`/permissions`も改善され、ルール閲覧・追加・削除後にフォーカスがルール一覧へ戻り、削除確認のデフォルトがNoになりました。

←/→やTabでタブを直接切り替えられます。

モデル移行に関連して、旧モデル向けに保存されたeffortレベルが、Opus 5.5などの新モデルには適用されないよう変更されました（デフォルトから開始）。

VS Code拡張には`/status`・`/sandbox`・`/chrome`・`/export`・`/skills`・`/plan`の各ダイアログが追加されています。

Python拡張がアクティベーション中にハングしてもClaude Codeが起動しない問題も修正されました（60秒後に起動）。

Claude Code on the webでは、GitHub Enterprise Serverリポジトリのクラウドセッションで約8時間後に`gh`やGitHub API呼び出しが失敗する問題が修正されています（トークン自動更新）。

管理者のRoutines設定はAdmin settings → Capabilities → Remote sessionsへ移動しました。

Claude Tag（Slack連携）には、チャンネルのSlackスレッドにWorking表示・Stopボタン・スレッドタイトルが追加されています。

Stopでタスクを中断できるようになりました。

`hook_execution_complete` OpenTelemetryイベントには、フック出力サイズと保存されたoversized出力の数が追加されています。

## 🤖 Agent SDK

### TypeScript v0.3.280（2026-09-22）

https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.280

スケジュールタスクやMCP Apps連携などホスト側制御まわりの機能追加が中心のリリースで、Claude Code v2.1.280にパリティしています。

注目は`verbatimPrompts`オプションの追加です。

プロンプトが入力どおりそのままClaudeに届き、`@path`展開・スラッシュコマンド・アンビエント添付をすべてスキップします（Claude Code 2.1.248+が必要）。

SDK上でプロンプトを自前で完全制御したいホストアプリにとって、暗黙の変換がなくなるのは大きな改善です。

スケジュールタスク関連では、タスク通知オリジンにオプションの`fireReason`が追加されました。

またローカルホストが宣言したスケジュールタスクの起動は、`CLAUDE_CODE_HOST_SCHEDULED_RUN=1`付きで起動されたプロセス内でのみカウントされるようになっています。

MCP Apps連携では、`mcpServerStatus()`のツールエントリに`_meta`が追加され、各ツールのMCP Apps `ui`メタデータ（`ui://`リソースの場所）をホストから参照可能になりました。

あわせて、Claude Code接続済みのMCPサーバーから`ui://`リソースを読む`readMcpResource()`（alpha）が追加されています。

`askSideQuestion()`も改善され、ターン中に質問した場合、直前に完了したターンだけでなく実行中ターン（プロンプト・返信・ここまでのツール結果）を参照できるようになりました。

無人実行のリトライ（`CLAUDE_CODE_RETRY_WATCHDOG`）も強化されています。

usage-limit待ちの開始時に`rate_limit_event`（`rejected` / `resetsAt`）が送出され、サブエージェントの待機中も`api_retry`ハートビートが継続します。

`session_state_changed`イベント（`CLAUDE_CODE_EMIT_SESSION_STATE_EVENTS=1`でオプトイン）は、MCP elicitationのユーザー待ちで`requires_action`を報告するよう変更されました（パーミッションプロンプトと同挙動）。

ヘッドレスセッションでは、MCPサーバーの保留中フォーム質問が、それを引き起こしたツール呼び出しの終了時にキャンセルされるようになっています。

### Python SDK

対象期間内の新しいリリースはありませんでした（最新はv0.2.156・2026-09-18で前回分として処理済み）。

## 🚨 障害・ステータス

### 複数モデルでエラー率上昇（解決済み）

https://status.claude.com/incidents/7g1qpkyz5gxh

9月22日 00:50 UTC〜02:10 UTCの約80分間、Claude Mythos 5.1 / Claude Fable 5.1 / Claude Opus 5のAPIリクエストでエラー率が上昇する問題が発生しました。

00:57 UTCに調査開始を発表し、01:17 UTCに原因を特定。

01:35 UTC時点でMythos 5/5.1とFable 5/5.1は正常に回復し、残ったClaude Opus 5のエラーも02:11 UTCに成功率が正常へ戻り、02:35 UTCに解決を確認しています。

複数の主要モデルが同時に影響を受けた点で規模の大きいインシデントですが、収束はOpus 5.5のローンチと同日（02:35 UTC確認）です。

## 📝 まとめ

最大のトピックはClaude Opus 5.5（`claude-opus-5-5`）のローンチです。入力$4／出力$20 per MTokとOpus 5比約40%のコスト削減、Terminal-Bench 4.0で66.4%を記録し、全主要クラウドとclaude.ai、Claude Codeのデフォルトに即日投入されました。一方でthinking無効化不可や`tool_choice`制限など破壊的変更を伴うため、APIユーザーはマイグレーションガイドの確認を優先してください。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。

追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
