---
title: "Anthropic更新ダイジェスト - 2026年9月15日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月14日〜9月15日の2日間。
News、Platform リリースノート、Apps リリースノート、Engineering、Researchの5情報源に、対象期間内の新規掲載はなかった。
そのため今回の更新は開発者向けツールチェーンに集中する。
中心は9月14日付のClaude Code v2.1.271で、Remoteセッションでのfast mode対応、auto modeサンドボックスでのコマンド単位のドメイン制御、subagentのCLAUDE.md分離といった機能追加に、Bash権限チェックの抜け穴3件などセキュリティ修正が同居する大型リリースだ。
Agent SDK（TypeScript）は同じ9月14日にv0.3.271でパリティ追従し、Claude Code側のMonitor変更に対応する破壊的変更がSDKにも及んだ。
運用面では、前週から継続していたClaude Cowork on Windowsの機能低下が、Microsoftのセキュリティ更新KB5129195の配信によって解決している。
発表面は静かで、道具の側が大きく動いた2日間だった。

## ⌨️ Claude Code

対象期間内のリリースはv2.1.271の1版である。
バグ修正のみのマイナーリリースはない。
fast modeのRemote展開、サンドボックスのドメイン制御、subagentの独立性、権限チェックの抜け穴修正が1つにまとまった、機能と安全の両面で厚いリリースだ。

### v2.1.271（2026-09-14）: fast modeのRemote展開とサンドボックス制御の精緻化

#### Remoteセッションでのfast mode対応

fast modeがClaude Code Remoteのセッションで使えるようになった。
クラウドランナーとセルフホストランナーの両方で、ホスト側のfast-mode設定またはセッション内の`/fast`が、組織が許可する範囲で適用される。
Remoteセッションはクラウドやセルフホストの実行環境上で進めるため、この対応によりfast modeと通常モードの切り替えがセッション種別をまたいで一貫する。
許可の判定が組織ポリシーに従う作りで、管理下での利用が前提になっている。

#### コマンド単位の`allowed_domains`

auto modeとサンドボックスの組み合わせで、Bash・PowerShell・Monitorのコマンドに対し、そのコマンドが必要とするホストだけをレビュー付きで開放し、残りを拒否できるようになった。
ドメイン許可をセッション全体へ一律に与える運用では、1つのコマンドのために開けた穴を他のすべてのコマンドが共有することになる。
必要なホストだけをコマンド単位で開けば、サンドボックスの外へ出る経路を最小限に絞り込める。
ネットワークの許可対象を細かく切り出す方向性は、後述のCloud environmentsエディタのCustom network accessにも共通している。

#### subagentの`omitClaudeMd`と報告経路の変更

agent frontmatterと`--agents` JSONに`omitClaudeMd`が追加された。
カスタムおよびプラグインのsubagentを、ユーザー・プロジェクト・ローカルのCLAUDE.md群を読み込まずに動かせる。
managed policyは引き続き読み込まれる。
CLAUDE.mdは作業環境の規約をエージェントへ渡す仕組みだが、規約を前提としない汎用のsubagentでは、挙動を定義側だけで制御したい場合がある。
読み込みを切る選択肢ができた一方、組織の管理ポリシーは維持されるため、統制の抜け穴にはならない設計になっている。

subagentの結果報告も変更された。
最後のメッセージを事後レビューする方式から、safety classifierがレビューする専用のhand-back呼び出しに切り替わっている。
出力を後から検査するのではなく、報告の経路そのものを検査に組み込んだ形で、検査から漏れる経路が減る。

#### Monitorウォッチに必須デッドライン（破壊的変更）

Monitorのウォッチには必ずデッドラインが課されるようになった。
上限は30分で、`-p`実行では10分である。
期限を過ぎると、ウォッチの再設定をClaudeに求める通知に移行する。
タイムアウトなしで監視を続けさせられた`persistent`オプションは廃止された。
`persistent`を使っている運用は、デッドライン到達時に再設定通知で受け取る作りへの移行が必要になる。

#### auto modeでのインライン`!`コマンドの権限（挙動変更）

