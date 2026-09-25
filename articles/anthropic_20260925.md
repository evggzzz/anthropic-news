---
title: "Anthropic更新ダイジェスト - 2026年09月25日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月24日から9月25日の2日分です。

表紙面は静かで、News、Appsのリリースノート、Engineeringブログ、ステータスには対象期間内の新規エントリがありませんでした。

動きは開発者ツール側に集中しています。

中心はClaude Code v2.1.282という大型リリースで、貫くテーマは「セッションを正しく引き継ぐ」ことです。

web searchの履歴が残る会話で毎リクエスト400エラーになる問題や、`--continue`/`--resume`時に過去メッセージが改変されて過去の推論がAPI側で破棄される問題など、会話の連続性を壊す不具合がまとめて修正されました。

TypeScript Agent SDK v0.3.282が同じ日のパリティ更新で追随し、軽量エントリーポイント`@anthropic-ai/claude-agent-sdk/core`とプロセス事前起動の`prewarm()`が加わっています。

Platform側にはAPI利用者の請求に直結する変更が1件入り、出力前refusalの一部カテゴリが新たに課金対象になりました。

研究面では、エージェントに人間の代理で取引を任せた場合の限界を数値で測った交換実験「Project Swap」が公開されています。

## 🧩 Platform リリースノート（API・SDK・Console）

### 出力前refusalの課金対象が3カテゴリに拡大（2026-09-24）

https://platform.claude.com/docs/en/release-notes/overview

Claude APIのrefusal（拒否応答）の課金ルールが変わりました。

出力が始まる前に到着したrefusalのうち、`stop_details.category`が`"bio"`、`"frontier_llm"`、`"reasoning_extraction"`の3カテゴリであるものが、新たに課金対象になります。

これまで出力前のrefusalは原則として課金されず、課金対象はストリーミング途中（mid-stream）のrefusalだけでした。

新たに課金されるrefusalは通常のリクエストと同様に、実行されたモデルのレートで課金されます。

この3カテゴリが選ばれたのは、誤検出が少ないカテゴリとして測定されているためです。

APIシェイプの破壊的変更はありません。

ただし課金動作の変更であり、該当カテゴリの出力前refusalが発生するワークロードでは請求額が増える可能性があります。

意図しない拒否応答への対処をしている場合、コスト監視の対象にrefusalを含めておく必要があります。

対象外カテゴリの出力前refusalは引き続き課金されず、fallbackクレジットの扱いも変更ありません。

変更はClaude APIに限らず、Amazon BedrockやGoogle Cloudを含むすべてのプラットフォームに適用されます。

詳細はドキュメント「How refusals are billed」を参照してください。

## ⌨️ Claude Code

### v2.1.282（2026-09-24）

https://github.com/anthropics/claude-code/releases/tag/v2.1.282

新設定の追加と大量の修正を含む大型リリースです。

修正の多くが「会話の履歴を正しく引き継ぐ」という点に集約されています。

web searchの結果を復号できない履歴を含む会話で、毎リクエスト400エラーになる問題を修正しました。

`--continue`や`--resume`で再開したセッションで、過去メッセージが改変された状態で再送され、Claudeの過去の推論がAPI側で破棄される問題も追加修正されています。

「Invalid `data` in `redacted_thinking` block」エラーについては、thinking blocksを落として1回だけリトライすることで解消しました。

`/model`などのスラッシュコマンド実行時や、`--tools`指定付きでの再起動時にextended thinkingが失われる問題も修正です。

それに加えて、非常に大きいセッション（未コンパクションのセッションを含む）のresumeが高速化されました。

セッションをまたいで長く作業する使い方では、このリリースの影響が大きいはずです。

動作変更は4点入っています。

1つ目は、テレメトリを無効化した直接のAnthropic API接続で、Auto modeがサーバー側のclassifierをデフォルトで使うようになったことです。`CLAUDE_CODE_AUTO_MODE_SERVER=0`でオプトアウトできます。

2つ目は、プロジェクト設定とローカル設定のOpenTelemetry変数（`CLAUDE_CODE_ENABLE_TELEMETRY`、`OTEL_LOG_*`など）を無視するようになったことです。

3つ目は、`Skill(anthropic-skills:*)`と`Skill(claude-ai:*)`のallowルールをclaude.ai同期スキルのみに限定したことです。

4つ目は、`sandbox.excludedCommands`がmanaged settingsや`--settings`で`allowUnsandboxedCommands: false`が適用されている場合、プロジェクト設定とローカル設定のエントリを無視するようになったことです。

いずれも権限とテレメトリを組織側の設定で制御する方向の変更です。

プロジェクト設定に書いても効かなくなる項目があるため、移行時には設定の所在を確認してください。

無視された設定変数は、起動時の通知と`/status`、`claude doctor`に表示されるようになったため、気付きやすくはなっています。

新設定は2つです。

`maxProseWidth`でワイド端末における文章の幅を上限化できます。表とコードブロックは従来どおり全幅です。

managed設定の`allowClaudeInChromeWithManagedMcp`が追加され、排他的な`managed-mcp.json`との併用で`claude --chrome`を許可できるようになりました。

それ以外の修正も実用上の影響が大きいものが揃っています。

Bash permission rulesの中間に`:*`を含むパターンが設定ファイルで無視される問題と、managed settingsの1つの不正なネスト値で`permissions`、`autoMode`、`worktree`、`attribution`ブロック全体が無効化される問題を修正しました。

