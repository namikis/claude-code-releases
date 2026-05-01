#!/usr/bin/env bash

# launchd ジョブ終了時のメール通知ヘルパー。
# RESEND_API_KEY / NOTIFICATION_EMAIL が未設定なら何もしない。

# source されたファイル自身の場所を解決し、関数内で BASH_SOURCE を参照しなくて済むようにする。
JOB_NOTIFY_SCRIPT_DIR="${JOB_NOTIFY_SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
JOB_NOTIFY_PROJECT_DIR="${JOB_NOTIFY_PROJECT_DIR:-$(cd "${JOB_NOTIFY_SCRIPT_DIR}/.." && pwd)}"

job_notify_load_env() {
  local env_file="${1:-}"

  [[ -n "$env_file" && -f "$env_file" ]] || return 0

  set -a
  # .env はこのリポジトリ専用の設定ファイルとして扱う。
  # shellcheck disable=SC1090
  source "$env_file"
  set +a
}

job_notify_init() {
  JOB_NOTIFY_NAME="${1:-job}"
  JOB_NOTIFY_LOGFILE="${2:-}"
  JOB_NOTIFY_ENV_FILE="${3:-}"
  JOB_NOTIFY_STATUS_LABEL=""
  JOB_NOTIFY_STATUS_DETAIL=""
  job_notify_load_env "$JOB_NOTIFY_ENV_FILE"
  trap 'job_notify_on_exit $?' EXIT
}

job_notify_set_result() {
  JOB_NOTIFY_STATUS_LABEL="${1:-}"
  JOB_NOTIFY_STATUS_DETAIL="${2:-}"
}

job_notify_resolve_node() {
  local candidate
  for candidate in \
    "${NODE_BIN:-}" \
    "$(command -v node 2>/dev/null || true)" \
    /opt/homebrew/bin/node \
    /usr/local/bin/node \
    /Users/tairyu/.nvm/versions/node/v16.13.1/bin/node; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      printf '%s' "$candidate"
      return 0
    fi
  done
  return 1
}

job_notify_log() {
  if [[ -n "${JOB_NOTIFY_LOGFILE:-}" ]]; then
    printf '[%s] [job-notify] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$JOB_NOTIFY_LOGFILE"
  fi
}

# 当日のレポートから「## 概要」セクション全体を抜粋してメール用要約として返す。
# 当日のレポートが存在しない（差分なし等）場合は空文字列を返す。
# 抽出元を概要セクション全体にしているのは、レポートによって numbered list 形式
# だったり markdown table 形式だったりするため。整形は呼び出し側（mjs）で行う。
job_notify_extract_summary() {
  local today report_file
  today="$(date +%Y-%m-%d)"
  # shellcheck disable=SC2012
  report_file="$(ls "${JOB_NOTIFY_PROJECT_DIR}/reports/${today}"_*.md 2>/dev/null | tail -1 || true)"
  [[ -n "$report_file" && -f "$report_file" ]] || return 0
  awk '
    /^## 概要/ { flag=1; next }
    flag && /^## / { exit }
    flag
  ' "$report_file"
}

job_notify_on_exit() {
  local exit_code="${1:-1}"
  local api_key="${RESEND_API_KEY:-}"
  local to="${NOTIFICATION_EMAIL:-}"
  local from="${JOB_NOTIFY_FROM:-claude-code-releases <onboarding@resend.dev>}"
  local host status_label detail now log_excerpt node_bin script_dir

  if [[ -z "$api_key" || -z "$to" ]]; then
    job_notify_log "skip: RESEND_API_KEY or NOTIFICATION_EMAIL not set"
    return 0
  fi

  if ! node_bin="$(job_notify_resolve_node)"; then
    job_notify_log "ERROR: node not found in PATH or known locations; install node or set NODE_BIN in .env"
    return 0
  fi

  if [[ -n "${JOB_NOTIFY_STATUS_LABEL:-}" ]]; then
    status_label="$JOB_NOTIFY_STATUS_LABEL"
  elif [[ "$exit_code" -eq 0 ]]; then
    status_label="成功"
  else
    status_label="異常終了"
  fi

  detail="${JOB_NOTIFY_STATUS_DETAIL:-exit_code=${exit_code}}"
  host="$(hostname -s 2>/dev/null || hostname || echo unknown-host)"
  now="$(date '+%Y-%m-%d %H:%M:%S %Z')"
  script_dir="${JOB_NOTIFY_SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"

  if [[ -n "$JOB_NOTIFY_LOGFILE" && -f "$JOB_NOTIFY_LOGFILE" ]]; then
    log_excerpt="$(tail -n 40 "$JOB_NOTIFY_LOGFILE" 2>/dev/null || true)"
  else
    log_excerpt="(log unavailable)"
  fi

  local summary
  summary="$(job_notify_extract_summary 2>/dev/null || true)"

  local notify_err
  notify_err="$(printf '%s' "$log_excerpt" | "$node_bin" "${script_dir}/job-notify.mjs" \
    "$JOB_NOTIFY_NAME" \
    "$status_label" \
    "$detail" \
    "$exit_code" \
    "$host" \
    "$now" \
    "${JOB_NOTIFY_LOGFILE:-}" \
    "$from" \
    "$summary" \
    2>&1 >/dev/null)"

  if [[ -n "$notify_err" ]]; then
    job_notify_log "ERROR: notification failed: ${notify_err}"
    return 0
  fi

  job_notify_log "notification sent (status=${status_label}, to=${to})"
}