スキルやスラッシュコマンド内のインライン`!`シェルコマンドが、分類器ではなくデフォルトモードの権限ルールに従うようになった。
分類器の裁量に任せていた部分を明示的な権限ルールの管轄へ戻したもので、どのルールが適用されるかを事前に予測しやすくなる。
auto modeで`!`コマンドを多用するスキルでは、必要な権限をルール側に用意しておく必要がある。

#### Bash権限チェックの抜け穴3件とMCP OAuthの修正

権限チェックを回避する3つの経路が修正された。
`fmt`や`column`のようにファイルを読むコマンドを経由する読み取り、ワイルドカード展開の宛先、シェル変数の宣言フラグによる偽装である。
いずれも検査を受けずにファイルやコマンドへ到達できる経路であり、権限モデルを信頼して運用する環境では優先して当てたい修正だ。

MCP OAuthのクライアント登録破壊も修正された。
同意の拒否、redirect URIの不一致、競合する書き込みの際に、有効な登録が消えることがあった。
登録が壊れるとMCPサーバとの認証からやり直しになり、原因が見えにくい形で連携が止まる。

#### 重大な不具合の修正

複数組織の運用や長時間セッションで響く修正が目立つ。

- アカウント・組織・APIキーを切り替えた後も、キャッシュされた組織ポリシーが再利用され、資格情報の変更時に更新されない問題。切り替え前の組織のポリシーが適用され続けるおそれがある、統制に関わる修正である。
- 読み取りやパースに失敗した企業の`managed-mcp.json`が黙って無視される問題。排他的MCP制御を維持したうえで、起動時に警告を出すように変わった。
- ワークフロー・エージェント承認の適用後に、クラウドセッションの全subagentツール呼び出しが"updatedInput … failed schema validation"で失敗する問題。
- `--resume`で再開したセッションのモデルファミリーが既定と異なる場合に、1Mコンテキスト(`[1m]`)が落ちる問題。長大コンテキスト前提で進めたセッションの再開で、途中から制限が戻る現象だった。
- `/resume`・`/teleport`が前の会話のファイル既読追跡を引き継ぎ、未読のファイルを編集できてしまう問題。
- 圧縮（compaction）の後も、実行中のバックグラウンドコマンドが二重に起動する問題。
- Windowsで、一時パスが260文字に達するとPowerShellコマンドが"Exit code 1"で失敗する問題。

#### セルフホストランナー・プラグインCLI・課金設定

セルフホストランナー関連は2点ある。
`claude self-hosted-runner --drain-marker-file <path>`が追加され、SIGTERMでのドレイン時に指定ファイルが存在していればhost drainとして報告する（テレメトリのみ）。
ホスト設定ディレクトリが64 MiBを超えると設定が黙って失われる問題の修正では、`--host-config-snapshot disk|memory`も加わった。

`claude plugin install/update --accept-command <sha256>`が追加された。
`--json`実行が表示したコマンドを正確に受け入れる指定で、`-y`の代替になる。
受け入れるコマンドを限定できるため、自動化パイプラインで与える権限を絞りやすくなった。

`modelPricing`とゲートウェイ`pricing`ブロックに`multiplier`（最大10）が追加された。
加算済みの内部チャージバックレート向けで、ゲートウェイ運用で実コストに係数を乗せた社内単価の表示に使える。

#### dynamic workflow・UI・各連携の改善

dynamic workflowは、既定サイズがProプランでsmallに、mediumの目安が15から10エージェントに引き下げられた。
使用制限に到達したときはエージェントを落とさず一時停止し、復帰時に再開するようになっている。
制限に当たったワークフローが中断で済み、続きから再開できる。

UIでは、フルスクリーン`/config`パネルがマウス操作に対応した。
ホイールで設定リストをスクロールし、値のクリックで変更、ポインタ下の行をハイライト表示する。
パフォーマンスとUXでは、大きなdiffと長いトランスクリプトの描画高速化、フック実行中のスピナー表示（経過時間付き）、`claude mcp serve`が実行中のツール呼び出しを30秒ごとに進捗報告する変更、Markdownアーティファクトのスタイル付きドキュメント表示、アーティファクト監視上限の5から10への拡大が加わっている。

