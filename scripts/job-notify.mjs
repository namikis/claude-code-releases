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
  summary = "",
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

// レポート抜粋を「上位3項目 × 1行」に凝縮する。
// レポートによって概要セクションが numbered list / markdown table のどちらでも
// 来るため、両方をサポートして items 配列を作ってから condense する。
const truncate = (s, n) => (s.length > n ? s.slice(0, n) + "…" : s);

function condenseItem(text, maxTailChars) {
  const bolds = [...text.matchAll(/\*\*(.+?)\*\*/g)].map((m) => m[1].trim());
  if (bolds.length >= 2) {
    return `<strong>${escapeHtml(bolds[0])}</strong> — ${escapeHtml(truncate(bolds[1], maxTailChars))}`;
  }
  if (bolds.length === 1) {
    const tail = text
      .replace(/\*\*[^*]+\*\*/g, "")
      .replace(/^[（(][^）)]*[）)]\s*/, "")
      .replace(/^\s*[—–-]\s*/, "")
      .split(/[。\n]/)[0]
      .trim();
    return tail
      ? `<strong>${escapeHtml(bolds[0])}</strong> — ${escapeHtml(truncate(tail, maxTailChars))}`
      : `<strong>${escapeHtml(bolds[0])}</strong>`;
  }
  return escapeHtml(truncate(text.split(/[。\n]/)[0].trim(), 80));
}

function extractSummaryItems(raw) {
  // 1) numbered list を最優先で探す
  const ol = [];
  for (const line of raw.split("\n")) {
    const m = line.match(/^\s*\d+\.\s+(.+?)\s*$/);
    if (m) ol.push(m[1]);
  }
  if (ol.length > 0) return ol;

  // 2) markdown table のデータ行を抽出（ヘッダー → 区切り行 → データ行 を期待）
  const rows = [];
  let state = "before"; // before | header | rows
  for (const line of raw.split("\n")) {
    const trimmed = line.trim();
    if (!trimmed.startsWith("|")) {
      if (state === "rows" && rows.length > 0) break;
      state = "before";
      continue;
    }
    if (/^\|[-:|\s]+\|$/.test(trimmed)) {
      if (state === "header") state = "rows";
      continue;
    }
    if (state === "before") {
      state = "header";
      continue;
    }
    if (state !== "rows") continue;
    const cells = trimmed.split("|").map((c) => c.trim()).filter((c) => c.length > 0);
    if (cells.length === 0) continue;
    // 太字を含むセルのうち最も長いものを「内容セル」とする
    const bolded = cells.filter((c) => /\*\*/.test(c));
    let content;
    if (bolded.length > 0) {
      content = bolded.slice().sort((a, b) => b.length - a.length)[0];
    } else {
      content = cells[Math.min(2, cells.length - 1)];
    }
    if (content) rows.push(content);
  }
  return rows;
}

function condenseSummaryToHtml(raw, maxItems = 3, maxTailChars = 50) {
  if (!raw || !raw.trim()) return "";
  const items = extractSummaryItems(raw);
  if (items.length === 0) return "";
  return items
    .slice(0, maxItems)
    .map((item, i) => `${i + 1}. ${condenseItem(item, maxTailChars)}`)
    .join("<br>");
}

function summaryHtml(text) {
  const inner = condenseSummaryToHtml(text);
  if (!inner) return "";
  return `
  <div style="margin: 0 0 16px 0; padding: 12px 14px; border-radius: 8px; background: #eff6ff; border-left: 3px solid #2563eb;">
    <h3 style="margin: 0 0 8px 0; font-size: 14px; color: #1e3a8a;">本日の主要トピック</h3>
    <div style="margin: 0; font-size: 13px; line-height: 1.6; color: #1f2937;">${inner}</div>
  </div>`;
}

const html = `
<div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; max-width: 640px;">
  <h2 style="margin: 0 0 12px 0; font-size: 16px; color: #1a1a1a;">${escapeHtml(jobName)}</h2>
  <p style="margin: 0 0 12px 0;">
    <span style="display: inline-block; padding: 4px 12px; border-radius: 12px; background: ${statusColor}; color: white; font-size: 13px; font-weight: 600;">
      ${escapeHtml(statusLabel)}
    </span>
  </p>
  <p style="margin: 0 0 6px 0; color: #4a4a4a; font-size: 14px;">${escapeHtml(detail)}</p>
  ${summaryHtml(summary)}
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
