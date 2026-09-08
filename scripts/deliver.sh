#!/bin/bash
# 毎朝10:00に launchd (com.evggzzz.anthropic-news.deliver) から実行される配信スクリプト。
# 当日の記事があれば macOS通知（まとめ抜粋）+ VS Codeで記事を開く。なければ未生成通知。

set -u

export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:/usr/bin:/bin"
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

PROJECT="/Users/duffyyy1130/Library/Mobile Documents/com~apple~CloudDocs/ClaudeCode/mcp_work/news/anthropic-news"
cd "$PROJECT" || exit 1

ARTICLE="articles/anthropic_$(date +%Y%m%d).md"
TITLE_DATE=$(date +"%-m/%-d")

notify() {
  # $1=body $2=subtitle — 本文はARGV経由で渡す（シェル/AppleScriptのエスケープ問題を完全回避）。
  # 文字数切り詰めはAppleScript内で行う（UTF-16単位なので日本語が途中で切れない）。
  osascript - "$1" "Anthropic更新ダイジェスト $TITLE_DATE" "$2" <<'APPLESCRIPT'
on run argv
  set body to item 1 of argv
  set ttl to item 2 of argv
  set sub to item 3 of argv
  if (count of body) > 140 then set body to text 1 thru 140 of body
  display notification body with title ttl subtitle sub
end run
APPLESCRIPT
}

if [ -f "$ARTICLE" ]; then
  # まとめセクション（## …まとめ から次の ## まで）を抜粋し、平坦化。
  # 切り詰めはAppleScript側で行う（シェル側でのバイト単位cutは日本語を壊すため禁止）
  SUMMARY=$(awk '/^## .*まとめ/{flag=1;next} /^## /{flag=0} flag' "$ARTICLE" \
    | tr '\n' ' ' \
    | sed -e 's/^ *//' -e 's/  */ /g' -e 's/\*\*//g' -e 's/\[//g' -e 's/\]//g')
  [ -z "$SUMMARY" ] && SUMMARY="本日のAnthropic更新ダイジェストが生成されました"
  notify "$SUMMARY …" "記事を開きます"
  open -a "Visual Studio Code" "$ARTICLE" 2>/dev/null || open "$ARTICLE"
else
  notify "パイプラインのログを確認してください" "本日の記事は未生成です"
  open -a "Visual Studio Code" "$PROJECT/logs" 2>/dev/null || open "$PROJECT/logs" 2>/dev/null || true
fi
