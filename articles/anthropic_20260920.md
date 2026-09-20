---
title: "Anthropic更新ダイジェスト - 2026年9月20日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月19日〜9月20日の2日間。
この期間は公式発表面が静かで、News、Platform リリースノート、Apps リリースノート、Engineeringブログ、Research、ステータスのいずれにも対象期間内の新規掲載はなかった（該当セクションは掲載基準により省略する）。
更新があったのは開発者向けツールチェーンだけで、その中身も1点に絞られる。
Claude Code v2.1.278（9月19日）が、auto modeの分類器（classifier）をサーバー側で動かす方式へ既定を切り替えた。
権限判断を担う裏方のモデル呼び出しに「classifier overhead」として上乗せされてきた課金が、サーバー側分類器では発生しなくなる。
Bedrock / Vertex / Foundry / ゲートウェイ経由のエンタープライズ構成を含む広い範囲に届く、エージェントの走行コストを下げる変更である。
Agent SDKはTypeScript v0.3.278がこのパリティを追った。
次の注視点は、9月18日のNewsで「今後数週間で」と予告された追加の埋め込み評価者の発表と、今週静かに終わったPlatform側のAPI更新が再び動き出すかどうかである。

## ⌨️ Claude Code

対象期間内のリリースは9月19日付のv2.1.278の1版で、変更もauto mode分類器の実行位置の切り替えに集約される。
前回掲載のv2.1.277・v2.1.276は9月18日付で対象期間外である。

### v2.1.278（2026-09-19）: auto mode分類器のサーバー側動作デフォルト化

**Auto mode**は、コマンド実行などの権限判断を**分類器（classifier）**のモデル呼び出しに委ねて作業を自動進行させるモードである。
この分類器をどこで動かすかの既定が、今回はサーバー側の実装へ切り替わった。
対象はClaude APIとEnterpriseのユーザーに加え、Bedrock / Vertex / Foundry / ゲートウェイ経由の利用者である。

この切り替えの中心は課金である。
これまでauto modeでは、エージェント本体のトークンとは別に分類器の呼び出し分が**classifier overhead**として課金され得た。
サーバー側分類器ではこの課金が発生せず、サーバー側へ移行できない場合のフォールバック先となる通常の分類器は課金対象のままである。
auto modeを常用するセッションでは分類のたびに積み上がっていた上乗せが、既定では消える。

既定の置き方としては、v2.1.273（9月15日）がBedrock / Vertex / Foundryのauto modeをローカル分類器へ切り替えていた。
今回の変更はそれを4日でサーバー側へ反転させるもので、サーバー側分類器から課金がなくなったことと対応している。
移行に伴う運用面の変更は3つある。

- Bedrock / Vertex / Foundry / ゲートウェイでは、環境変数 `CLAUDE_CODE_AUTO_MODE_SERVER=0` でサーバー側分類器をオプトアウトできる
- サーバー側へ移行できずに課金対象の分類器へフォールバックした際は、ツールがその旨を警告する
- `/status` に `Auto mode server` 行が加わり、いまのセッションの分類器がサーバー側で動いているかをその場で確認できる

フォールバック時の警告と`/status`の行により、課金の発生場所を抑えたい企業運用でも実行形態の確認を手元で済ませられる。
課金の詳細は、リリースと合わせて公開されたドキュメント https://code.claude.com/docs/en/auto-mode-classifier-billing にまとまっている。

- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.278

## 🤖 Agent SDK

### TypeScript SDK v0.3.278（2026-09-19）: Claude Code v2.1.278とのパリティ更新

バンドルされるClaude CLIをv2.1.278へ揃えた更新で、SDK API自体の新機能と破壊的変更はない。
同梱CLIのバージョンが上がるため、前節のauto mode分類器のサーバー側既定と課金の扱いは、SDK経由のセッションでも同梱版の挙動に従う。
Python SDKの対象期間内のリリースはなく、最新は9月18日付のv0.2.156（前回掲載済み）である。

- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.278

## 📝 まとめ

対象期間の更新はClaude Code v2.1.278に集約された。auto modeの分類器がサーバー側動作へデフォルト化され、Claude API・EnterpriseとBedrock / Vertex / Foundry / ゲートウェイでclassifier overheadの課金が発生しなくなる。オプトアウトはCLAUDE_CODE_AUTO_MODE_SERVER=0で、/statusのAuto mode server行で稼働状況を確認できる。Agent SDKはTypeScript v0.3.278のパリティ追従のみ。ほかの情報源は新規掲載なし。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。
追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
