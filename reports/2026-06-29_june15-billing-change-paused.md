# Claude Code ニュースモード調査レポート（2026-06-29）

**調査モード:** ニュースモード（新規 CLI リリースなし、Layer 1 スキップ）
**対象期間:** 2026-06-28 レポート以降の差分
**Layer 1 最新:** v2.1.195（2026-06-26）

---

## 概要

新規 CLI リリースはなく、Layer 2（公式ブログ・ドキュメント・Help Center）と Layer 3（ニュースメディア）を調査した。最大の発見は **過去記録の訂正** で、本リポジトリが「2026-06-15 施行済み」と記録していた **サブスク課金構造変更（Agent SDK / `claude -p` 等の programmatic 利用を別建てクレジットプールへ分離する計画）が、実際には発効当日の 6/15 に Anthropic 自身によって一時停止され、施行されなかった**ことが複数の一次・二次ソースおよび Anthropic Help Center で確認された。

そのほか調査で再確認した Layer 2 トピック（Trusted Devices for Remote Control、Code with Claude London の Self-hosted sandboxes / MCP tunnels）は、いずれも既に CURRENT_FEATURES.md・過去レポートに反映済みで新規ではなかった。

---

## 主要な更新

### ⚠️【訂正】6/15 サブスク課金構造変更は一時停止＝施行されず

| 項目 | 内容 |
|------|------|
| **リリース状態** | ❌ 一時停止（施行されず） |
| **元の発表** | 2026-05-13〜14 |
| **元の発効予定日** | 2026-06-15 |
| **実際** | 発効当日の **2026-06-15 に Anthropic が Help Center で「もはや実施しない（no longer happening）」と公表し一時停止** |
| **情報源** | Anthropic Help Center / The New Stack / digitalapplied / TechTimes / Zed Blog ほか |

**当初の計画内容（5/13-14 発表）:**
- 対象: **Agent SDK 呼び出し / `claude -p`（ヘッドレス）/ Claude Code GitHub Actions / Agent Client Protocol(ACP) 経由のサードパーティアプリ**
- これらをサブスク flat-rate プールから分離し、**ユーザー単位のドル建て monthly credit メーター**（標準 API レート、ロールオーバーなし）に移行
- クレジット額（プラン別）:
  - Pro: $20
  - Max 5×: $100
  - Max 20×: $200
  - Team Standard: $20/ユーザー
  - Team Premium: $100/ユーザー
  - Enterprise Premium: $200/ユーザー
  - Enterprise Standard: $0（対象外）

**現状（6/15 以降）:**
- Agent SDK / `claude -p` / GitHub Actions / サードパーティアプリの利用は **引き続き Pro/Max/Team/Enterprise の通常サブスク上限から消費され、変更なし**
- 別建てのクレジットプールは稼働しておらず、付与されるクレジットもない
- Anthropic は「ユーザーの Claude サブスクでの構築をより良く支援するため」計画を練り直し中で、**将来変更を行う場合は事前告知する**と表明

**本リポジトリへの影響（訂正）:**
- 6/13・6/14・6/16 のレポートおよび CURRENT_FEATURES.md では、本変更を「6/15 施行済み（📢→✅）」と記録していた
- しかし実際には **施行されず一時停止**されたため、CURRENT_FEATURES.md の「廃止予定・重要な変更スケジュール」表の該当行を訂正

---

## 既に反映済み（新規ではない）と確認した項目

| 項目 | 状態 | 既存反映先 |
|------|------|-----------|
| Trusted Devices for Remote Control | 🧪 ベータ（Team/Enterprise、6/25） | 2026-06-28 レポート / CURRENT_FEATURES.md ヘッダー |
| Code with Claude London: Self-hosted sandboxes | 🧪 公開ベータ（5/19、Cloudflare/Daytona/Modal/Vercel + BYO） | 2026-05-18〜19 レポート |
| Code with Claude London: MCP tunnels | 🔬 研究プレビュー（5/19） | 2026-05-18〜19 レポート |
| Claude Code Artifacts | 🧪 ベータ（Team/Enterprise、6/18） | 2026-06-20 レポート / CURRENT_FEATURES.md |
| Nested Sub-agents（最大 5 階層） | ✅ GA（v2.1.172、6/10） | 2026-06-11 レポート / CURRENT_FEATURES.md |
| `fallbackModel`（最大 3 段フォールバック） | ✅ GA（v2.1.166） | 2026-06-08 レポート / CURRENT_FEATURES.md |
| `claude mcp login` / `logout` | ✅ GA（v2.1.186） | 2026-06-23 レポート / CURRENT_FEATURES.md |

---

## その他の Layer 2/3 状況

- **公式ニュースルーム / リリースノート**: 6/25 の Trusted Devices 以降、6/26〜29 に新規 Claude Code 機能の発表なし。
- **Claude Fable 5（公開版）**: ⛔ 停止継続（6/12 米政府輸出管理指令、公開版は書簡で言及されず）。
- **Claude Mythos 5**: 6/26 の輸出規制部分解除により 100+ の信頼できる米国機関への限定再開フェーズ（前回 6/28 レポートで記録済み、実展開タイムラインは未確認）。
- 新 CLI 機能・新モデル・新ティアの発表なし。

---

## ステータス更新サマリー

| 対象 | 変更前 | 変更後 |
|------|--------|--------|
| 6/15 サブスク課金構造変更（programmatic 利用の分離） | ✅ 施行済み | ❌ 一時停止（施行されず・訂正） |

---

## リリース一覧

新規 CLI リリースなし（Layer 1 最新は v2.1.195 / 2026-06-26、本調査では Layer 1 をスキップ）。

---

## 情報源一覧

- [Anthropic pauses Claude Agent SDK subscription change on day it was due to take effect — The New Stack](https://thenewstack.io/anthropic-pauses-claude-agent-sdk-subscription-change/)
- [Claude Credit Overhaul 2026: Anthropic Pauses the June 15 Change — DigitalApplied](https://www.digitalapplied.com/blog/anthropic-claude-credit-overhaul-june-15-2026)
- [Release notes — Claude Help Center](https://support.claude.com/en/articles/12138966-release-notes)
- [Anthropic Ends Subscription Subsidy for Agents June 15 — TechTimes](https://www.techtimes.com/articles/317625/20260602/anthropic-ends-subscription-subsidy-agents-june-15-credit-pool-replaces-flat-rate-access.htm)
- [What Anthropic's New Claude Billing Means for Zed Users — Zed Blog](https://zed.dev/blog/anthropic-subscription-changes)
- [Anthropic pauses Claude Agent SDK billing overhaul — Let's Data Science](https://letsdatascience.com/news/anthropic-pauses-claude-agent-sdk-billing-overhaul-1cff2071)
- [New in Claude Managed Agents: self-hosted sandboxes and MCP tunnels — Anthropic Blog（参考・既反映）](https://claude.com/blog/claude-managed-agents-updates)
- [Continue local sessions from any device with Remote Control — Claude Code Docs（参考・既反映）](https://code.claude.com/docs/en/remote-control)