プラグインのアンインストール時に保存済みoptionsやsecretsを誤って削除する問題、`/install-github-app`がキャンセル扱いでもブランチpushとAPI key secretの保存を続行する問題も直っています。

Vim modeは`>>`が空行をインデントする問題、`dd`後のカーソル位置、`2dd`などのカウント指定、折り返し行での`p`/`P`と修正が多数です。

CJK文字や絵文字の折り返しでdiffの最終列にゴミが残る描画問題も修正されました。

周辺環境では、VS Codeで長い返信のストリーミングがlagする問題（パネルが毎回全文を再パースするため）と、Remote ControlセッションがWebエントリから開けない問題を修正しています。

Cloud sessionsでは、GitHub Appの状態をSettings › Connectors › GitHubに表示するようになり、インドなど30分オフセットの時間帯でroutineの次回実行時刻が30分ずれる問題を修正しました。

Claude Tag（Slack）では、Enterprise Gridでのチャンネル自動参加パターンが無視される問題、引退済みモデルへのフォールバックが毎返信繰り返される問題、cloud worker再起動後にコストとトークン表示が倍増する問題などを修正しています。

## 🤖 Agent SDK

### TypeScript v0.3.282（2026-09-24）

https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.282

Claude Code v2.1.282とのパリティ更新で、ホスト側の制御と起動レイテンシに関わる3つの追加が入りました。

1つ目は、ホスト提供の`managedSettings`でマーケットプレイスの許可とブロックを制御できるようになったことです。

`strictKnownMarketplaces`は管理者ポリシーがない環境で適用される許可リストで、`blockedMarketplaces`は管理者ポリシーに積み重ねて適用されるブロックリストです。

ホストアプリからSDKを動かす場合、ユーザーが任意のプラグインソースを読み込む範囲を限定できます。

2つ目は、軽量エントリーポイント`@anthropic-ai/claude-agent-sdk/core`の追加です。

`query`、MCP tool helpers、session mutations、`resolveSettings`を含み、zodとMCP SDKは利用側のインストールに依存します。

バンドルアプリ向けで、SDK本体に依存を抱え込まずに済む選択肢になります。

3つ目は、`prewarm()`と`SpareProcess.claim()`（alpha）の追加です。

セッションの開始前にClaude Codeプロセスを事前起動しておき、後からフォルダとper-session optionsを紐付けられます。

エージェントを大量に起動するアプリではプロセス起動待ちがレイテンシの一部になるため、事前起動はその削減策として機能します。

修正として、`readMcpResource()`がCLI予約の`com.anthropic/`プレフィックスを持つ`_meta`キーを中継しないようになりました。tool resultsと同様に破棄されます。

Python SDKに対象期間内の新規リリースはありません。

直近のv0.2.159とv0.2.158は2026-09-23リリースで、前回分として処理済みです。

## 🔬 Research

### Project Swap: エージェントに取引を任せると何が起きるか（2026-09-24）

https://www.anthropic.com/research/project-swap

Anthropicの経済研究チームが、Claudeエージェントに人間の代理で取引を任せた場合に何が機能し何が壊れるかを検証する交換実験「Project Swap」を公開しました。「Project Deal」の続編です。

実験では、6拠点の社員201人が持ち寄った本を、Claudeが事前の半構造化チャットで各人の好みを把握したうえで、デジタル取引フロアで交換しました。

結果を読む鍵は、2つの数字の対比です。

Claudeがチャットから構築した好みのランキングは、参加者自身のランキングと61%のペアで一致しました。ランダムの50%、人気度ベースの53%を上回る数値です。

一方、最終的な割り当ては本人ランキングで0.55となり、功利的最適の0.89には届きませんでした。

分析によると、この不足の85%は好みの表現の不正確さに起因し、エージェント間の交渉に起因する部分は15%にとどまります。

つまり、委任のボトルネックは交渉能力ではなく、代理人が本人の好みをどこまで正確に掴めているかという点にあります。

モデル比較の結果も示唆的です。

フロアを単一モデルにそろえて比較したところ、Opus 4.8が最良の成果（0.88、最適値0.95）を上げ、その影響は「冷酷」対「プロソーシャル」という指示の差（わずか0.02）を大きく上回りました。

エージェントに任せる仕事では、プロンプトでの性格付けよりもモデル選択のほうが結果を左右するという読み方ができます。

参加者の平均満足度は7.2/10でした。

限界として、社員サンプルで代表性が限られること、エンドライン調査の回答率が59%であることによる選択バイアス、敵対的エージェントを検証していないことが明記されています。

[本文PDF](https://www-cdn.anthropic.com/3818cf6119b88f9714d995f6549fa8aac0bd5ab5/Project-Swap.pdf)と[付録PDF](https://www-cdn.anthropic.com/files/4zrzovbb/website/7dcd7d8de6e132048f391f5201439c5e11b9fb2c.pdf)が公開されています。

## 📝 まとめ

今期の主役はClaude Code v2.1.282です。履歴起因の400エラーや`--continue`/`--resume`時のextended thinking消失など、セッションを正しく引き継ぐための修正が複数入り、大きなセッションのresumeも高速化しました。テレメトリ無効環境でAuto modeがサーバー側classifierをデフォルト使用する動作変更も含むため、自動運用している環境では挙動の確認をおすすめします。TypeScript SDK v0.3.282も軽量エントリーポイントと`prewarm()`で追随しています。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。

追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
