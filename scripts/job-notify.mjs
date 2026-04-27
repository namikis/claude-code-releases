#!/usr/bin/env node

import { stdin } from "node:process";
import https from "node:https";

const [
  jobName = "job",
  statusLabel = "unknown",
  detail = "",
  exitCode = "1",
  host = "unknown-host",
  finishedAt = "",
  logfile = "",
  from = "claude-code-releases <onboarding@resend.dev>",
] = process.argv.slice(2);

const apiKey = process.env.RESEND_API_KEY;
const to = process.env.NOTIFICATION_EMAIL;

if (!apiKey || !to) {
  process.exit(0);
}

function escapeHtml(value) {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

function readStdin() {
  return new Promise((resolve, reject) => {
    let data = "";
    stdin.setEncoding("utf8");
    stdin.on("data", (chunk) => {
      data += chunk;
    });
    stdin.on("end", () => resolve(data));
    stdin.on("error", reject);
  });
}

const logExcerpt = await readStdin();
const subject = `[claude-code-releases] ${jobName} ${statusLabel}`;

const statusColor = (
  {
    成功: "#16a34a",
    スキップ: "#6b7280",
    異常終了: "#dc2626",
  }[statusLabel] || "#2563eb"
);

const html = `
<div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; max-width: 640px;">
  <h2 style="margin: 0 0 12px 0; font-size: 16px; color: #1a1a1a;">${escapeHtml(jobName)}</h2>
  <p style="margin: 0 0 12px 0;">
    <span style="display: inline-block; padding: 4px 12px; border-radius: 12px; background: ${statusColor}; color: white; font-size: 13px; font-weight: 600;">
      ${escapeHtml(statusLabel)}
    </span>
  </p>
  <p style="margin: 0 0 6px 0; color: #4a4a4a; font-size: 14px;">${escapeHtml(detail)}</p>
  <p style="margin: 0 0 2px 0; color: #6b7280; font-size: 13px;">終了コード: ${escapeHtml(exitCode)}</p>
  <p style="margin: 0 0 2px 0; color: #6b7280; font-size: 13px;">ホスト: ${escapeHtml(host)}</p>
  <p style="margin: 0 0 12px 0; color: #6b7280; font-size: 13px;">時刻: ${escapeHtml(finishedAt)}</p>
  <p style="margin: 0 0 12px 0; color: #6b7280; font-size: 12px;">ログ: ${escapeHtml(logfile || "(none)")}</p>
  <pre style="margin: 0; padding: 12px; border-radius: 8px; background: #f6f8fa; color: #1f2937; font-size: 12px; white-space: pre-wrap;">${escapeHtml(logExcerpt || "(log unavailable)")}</pre>
</div>
`;

const payload = JSON.stringify({
  from,
  to: [to],
  subject,
  html,
});

await new Promise((resolve, reject) => {
  const req = https.request(
    "https://api.resend.com/emails",
    {
      method: "POST",
      headers: {
        Authorization: `Bearer ${apiKey}`,
        "Content-Type": "application/json",
        "Content-Length": Buffer.byteLength(payload),
      },
    },
    (res) => {
      let body = "";
      res.setEncoding("utf8");
      res.on("data", (chunk) => {
        body += chunk;
      });
      res.on("end", () => {
        if (res.statusCode && res.statusCode >= 200 && res.statusCode < 300) {
          resolve();
          return;
        }
        reject(new Error(`Resend API failed: ${res.statusCode ?? "unknown"} ${body}`));
      });
    },
  );

  req.on("error", reject);
  req.write(payload);
  req.end();
});
