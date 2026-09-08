#!/bin/bash
# 毎朝09:00に launchd (com.evggzzz.anthropic-news.digest) から実行される
# Anthropic digest パイプラインの headless ラッパー。
# ログ: logs/daily_YYYYMMDD.log（gitignore済み・非公開）

set -u

# launchd は PATH が貧弱なため明示的に設定
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:/usr/bin:/bin"
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

PROJECT="/Users/duffyyy1130/Library/Mobile Documents/com~apple~CloudDocs/ClaudeCode/mcp_work/news/anthropic-news"
cd "$PROJECT" || exit 1

mkdir -p logs
LOG="logs/daily_$(date +%Y%m%d).log"

# 二重実行防止。前回実行のロックが15時間(54000秒)以上残っていれば失効とみなす
LOCK_DIR="logs/.lock"
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  LOCK_AGE=$(( $(date +%s) - $(stat -f %m "$LOCK_DIR" 2>/dev/null || echo 0) ))
  if [ "$LOCK_AGE" -lt 54000 ]; then
    echo "$(date '+%F %T') previous run still active (${LOCK_AGE}s) - abort" >> "$LOG"
    exit 0
  fi
  rm -rf "$LOCK_DIR"
  mkdir "$LOCK_DIR"
fi
trap 'rmdir "$LOCK_DIR" 2>/dev/null' EXIT

{
  echo "===== $(date '+%F %T') daily digest start (args: $(date +%Y-%m-%d) 2) ====="

  # コマンドファイル1本を情報源として $ARGUMENTS だけ「今日 2」に差し替える。
  # days=2: 昨日〜今日の窓。重複は state/seen_urls.txt が排除するため、
  # 米国時間で遅れて掲載された項目も取りこぼさない。
  PROMPT=$(sed "s/\$ARGUMENTS/$(date +%Y-%m-%d) 2/" .claude/commands/anthropic_digest_pipeline.md)
  if [ -z "$PROMPT" ] || ! printf '%s' "$PROMPT" | grep -q "INVOCATION"; then
    echo "ERROR: failed to build prompt from command file"
    exit 1
  fi

  claude -p "$PROMPT" --dangerously-skip-permissions
  RC=$?
  echo "===== $(date '+%F %T') claude exited rc=$RC ====="
  git log --oneline -3
} >> "$LOG" 2>&1
