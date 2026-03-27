#!/usr/bin/env bash
# daily-update.sh
# 日次で Claude Code の新リリースを調査し、変更があればコミット・プッシュする。
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="${PROJECT_DIR}/logs"
LOGFILE="${LOG_DIR}/$(date +%Y-%m-%d).log"
CLAUDE_BIN="${CLAUDE_BIN:-/Users/tairyu/.local/bin/claude}"

mkdir -p "$LOG_DIR"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOGFILE"; }

log "=== 日次更新ジョブ開始 ==="

# --- Step 1: 新リリースの事前チェック ---
log "Step 1: GitHub Releases API で新リリースを確認..."
if ! bash "${PROJECT_DIR}/scripts/check-new-release.sh" >> "$LOGFILE" 2>&1; then
  exit_code=$?
  if [[ $exit_code -eq 1 ]]; then
    log "新しいリリースはありません。ジョブを終了します。"
    exit 0
  else
    log "ERROR: リリースチェックに失敗しました (exit: ${exit_code})"
    exit 1
  fi
fi

# --- Step 2: 調査エージェントを実行 ---
log "Step 2: 調査エージェントを実行中..."
cd "$PROJECT_DIR"

"$CLAUDE_BIN" \
  --agent claude-code-feature-research \
  --allowedTools "WebSearch,WebFetch,Read,Write,Bash,Glob,Grep,Edit" \
  --print \
  --output-format text \
  "最新のClaude Codeリリースを調査し、レポートとCURRENT_FEATURES.mdを更新してください。_sidebar.mdにも新しいレポートへのリンクを追加してください。" \
  >> "$LOGFILE" 2>&1

log "調査エージェント完了"

# --- Step 3: 変更の検出とコミット ---
log "Step 3: 変更を検出中..."

git -C "$PROJECT_DIR" add -A

if git -C "$PROJECT_DIR" diff --cached --quiet; then
  log "実質的な変更はありませんでした。ジョブを終了します。"
  exit 0
fi

COMMIT_DATE=$(date +%Y-%m-%d)
COMMIT_MSG="docs: ${COMMIT_DATE} 日次リリース調査更新

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"

git -C "$PROJECT_DIR" commit -m "$COMMIT_MSG" >> "$LOGFILE" 2>&1
log "コミット完了"

# --- Step 4: プッシュ（GitHub Pages へデプロイ） ---
log "Step 4: リモートにプッシュ中..."
git -C "$PROJECT_DIR" push origin main >> "$LOGFILE" 2>&1
log "プッシュ完了 — GitHub Pages へのデプロイが開始されます"

log "=== 日次更新ジョブ完了 ==="
