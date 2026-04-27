#!/usr/bin/env bash

# launchd ジョブ終了時のメール通知ヘルパー。
# RESEND_API_KEY / NOTIFICATION_EMAIL が未設定なら何もしない。

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

job_notify_on_exit() {
  local exit_code="${1:-1}"
  local api_key="${RESEND_API_KEY:-}"
  local to="${NOTIFICATION_EMAIL:-}"
  local from="${JOB_NOTIFY_FROM:-claude-code-releases <onboarding@resend.dev>}"
  local host status_label detail now log_excerpt

  [[ -n "$api_key" && -n "$to" ]] || return 0

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

  if [[ -n "$JOB_NOTIFY_LOGFILE" && -f "$JOB_NOTIFY_LOGFILE" ]]; then
    log_excerpt="$(tail -n 40 "$JOB_NOTIFY_LOGFILE" 2>/dev/null || true)"
  else
    log_excerpt="(log unavailable)"
  fi

  printf '%s' "$log_excerpt" | node "${JOB_NOTIFY_SCRIPT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}/job-notify.mjs" \
    "$JOB_NOTIFY_NAME" \
    "$status_label" \
    "$detail" \
    "$exit_code" \
    "$host" \
    "$now" \
    "${JOB_NOTIFY_LOGFILE:-}" \
    "$from" \
    >/dev/null 2>&1 || return 0
}
