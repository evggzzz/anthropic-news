---
title: "Anthropic更新ダイジェスト - 2026年09月26日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月25日から9月26日の2日分です。

News、Platformのリリースノート、Engineeringブログ、ステータスには対象期間内の新規エントリがなく、動きは開発者エコシステム側に集中しました。

軸になるのはClaude Code v2.1.283です。TypeScript Agent SDK v0.3.283とPython Agent SDK v0.2.160が同日にCLI 2.1.283同梱で追随し、3コンポーネントが一体で更新されました。

Claude Codeの目玉は企業利用をにらんだ2つです。1つのユーザープロンプトから生じる大量のAPIリクエストをゲートウェイ側でグルーピングするヒントヘッダと、組織がモデルのバージョンを統制するための管理設定です。

エコシステム面では、プラグインをClaudeディレクトリに提出できる開発者ポータルが公開され、プラグイン配布の入口が整いました。

研究面では、Claudeが素粒子論の9ループ振幅を計算した結果が公開され、第三者による独立検証も済んでいます。

## 💬 Claude Apps リリースノート（Claude.ai・Cowork等）

### プラグイン開発者向けポータルが公開（2026-09-25）

https://support.claude.com/en/articles/12138966-release-notes

Claude向けプラグインを作るクリエイター向けに、新しいデベロッパーポータルが公開されました。

クリエイターはポータルからプラグインをClaudeディレクトリに提出し、審査の進行状況を追跡できます。

公開後は利用状況のアナリティクスも確認できます。

ポイントは、プラグインのライフサイクル（提出、審査、公開、計測）が1か所にまとまったことです。

Anthropic公式ブログでも「Build plugins for Claude」としてこの流れが紹介されています。

https://claude.com/blog/build-plugins-for-claude

公式ディレクトリ経由で配る土台が整うと、Claude側にない機能をサードパーティが補完する構図が作りやすくなります。

プラグインを作る予定がなくても、ディレクトリに何が並び始めるかはClaudeの使い勝手に効いてくるため、動きを知っておく価値があります。

## ⌨️ Claude Code

### v2.1.283（2026-09-25）

https://github.com/anthropics/claude-code/releases/tag/v2.1.283

新機能の追加と修正が多数入った大型リリースで、テーマは企業利用でのリクエストの見える化とモデル統治です。

1つ目の新機能は、LLMゲートウェイ向けのプロンプト単位リクエストグルーピングです。

ゲートウェイヒントヘッダに`x-claude-code-prompt-id`が追加され、`CLAUDE_CODE_GATEWAY_HINT_HEADERS=1`で有効化すると、1つのユーザープロンプトに対応するリクエスト群をゲートウェイ側で束ねて識別できます。

Claude Codeは1回の指示に対して内部で複数回APIを呼ぶため、ゲートウェイのログでは同一業務のリクエストが別々の行に並びがちです。

プロンプトIDが付くことで、コストの按分やレート制御をプロンプト単位で行えます。

2つ目はモデル統治のための管理設定2つです。

`availableModelsMatch`に`"exact"`を指定すると、`availableModels`のエントリは名称どおりのモデルバージョンだけを許可し、新リリースは明示的に登録するまでブロックされます。

`deniedModels`は、`availableModels`が許可していても特定モデルを個別にブロックできるブロックリストです。

許可リストとブロックリストの組み合わせで、組織は「どのモデルバージョンで動くか」をコントロールできます。

コスト予測やコンプライアンスのためにモデルを固定したい環境では、新しいモデルが勝手に選ばれるリスクを減らせます。

3つ目は`/doctor prompt-audit`（別名`/checkup prompt-audit`）の追加です。

CLAUDE.md、スキル、エージェント、コマンドに残る旧モデル向けのプロンプト記述を監査します。

プロンプト資産は書いた当時のモデルに最適化されがちで、モデルを切り替えると効かない記述が残り続けます。

監査がコマンド化されたことで、モデル移行のときに資産の見直し漏れを機械的に拾えるようになりました。

観測性も広がっています。

`OTEL_LOG_TOOL_CONTENT=1`時のOpenTelemetry `tool.output`スパンイベントに、MCPツール、WebFetch、WebSearchの出力が含まれるようになりました。

このほか、テスト・計測用にリクエストを構築・署名するだけで上流へ送らない`load_test_mode`ブロックと、Amazon BedrockのMantleエンドポイント向け`mantle` upstream providerが加わり、全画面モードでは他セッションの省略されたメッセージをクリックで展開できるようになりました。

動作変更で押さえるべきは2点です。

1つ目は、サードパーティプロバイダ利用時やテレメトリ無効時の対話セッションが、権限モード未設定だとauto modeで開始するようになったことです。`permissions.defaultMode`の設定が優先されるため、明示的に設定していれば影響しません。

2つ目は、v2.1.282で予約した`claude-ai`という名前の予約を撤回したことです。スキル、コマンド、ワークフローがこの名前で再び読み込めます。

修正はMCP周りが厚いです。

バックグラウンド移行後のツールでprogress通知が破棄される問題、セッション終了時にstdio MCPサーバーが起動中のまま残留する問題、statelessリモートMCPへの一時的な404でそのサーバーがセッション中ずっと使えなくなる問題を修正しました。

`/mcp`のツールリストは一覧性とマウス操作に対応して改善され、組織にブロックされたツールには警告アイコンが表示されます。

MCPツールが返す画像もファイルに保存され、BashやReadから開けるようになりました。

プラグイン周りの修正も多くなっています。`claude plugin validate`の検出漏れ、`plugin details`でMCPサーバー数が0と表示される問題、大文字小文字違いのプラグインIDを`uninstall`が誤って削除する問題、`installed_plugins.json`破損時の復旧などです。

