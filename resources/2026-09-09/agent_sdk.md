# Claude Agent SDK Changelog - 2026-09-09

> 対象期間: 2026-09-08 〜 2026-09-09（2日分）／取得元: anthropics/claude-agent-sdk-typescript, anthropics/claude-agent-sdk-python

## TypeScript SDK

### v0.3.266（2026-09-08）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.266
- **概要**: Claude Code v2.1.266 とのパリティ更新のみのパッチリリース。SDK本体のAPI追加・破壊的変更はない。
- **主要変更**:
  - Updated to parity with Claude Code v2.1.266

### v0.3.265（2026-09-08）
- **URL**: https://github.com/anthropics/claude-agent-sdk-typescript/releases/tag/v0.3.265
- **概要**: 合成ターン（synthetic turn）やリジューム開始ターンにおける `user_message_uuid` の付与が拡充され、どのユーザーメッセージに起因する応答かを追跡しやすくなった。また、マルチターン会話でシェルの作業ディレクトリが毎ターン `cwd` に戻される問題を修正し、対話型アプリと同様に `cd` がターンをまたいで保持される。
- **主要変更**:
  - `user_message_uuid` / `user_message_uuids` を合成ターン（`isSynthetic: true` + `uuid` 指定メッセージ）の最初のreplyとresultに追加
  - Claude Code自身が開始したターン（resumeなど）の最初のreplyとresultにも `user_message_uuid` / `user_message_uuids` を追加（ターン途中で取り込んだユーザーメッセージを特定可能に）
  - スラッシュコマンドなどAPIリクエストを伴わないターンの成功resultで `user_message_uuid` が欠落する問題を修正
  - マルチターンセッションでユーザーメッセージごとにシェルの作業ディレクトリが `cwd` オプションにリセットされる問題を修正（`cd` がターン間で永続化）
  - `user_message_uuid` の付与タイミングを「ターンごと1フレーム」から「応答対象メッセージの変化ごとの最初のreply」に変更
  - Updated to parity with Claude Code v2.1.265

## Python SDK

### 対象バージョンなし
対象期間内（2026-09-08 〜 2026-09-09）の新しいリリースはありませんでした。最新は 2026-09-02 の v0.2.152（前回分で処理済み）。

## Source References
- TypeScript CHANGELOG: https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md
- Python CHANGELOG: https://github.com/anthropics/claude-agent-sdk-python/blob/main/CHANGELOG.md
