---
title: "Anthropic更新ダイジェスト - 2026年9月13日"
emoji: "🤖"
type: "tech"
topics: ["Anthropic", "Claude", "claudecode", "生成AI"]
published: true
---

対象期間は2026年9月12日〜9月13日の2日間。
週末に当たる期間で、News、PlatformとAppsの各リリースノート、Engineering、Research、ステータスのいずれにも新規掲載はなかった。
動きは開発者ツールの保守リリースに限られる。
Claude Codeは9月12日にv2.1.270を出し、前日のv2.1.269で入り込んだ権限プロンプトのリグレッションを修正した。
Agent SDKのTypeScript版は同日にv0.3.270を出してバージョン番号を揃えている。
注視すべきは、9月11日のダイジェストで取り上げた[Claude Cowork on Windowsの機能低下](https://status.claude.com/incidents/r1pqn1kb4hvk)が、9月13日時点でも「Identified」のまま未解決であることだ。
9月8日リリースのWindows更新が原因で、Cowork on Windowsがローカルコマンドを実行できない状態が回避策なしで続いており、Microsoft側の修正リリースを待つ状態にある。

## ⌨️ Claude Code

対象期間内のリリースはv2.1.270の1版で、内容はリグレッションの修正のみである。
長時間実行したセッションで、Bashツールから`git log`や`git diff`といった読み取り専用のgitコマンドを実行すると、本来不要なはずの権限プロンプトが再度表示される問題を解消する。
リグレッションが入ったのは前日のv2.1.269で、同版は権限ルールの厳格化を含む大型更新だった。
セッションの長期実行で読み取り専用コマンドへの再プロンプトに遭遇した利用者は、v2.1.270への更新で収まる。

- **リリース日**: 2026-09-12
- **URL**: https://github.com/anthropics/claude-code/releases/tag/v2.1.270

## 🤖 Agent SDK

TypeScript SDKはv0.3.270の1版である。
Claude Code v2.1.270とのパリティ更新のみで、SDK単体の新機能、破壊的変更、バグ修正はない。
Python SDKに期間内のリリースはなく、直近は2026-09-02のv0.2.152（バンドルClaude CLIバージョン更新のみの内部変更）である。

- **リリース日**: 2026-09-12
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.270

## 📝 まとめ

対象期間は週末で、公式情報源への新規掲載はなく開発者ツールの保守リリースにとどまった。最大の項目はClaude Code v2.1.270で、前日v2.1.269で入った、長時間セッションで読み取り専用gitコマンドが権限プロンプトを再表示するリグレッションを修正している。Agent SDK TypeScript v0.3.270は同版へのパリティ更新である。

## Anthropic更新ダイジェストについて

この記事は以下リポジトリのパイプラインで生成されています。
追加したい情報源、修正、改善案などあればIssueを立てるか変更のPRをお願いします！

https://github.com/evggzzz/anthropic-news