Windowsでは、PowerShellツールが`cmd /c rd`や`del`経由で、`Remove-Item`が拒否するドライブルートやホームフォルダを削除できてしまう問題を修正しました。ガードの抜け道を塞ぐ修正です。

そのほか、vim modeとキーバインドの修正（`.`リピート、`J`の挙動、`ctl+k`のような誤字モディファイアの検知）、`DISABLE_TELEMETRY`設定時に有料プランでRemote Controlが使えない問題、gitリポジトリのサブディレクトリでauto-memoryの自分のメモ編集が機密ファイル書き込み扱いでブロックされる問題、起動と初回応答の高速化（`claude -p`とRemoteが対話UIを読まなくなる）が入っています。

周辺機能では、Cloud sessionsが実行中セッションへのリポジトリ追加で読み取り専用のプライベートリポジトリをアタッチ可能になり、Claude Tagに「Channels Claude can search」の管理者設定（Slack検索を追加済み公開チャンネルに限定）が加わりました。

GitHubのCode Reviewでは、`@claude review`がPRを返せないときに無反応になる問題を修正し、時間制限で止まった未検証レビューは未完了表示で課金しないようになりました。

## 🤖 Agent SDK

### TypeScript v0.3.283（2026-09-25）

https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.283

Claude Code v2.1.283とのパリティ更新で、障害の見える化とセッション分岐の正しさが向上しました。

`SDKSystemMessage`（`system/init`）に`plugin_errors`が追加され、`--plugin-dir`で渡したエントリのうち読み込みに失敗したものを`path`付きで受け取れます。

プラグインの読み込み失敗がこれまで黙って捨てられていたのに対し、ホストアプリ側で型として検知できるようになりました。

セッション分岐のバグも修正されています。

`getSessionMessages()`が巻き戻しで放棄されたブランチを返し、`forkSession()`が同じブランチをコピーする問題で、最新ブランチがmeta行やローカルコマンドの行で終わっているときに発生していました。

ストリーミング出力も変わります。

ターン中に発生した警告や通知が、これまでは破棄されていましたが、`system/informational`メッセージとして受け取れるようになりました。

`set_max_thinking_tokens`の制御リクエストは、`max_thinking_tokens`の省略で現在の思考バジェットを維持、`null`送信でセッション既定値にリセット、という意味になりました。

### Python v0.2.160（2026-09-25）

https://github.com/anthropics/claude-agent-sdk-python/releases/tag/v0.2.160

バックグラウンドサブエージェント使用後にフォローアップターンが「Stream closed」で失敗する、実用上重大なバグの修正が主眼です。

`query()`でhooks、`can_use_tool`、SDK MCPサーバーを使っている場合、サブエージェントの完了とターン結果の到着が重なるとstdinが早期クローズされていました。

SDKがCLIの`session_state_changed`メッセージを購読し、CLIが`idle`を報告するまでstdinを開き続ける方式に変わり、TypeScript SDKと同じ挙動になりました。

無限待機を避けるため待ち時間には上限があり、`CLAUDE_CODE_PRINT_BG_WAIT_CEILING_MS`で設定できます（既定10分）。

stateイベントを持たない旧CLIでは、従来どおり最初の結果で閉じるフォールバックに入ります。

バンドルCLIは2.1.283に更新されています。

## 🔬 Research

### Claudeが9ループ振幅を計算した「Yes, Claude can do Nine Loops」（2026-09-25）

https://www.anthropic.com/research/yes-claude-can-do-nine-loops

理論素粒子物理学の「amplitudeology」分野で、平面N=4超対称Yang-Mills理論における9ループMHV 6粒子（六角形）振幅をClaude（Fable 5.1）が計算しました。

背景には、素粒子論者のMatt von HippelがAI企業に出していた公開挑戦があります。8ループ計算の先へ進められるかという挑戦で、1ヶ月後に達成されました。

実行の仕組みは、AnthropicのLiam FitzpatrickとSiddharth Mishra-SharmaがClaude Scienceハーネス（LLMを構造化ルールとプロンプトで包む仕組み）で1行のプロンプトを与え、あとはほぼ自律的に動かしたというものです。

ClaudeはPython+SymPyのコードを一から書き、直接ブートストラップ法と、antipodal duality経由の間接的form-factorアプローチという独立した2つの方法で解きました。

別経路で同一の答えに到達したことと、8ループ計算の経験者であるLance Dixon（SLAC/Stanford）が独立に検証したことが、結果の信頼性を支えています。

コストの数字も示唆的です。総額は約1,000〜2,000ドルで、ブートストラップ部分は約100ドル（96CPU×1週間相当）でした。

一方で限界も明記されています。新しい手法の発明ではなく既知手法の高計算量適用であること、対象が手法開発用の「toy model」理論で現実の物理ではないこと、競合の多い現実の振幅計算への一般化は未確認であることです。

9ループの結果本体は[smsharma.ioのページ](https://smsharma.io/cosmic-nine-loops/)で、同時進行したSong Heグループの結果は[Zenodo](https://doi.org/10.5281/zenodo.22800071)、先行する8ループ論文は[arXiv](https://arxiv.org/abs/2308.08199)で読めます。

## 📝 まとめ

今期の主役はClaude Code v2.1.283です。プロンプト単位のゲートウェイグルーピング、`availableModelsMatch`と`deniedModels`によるモデル統治、`/doctor prompt-audit`による旧モデル向けプロンプト資産の監査が揃い、組織的なClaude Code運用に効くリリースになりました。TypeScriptとPythonのSDKが同日にCLI 2.1.283で追随し、研究面では9ループ振幅の計算結果が公開されています。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。

追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
