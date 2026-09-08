# anthropic-news

Anthropic公式情報の更新を追跡し、週次（または日次）ダイジェスト記事を自動生成するプロジェクト。Claude Codeのパイプラインコマンドで、収集から記事生成・品質検証・コミット・pushまでを自動完走させる。

## 収集ソース（Anthropic公式のみ）

| ソース | 対象 |
|---|---|
| [Anthropic News](https://www.anthropic.com/news) | 製品発表・お知らせ |
| [Platform Release Notes](https://platform.claude.com/docs/en/release-notes/overview) | Claude API・クライアントSDK・Console |
| [Claude Apps Release Notes](https://support.claude.com/en/articles/12138966-release-notes) | Claude.ai・Cowork・アプリ機能 |
| [Claude Code CHANGELOG](https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md) | Claude Codeのバージョン更新 |
| [Agent SDK CHANGELOG](https://github.com/anthropics/claude-agent-sdk-typescript/blob/main/CHANGELOG.md) | Agent SDK（TypeScript / Python） |
| [Anthropic Engineering](https://www.anthropic.com/engineering) | エンジニアリングブログ |
| [Anthropic Research](https://www.anthropic.com/research) | リサーチ記事 |
| [Claude Status](https://status.claude.com/) | 障害・インシデント情報 |

## 使い方

このリポジトリをクローンし、このディレクトリでClaude Codeを起動して、次のコマンドを実行します。

```
/anthropic_digest_pipeline                # 今日から7日分（週次）
/anthropic_digest_pipeline 2026-09-08 7   # 日付と日数を指定
/anthropic_digest_pipeline 2026-09-08 1   # 日次（1日分）
```

初回セットアップ:

```bash
npm install
```

## 毎朝の自動運用（macOS launchd）

- **09:00** パイプライン自動実行（`scripts/daily_run.sh`、日次=当日〜前日の2日窓、重複は自動排除）
- **10:00** macOS通知＋VS Codeで当日の記事を自動オープン（`scripts/deliver.sh`）

手動で即時実行する場合:

```bash
launchctl kickstart -k gui/$(id -u)/com.evggzzz.anthropic-news.digest   # 即パイプライン
launchctl kickstart -k gui/$(id -u)/com.evggzzz.anthropic-news.deliver  # 即通知+オープン
```

実行ログは `logs/`（gitignore済み）。

## 成果物

- `articles/anthropic_YYYYMMDD.md` — Zenn形式の日本語ダイジェスト記事（textlint検証済み）
- `resources/YYYY-MM-DD/` — 実行ごとの収集中間データ

## 仕組み

1. 8つの収集スキルが並列実行され、各公式ソースから指定期間の更新を収集
2. `state/seen_urls.txt` で項目単位の重複排除（週次・日次の混在運用でも再掲しない）
3. 収集データからZenn形式の記事を生成
4. ガードレールレビューとtextlint（`@textlint-ja/preset-ai-writing`）で品質検証
5. commit & push

詳細は `CLAUDE.md` を参照。
