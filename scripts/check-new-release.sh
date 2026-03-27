#!/usr/bin/env bash
# check-new-release.sh
# GitHub Releases API で新しいバージョンがあるかチェックする。
# 終了コード 0 = 新リリースあり、1 = 新リリースなし、2 = エラー
set -euo pipefail

REPO="anthropics/claude-code"
FEATURES_FILE="$(cd "$(dirname "$0")/.." && pwd)/CURRENT_FEATURES.md"

# GitHub API から最新リリースのタグ名を取得
latest_tag=$(curl -sf "https://api.github.com/repos/${REPO}/releases/latest" \
  | grep '"tag_name"' | head -1 | sed 's/.*: "//;s/".*//')

if [[ -z "$latest_tag" ]]; then
  echo "ERROR: GitHub API からリリース情報を取得できませんでした" >&2
  exit 2
fi

echo "最新リリース: ${latest_tag}"

# CURRENT_FEATURES.md に既にこのバージョンが記載されているかチェック
if [[ -f "$FEATURES_FILE" ]] && grep -qF "$latest_tag" "$FEATURES_FILE"; then
  echo "既知のバージョンです。新しいリリースはありません。"
  exit 1
fi

echo "新しいリリースを検出しました: ${latest_tag}"
exit 0
