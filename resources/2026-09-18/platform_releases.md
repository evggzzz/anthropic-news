# Claude Platform Release Notes - 2026-09-18

> 対象期間: 2026-09-17 〜 2026-09-18（2日分）／取得元: https://platform.claude.com/docs/en/release-notes/overview

## 今回の対象エントリ

### 2026-09-18 - Compliance API、Claude in Chrome セッションのトランスクリプト取得に対応
- **URL**: https://platform.claude.com/docs/en/release-notes/overview
- **概要**: Compliance API のローカルセッションエンドポイントが、Claude in Chrome セッションのトランスクリプトも返すようになった。Claude Enterprise 組織向けのベータ提供で、既存の Compliance Access Key と `read:compliance_user_data` スコープをそのまま使える。対象はユーザーのマシン上で実行されたセッション。
- **破壊的変更**: なし
- **詳細**:
  - ローカルセッションエンドポイントの応答に Claude in Chrome セッションが追加され、`product_surface` 値 `claude_in_chrome` で識別される
  - Claude Enterprise 組織向けベータ。既存の Compliance Access Key と `read:compliance_user_data` スコープでアクセス可能
  - ドキュメントは「Sessions on users' machines」を参照

## Source References
- Claude Platform Release Notes: https://platform.claude.com/docs/en/release-notes/overview
