#!/usr/bin/env bash
# daily-update.sh
# 日次で Claude Code の新リリースを調査し、変更があればコミット・プッシュする。
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="${PROJECT_DIR}/logs"
LOGFILE="${LOG_DIR}/$(date +%Y-%m-%d).log"
HISTORY_FILE="${PROJECT_DIR}/HISTORY.md"
CLAUDE_BIN="${CLAUDE_BIN:-/Users/tairyu/.local/bin/claude}"
RUN_DATE=$(date '+%Y-%m-%d %H:%M')

mkdir -p "$LOG_DIR"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOGFILE"; }

# 公開用履歴に1行追記する
# usage: history_append "ステータス" "詳細"
history_append() {
  local status="$1" detail="$2"
  # ヘッダーがなければ作成
  if [[ ! -f "$HISTORY_FILE" ]]; then
    cat > "$HISTORY_FILE" <<'HEADER'
# 実行履歴

日次自動更新ジョブの実行ステータス。

| 日時 | ステータス | 詳細 |
|------|-----------|------|
HEADER
  fi
  # テーブル末尾に1行追加
  echo "| ${RUN_DATE} | ${status} | ${detail} |" >> "$HISTORY_FILE"
}

# history_append 後に HISTORY.md をコミット・プッシュして終了するヘルパー
commit_history_and_exit() {
  local exit_code="$1" label="$2"
  git -C "$PROJECT_DIR" add HISTORY.md
  if ! git -C "$PROJECT_DIR" diff --cached --quiet; then
    git -C "$PROJECT_DIR" commit -m "docs: ${RUN_DATE} 実行履歴更新（${label}）

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>" >> "$LOGFILE" 2>&1 || true
    git -C "$PROJECT_DIR" push origin main >> "$LOGFILE" 2>&1 || true
  fi
  exit "$exit_code"
}

log "=== 日次更新ジョブ開始 ==="

# --- Step 1: 新リリースの事前チェック ---
log "Step 1: GitHub Releases API で新リリースを確認..."
set +e
bash "${PROJECT_DIR}/scripts/check-new-release.sh" >> "$LOGFILE" 2>&1
exit_code=$?
set -e

if [[ $exit_code -eq 1 ]]; then
  log "新しいリリースはありません。ジョブを終了します。"
  history_append "スキップ" "新リリースなし"
  commit_history_and_exit 0 "新リリースなし"
elif [[ $exit_code -ge 2 ]]; then
  log "ERROR: リリースチェックに失敗しました (exit: ${exit_code})"
  history_append "エラー" "API接続失敗"
  commit_history_and_exit 1 "API接続失敗"
fi

# --- Step 2: 調査エージェントを実行 ---
log "Step 2: 調査エージェントを実行中..."
cd "$PROJECT_DIR"

if ! "$CLAUDE_BIN" \
  --agent claude-code-feature-research \
  --allowedTools "WebSearch,WebFetch,Read,Write,Bash,Glob,Grep,Edit" \
  --print \
  --output-format text \
  "最新のClaude Codeリリースを調査し、レポートとCURRENT_FEATURES.mdを更新してください。_sidebar.mdにも新しいレポートへのリンクを追加してください。" \
  >> "$LOGFILE" 2>&1; then
  log "ERROR: 調査エージェントが異常終了しました"
  history_append "エラー" "Claude CLI異常終了"
  commit_history_and_exit 1 "Claude CLI異常終了"
fi

log "調査エージェント完了"

# --- Step 3: 変更の検出とコミット ---
log "Step 3: 変更を検出中..."

git -C "$PROJECT_DIR" add -A

if git -C "$PROJECT_DIR" diff --cached --quiet; then
  log "実質的な変更はありませんでした。ジョブを終了します。"
  history_append "スキップ" "エージェント実行済み・差分なし"
  commit_history_and_exit 0 "差分なし"
fi

# 検出したバージョンをログから取得
detected_ver=$(grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' "$LOGFILE" | tail -1 || echo "")
detail="更新完了"
[[ -n "$detected_ver" ]] && detail="更新完了 (${detected_ver})"
history_append "成功" "$detail"

# HISTORY.md の変更もステージに含める
git -C "$PROJECT_DIR" add HISTORY.md

COMMIT_DATE=$(date +%Y-%m-%d)
COMMIT_MSG="docs: ${COMMIT_DATE} 日次リリース調査更新

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>"

if ! git -C "$PROJECT_DIR" commit -m "$COMMIT_MSG" >> "$LOGFILE" 2>&1; then
  log "ERROR: コミットに失敗しました"
  exit 1
fi
log "コミット完了"

# --- Step 4: プッシュ（GitHub Pages へデプロイ） ---
log "Step 4: リモートにプッシュ中..."
if ! git -C "$PROJECT_DIR" push origin main >> "$LOGFILE" 2>&1; then
  log "ERROR: プッシュに失敗しました"
  exit 1
fi
log "プッシュ完了 — GitHub Pages へのデプロイが開始されます"

log "=== 日次更新ジョブ完了 ==="
