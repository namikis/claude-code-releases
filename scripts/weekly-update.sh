#!/usr/bin/env bash
# weekly-update.sh
# 毎週木曜10時（JST）に週次レポートを生成し、コミット・プッシュする。
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="${PROJECT_DIR}/logs"
LOGFILE="${LOG_DIR}/weekly-$(date +%Y-%m-%d).log"
HISTORY_FILE="${PROJECT_DIR}/HISTORY.md"
CLAUDE_BIN="${CLAUDE_BIN:-/Users/tairyu/.local/bin/claude}"
RUN_DATE=$(date '+%Y-%m-%d %H:%M')

mkdir -p "$LOG_DIR"

# Claude CLI がファイルディスクリプタ不足でクラッシュするのを防止
ulimit -n 2147483646 2>/dev/null || ulimit -n 10240 2>/dev/null || true

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOGFILE"; }

# 公開用履歴に1行追記する
history_append() {
  local status="$1" detail="$2"
  if [[ ! -f "$HISTORY_FILE" ]]; then
    cat > "$HISTORY_FILE" <<'HEADER'
# 実行履歴

日次自動更新ジョブの実行ステータス。

| 日時 | ステータス | 詳細 |
|------|-----------|------|
HEADER
  fi
  local new_row="| ${RUN_DATE} | ${status} | ${detail} |"
  sed -i '' "s@|------|-----------|------|@|------|-----------|------|\n${new_row}@" "$HISTORY_FILE"
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

log "=== 週次レポート生成ジョブ開始 ==="

AGENT_PROMPT="過去1週間分の日次レポートをまとめて週次レポートを作成してください。対象期間の日次レポートを収集し、「最新機能系（インパクトのあるもの）／ビジネス系／その他機能修正系」の3分類で整理してください。情報が不足している場合はWebSearchで補完し、weekly-reports/{TODAY}_weekly.md に保存して、_sidebar.md に追記し、git commit と push origin main まで実行してください。"

# エージェント実行（タイムアウト系失敗は最大3回まで試行）
log "週次レポートエージェントを実行中..."
cd "$PROJECT_DIR"

MAX_ATTEMPTS=3
attempt=1
agent_ok=0
while (( attempt <= MAX_ATTEMPTS )); do
  if "$CLAUDE_BIN" \
    --agent weekly-report-generator \
    --allowedTools "WebSearch,WebFetch,Read,Write,Edit,Bash,Glob,Grep" \
    --print \
    --output-format text \
    "$AGENT_PROMPT" \
    >> "$LOGFILE" 2>&1; then
    agent_ok=1
    break
  fi
  log "WARN: 週次レポートエージェントが異常終了しました (試行 ${attempt}/${MAX_ATTEMPTS})"
  if (( attempt < MAX_ATTEMPTS )); then
    backoff=$(( 60 * attempt ))
    log "  ${backoff}秒待機してリトライします..."
    sleep "$backoff"
  fi
  ((attempt++))
done

if (( agent_ok == 0 )); then
  log "ERROR: 週次レポートエージェントが${MAX_ATTEMPTS}回すべて失敗しました"
  history_append "エラー" "【週次】Claude CLI異常終了 (${MAX_ATTEMPTS}回失敗)"
  commit_history_and_exit 1 "週次レポートCLI異常終了"
fi

log "週次レポートエージェント完了 (試行 ${attempt}/${MAX_ATTEMPTS})"

# エージェントが commit/push まで完了させるため、
# ここでは HISTORY.md のみ追記してプッシュする
history_append "成功" "【週次】レポート生成完了"
git -C "$PROJECT_DIR" add HISTORY.md
if ! git -C "$PROJECT_DIR" diff --cached --quiet; then
  git -C "$PROJECT_DIR" commit -m "docs: ${RUN_DATE} 実行履歴更新（週次レポート）

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>" >> "$LOGFILE" 2>&1 || true
  git -C "$PROJECT_DIR" push origin main >> "$LOGFILE" 2>&1 || true
fi

log "=== 週次レポート生成ジョブ完了 ==="