Claude Code on the webは、プロセス終了後もセッションが生きているように見えて約10分無応答になる問題を修正した。
メッセージ送信時に即座に再起動する形である。
Routinesページが新レイアウトになり、カレンダー表示は削除された。
Cloud environmentsエディタにはCustom network access（allowed-domainsリスト）が追加された。

VSCode拡張はAttach Open File設定を追加し、Hooks/Permissionダイアログでの保存失敗の報告、セッション履歴と新規チャットの切替、Windowsでのコンソールウィンドウの点滅などを修正した。
Claude Tagは、スレッド中心の会話で約1時間ごとに作業コンテキストを失う問題と、PR監視スレッドがCI失敗やコメントを拾わなくなる問題を修正した。
Code Reviewは、レビュー待ち中のコミットがレビューされない問題、同一コメントの二重・三重投稿、解決済みセキュリティ指摘の再投稿を修正している。

- **リリース日**: 2026-09-14
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.271

## 🤖 Agent SDK

### TypeScript SDK v0.3.271（2026-09-14）

v0.3.271は、Claude Code v2.1.271とバージョンを揃えたパリティ更新である。
subagent定義（`agents`オプション）の`AgentDefinition`に`omitClaudeMd`が追加され、ユーザー・プロジェクト・ローカルのCLAUDE.md群を読み込まずにサブエージェントを起動できる。
Claude Code側と同じ機能のSDK版で、SDKからsubagentを定義するコードでもCLAUDE.mdの影響を切り離せる。
managed policyは引き続き読み込まれる。

破壊的変更として、`MonitorInput`ツール型から`persistent`フィールドが削除された。
Claude Code v2.1.271でのMonitorの`persistent`廃止に対応する変更で、`persistent`を参照しているコードは型チェックまたは実行時に失敗するため、修正が必要になる。

このほか、Windowsでの修正が2件ある。
`listSessions`・`getSessionMessages`・`getSessionInfo`を`dir`付きで呼んだ際に、マップされたネットワークドライブやSUBSTドライブ上のディレクトリのセッションが見つからない問題。
`sessionStore`でのレジューム時に、レガシーの`.config.json`という名前やOAuthのサフィックス付きのファイル名で保存されたグローバル設定を失う問題である。

- **リリース日**: 2026-09-14
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.271

Python SDKに対象期間内のリリースはない。
最新はv0.2.152（2026-09-02）で、Claude CLI 2.1.259同梱のバンドル更新のみにとどまる。

## 🚨 障害・ステータス

### Claude Cowork on Windowsの機能低下、解決済み

Degraded functionality for Claude Cowork on Windowsが、2026-09-14 19:14 UTCに解決済み（Resolved）となった。
2026年9月8日配信のWindowsアップデートが原因で、Claude Cowork on Windowsからローカルコマンドを実行できない状態（ワークスペースがコンピュータのドライブに到達できない）が続いていた案件で、前回の9月11日収集時点ではIdentifiedのままだった。
解決の引き金はMicrosoft側の対応である。
9月14日に配信されたWindows 11（24H2/25H2）向けセキュリティ更新プログラムKB5129195により修正され、ステータスがResolvedに切り替わった。
WindowsでCoworkのローカル実行に失敗し続けていた環境は、同更新の適用状況を確認したい。
対象期間内の他のインシデント報告はない。

- **URL**: https://status.claude.com/incidents/r1pqn1kb4hvk

## 📝 まとめ

対象期間の中心はClaude Code v2.1.271。Remoteセッションでのfast mode対応、auto modeサンドボックスでのコマンド単位のallowed_domains、subagentのomitClaudeMdに加え、Bash権限チェックの抜け穴3件などセキュリティ修正を多数含む大型リリースだった。Agent SDK（TypeScript）v0.3.271がパリティ追従し、MonitorInputからpersistentが削除される破壊的変更が両者で共通した。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。
追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
