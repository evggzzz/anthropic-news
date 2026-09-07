# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Anthropic公式情報の特化ダイジェストプロジェクト。Anthropicが公式に公開・更新する情報（News、各種リリースノート、Engineeringブログ、Research、ステータス）を収集し、Zenn形式の日本語記事を生成する。

- **リポジトリ**: https://github.com/evggzzz/anthropic-news （public, push先）
- **起動**: このディレクトリ（`anthropic-news/`）を cwd にして Claude Code を起動（cwd が違うとスラッシュコマンドが認識されない）
- **実行**: `/anthropic_digest_pipeline [YYYY-MM-DD] [days]` で収集 → 記事生成 → textlint → commit → push まで自動完走
  - 引数省略時: 今日 / 7日分（週次運用）
  - `/anthropic_digest_pipeline 2026-09-08 1` のように日付と日数を指定可能（日次運用・バックフィル）
- **成果物**: `articles/anthropic_YYYYMMDD.md`（Zenn形式・textlint検証済み）

## Commands and Skills

### Main Pipeline Command

Located at: `.claude/commands/anthropic_digest_pipeline.md`

### Digest Skills

スキルは独立したTask agentとして並列実行される（コンテキスト分離による安定化）。

| Skill | 収集元 | 出力ファイル |
|-------|--------|-------------|
| anthropic_news_digest | anthropic.com/news | `resources/$DATE/news.md` |
| anthropic_engineering_digest | anthropic.com/engineering | `resources/$DATE/engineering.md` |
| anthropic_research_digest | anthropic.com/research | `resources/$DATE/research.md` |
| platform_release_notes_digest | platform.claude.com release notes | `resources/$DATE/platform_releases.md` |
| claude_apps_release_notes_digest | support.claude.com リリースノート | `resources/$DATE/apps_releases.md` |
| claude_code_changelog_digest | anthropics/claude-code CHANGELOG | `resources/$DATE/claude_code.md` |
| agent_sdk_changelog_digest | anthropics/claude-agent-sdk-{typescript,python} | `resources/$DATE/agent_sdk.md` |
| status_incidents_digest | status.claude.com history | `resources/$DATE/status_incidents.md` |
| generate_digest_article | 上記すべて | `articles/anthropic_YYYYMMDD.md` |
| article_guardrail_review | 生成記事の監査 | （判定レポート） |

## Project Structure

```
├── .claude/
│   ├── commands/
│   │   └── anthropic_digest_pipeline.md   # メインパイプライン
│   └── skills/                            # 収集・生成・監査プロンプト
├── articles/                # 最終記事 (anthropic_YYYYMMDD.md)
├── resources/
│   └── YYYY-MM-DD/          # 実行日ごとの収集データ + textlint-report.json
├── state/
│   └── seen_urls.txt        # 処理済み項目の累積レジストリ（重複排除）
├── tasks/                   # todo/lessons（gitignore対象・公開repoに含めない）
├── .textlintrc
└── package.json
```

## Workflow

1. 並列収集 — 8つのdigestスキルをバックグラウンドTask agentで同時実行
2. 結果収集 — STATUSブロックを解析し、失敗はログして継続
3. 記事生成 — `resources/$DATE/` からZenn形式記事を生成
4. ガードレールレビュー — 6項目チェックリスト（要修正なら修正→再レビュー）
5. textlint — `--fix` + JSONレポート保存（non-blocking）
6. commit & push — `Add Anthropic digest for YYYY-MM-DD`

## 重複排除（state/seen_urls.txt）

各収集スキルは項目単位のキー（記事URL・リリースタグURL・`<source>::<date> <title>`）を `state/seen_urls.txt` に記録し、既出項目を次回以降スキップする。週次→日次→週次のような運用の混在でも同じ項目を再掲しないための仕組み。

索引・チェンジログのページURL（例: release notes のページ自体）はキーに登録禁止である。毎回同じURLになるため、2回目以降の収集がすべてブロックされる。

## Quality Assurance with textlint

`@textlint-ja/preset-ai-writing` を使用（weekly_ai_devと同一設定）。AI的な誇張表現・過剰な箇条書き・強調パターンを検出し、`npx textlint --fix` で自動修正する。

## 個人情報ポリシー

このリポジトリはpublicのため、次の点を厳守する。

- ローカルパス・個人アカウント名・個人メールアドレスを記事・README・CLAUDE.mdに書かない
- `tasks/`（作業メモ）は .gitignore で公開対象外
- `git config user.email` が個人メールの場合は GitHub noreply アドレスを repo ローカル設定に使う
- ガードレールレビューのチェックリストに個人情報項目を含めている

## Technical Constraints and Workarounds

### ソースへのアクセス（2026-09-08時点で検証済み）

| ソース | URL | 備考 |
|---|---|---|
| News | https://www.anthropic.com/news | RSS無し。WebFetchで取得可。ページングはJS（"See more"）だが1ページ10件で7日分に十分 |
| Engineering | https://www.anthropic.com/engineering | RSS無し。WebFetch可。更新頻度は月1〜2程度 |
| Research | https://www.anthropic.com/research | RSS無し。WebFetch可。URLにcamelCase例外あり |
| Platform release notes | https://platform.claude.com/docs/en/release-notes/overview | WebFetch可。日付付きエントリ |
| Apps release notes | https://support.claude.com/en/articles/12138966-release-notes | WebFetch可。月見出し+日付 |
| Claude Code changelog | https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md + https://github.com/anthropics/claude-code/releases.atom | raw MDはバージョンのみ・atomで日付を取得 |
| Agent SDK changelog | https://github.com/anthropics/claude-agent-sdk-typescript / -python の各 CHANGELOG.md + releases.atom | 同上 |
| ステータス | https://status.claude.com/history.rss | RSS有効 |

### リダイレクトマップ（重要）

- `docs.anthropic.com` / `docs.claude.com` → `https://platform.claude.com/docs/...`（301）
- `platform.claude.com/docs/en/release-notes/platform` は **404**（存在しない。正しくは `.../release-notes/overview`）
- `status.anthropic.com` → `https://status.claude.com/`（301）
- `docs.claude.com/en/api/agent-sdk/changelog` → `code.claude.com/docs/en/agent-sdk`（Agent SDKのchangelog本体はGitHubの2リポジトリ）

### WebFetch ボットブロック時のフォールバック

WebFetchが403/ブロック/JSコード返却を返した場合:

1. Node.jsスクラプトを `require('playwright')` で書いてBashから実行（headless Chromium）
2. スクラプトは必ずプロジェクトルート（`anthropic-news/`）内に置く。`/tmp` に置くと `require('playwright')` のモジュール解決が壊れる
3. リクエスト間にディレイを入れ、必要なデータのみ抽出
4. スクラプトは使い捨て（`*_scraper.js` / `script_*.js` はgitignore済み）

現時点では全8ソースともWebFetchで取得可能。Anthropic側の対策が変わったら上表とこの節を更新すること。
