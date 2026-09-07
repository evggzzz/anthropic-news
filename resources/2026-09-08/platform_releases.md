# Claude Platform Release Notes - 2026-09-08

> 対象期間: 2026-09-02 〜 2026-09-08（7日分）／取得元: https://platform.claude.com/docs/en/release-notes/overview

## 今回の対象エントリ

### [2026-09-03] - ant CLI 1.30.0: `ant apply` によるリソースのコード管理（IaC）
- **URL**: https://platform.claude.com/docs/en/release-notes/overview
- **概要**: `ant` CLI v1.30.0 に `ant apply` コマンドが追加された。リポジトリ内のファイルから agents・environments・skills・memory stores・deployments を作成・更新できる。各リソースをファイルで定義して `ant apply` を実行するとプランが表示され、承認して適用する。書き出される `claude-lock.json` ロックファイルをコミットしておくことで、以降の実行（ローカル・CI どちらでも）が新規作成ではなく同じリソースの更新になる。
- **破壊的変更**: なし
- **詳細**:
  - `ant` CLI バージョン: 1.30.0
  - 新コマンド: `ant apply` — agents / environments / skills / memory stores / deployments をリポジトリ内ファイルから作成・更新
  - プラン承認型の適用: `ant apply` 実行 → プラン表示 → 承認
  - ロックファイル: `claude-lock.json` をコミットすると、以降の実行（ローカル・CI 関わず）が同一リソースを更新
  - ドキュメント: "Manage resources as code with ant apply"

## 備考
- 期間直前の参考情報: 2026-09-01 に **Claude Fable 5.1** (`claude-fable-5-1`) と **Claude Mythos 5.1** (`claude-mythos-5-1`) がリリース済み（1M context デフォルト・$10/$50 per MTok・cache read $0.25/MTok など）。本エントリは対象期間 (2026-09-02 以降) の外なので本ダイジェストには含めていない。前回ダイジェストで未収集であれば要補足。

## Source References
- Claude Platform Release Notes: https://platform.claude.com/docs/en/release-notes/overview
