# 調査レポート: ソウルオフィス開設と Fable 5 / Mythos 5 復旧見通し（公式幹部発言）+ Claude Design アップデート

**調査日:** 2026-06-19

**調査モード:** ニュースモード（新規 CLI リリースなし、Layer 1 スキップ。Layer 2 / Layer 3 のみ）

## 概要

- **新規 CLI リリースなし**: Layer 1 最新は引き続き **v2.1.181**（6/17）。6/18〜19 に新しい CLI / 新フラグ / 新スラッシュコマンド / 新 Hook の追加は確認されず。
- **🆕 最重要 — Fable 5 / Mythos 5 復旧見通しが「❓ 噂」→「📢 公式幹部発言」に格上げ**: 6/18（水）、Anthropic は**ソウルオフィスを開設**し、**国際担当マネージングディレクター Chris Ciauri** が現地記者会見で「**数日以内に（in the coming days）両モデルは再び利用可能になると非常に確信している**」と**オン・レコードで明言**。前回 6/18 レポートで追跡していた第三者アカウント BridgeMind の「48 時間以内復旧」噂（❓）と異なり、これは**Anthropic 幹部による公式発言**。ただし復旧の**具体的な日付・対象範囲（US 限定か全面か）は依然未確定**で、Project Glasswing については「コメントしない」と明言を避けた。
- **🆕 輸出規制の発端＝韓国通信会社（SK Telecom と報道）が判明**: 米当局が「Mythos アクセス予定先に中国と潜在的に関係する疑いのある韓国通信会社が含まれる」ことを発見したのが 6/12 輸出管理指令の引き金、と韓国メディアが報道。SK Telecom は 2023 年に Anthropic へ $100M 出資した最も近い韓国パートナーの一社で、Glasswing 約 150 組織の 1 つだったがアクセスが取り消されたとされる。
- **🆕 Claude Design が大型アップデート（6/17、🧪 ベータ）**: デザインシステムの GitHub / デザインファイル / 生アップロードからのインポート、キャンバス直接編集、エクスポート拡充に加え、**Claude Code との連携強化**（`/design` でターミナルからデザインプロジェクトを作成・編集・同期、`/design-sync`）と、**chat / Claude Cowork / Claude Code 間での使用量上限の共有**を導入。Pro / Max / Team / Enterprise 向けベータ。
- **Layer 3 — 障害は沈静化傾向**: 6/18 に claude.ai の短時間障害（06:55–07:40 UTC、解決済み）。6/17 に Opus 4.8 で elevated errors が複数発生（いずれも解決済み）。**6/19 時点で進行中のインシデントなし**、Claude Code / API は operational。

## 詳細

### Layer 2: Anthropic ソウルオフィス開設と Fable 5 / Mythos 5 復旧見通し（6/18）

6/18（水）、Anthropic はソウル（Conrad Seoul で記者会見）で**韓国オフィスの開設**を発表。代表理事に Google Cloud / Microsoft Korea / Adobe / Snowflake 出身の **Choi Ki-young** を起用。韓国政府機関・企業との連携を多数発表した。

**韓国企業の Claude Code 採用（Layer 2 として注目）:**

- **Naver**（韓国最大のウェブポータル）— **エンジニアリング部門全体に Claude Code を導入**。記事は「**アジア最大のエンタープライズ利用事例**」と位置づけ。
- **Nexon**（ゲーム開発）— ゲーム開発に Claude Code を採用。
- **Samsung SDS** — Samsung Electronics 向けに Claude Cowork + Claude Code。
- **LG CNS**（→ LG グループへ拡大）/ **WRTN Technologies**（複数年協業）/ **Law&Company**（リーガルテック）/ **国家 AI 研究ラボ**（KAIST・高麗大・延世大・POSTECH と協業）。

**Fable 5 / Mythos 5 復旧見通し（📢 公式幹部発言）:**

国際担当マネージングディレクター **Chris Ciauri** は記者会見で：
- Project Glasswing については「**現時点ではコメントしない**」と明言を回避。
- 一方で「**We are very confident that in the coming days, the models will become available again**（数日以内に両モデルは再び利用可能になると非常に確信している）」と発言。

これは 6/12 の米国輸出管理指令によるアクセス停止以降、**Anthropic 幹部が復旧時期について公にした初の明確な見通し**。前回 6/18 レポートで「❓ 噂・未確認」として記録した第三者の「48 時間以内復旧」説とは確度が異なり、**📢 発表のみ（公式発言だが提供再開はまだ）レベル**に該当。ただし**復旧日・対象範囲は依然未確定**。

（出典: [Korea JoongAng Daily](https://www.koreajoongangdaily.com/business/anthropic-confident-of-reenabling-mythos-fable-5-access-in-coming-days-executive/12727522) / [The Korea Times](https://www.koreatimes.co.kr/business/tech-science/20260618/anthropic-opens-seoul-office-to-expand-ties-with-korean-ai-ecosystem) / [UPI](https://www.upi.com/Top_News/World-News/2026/06/18/korea-Anthropic-Seoul-office-Korea-partnerships-Washington-AI-export-controls/4641781769900/)）

### Layer 2: 輸出規制の発端＝韓国通信会社（SK Telecom と報道）

韓国メディアによれば、米当局が「**Mythos アクセス予定先の 1 つが、中国と潜在的なつながりがあると疑われる韓国の通信会社**」であることを発見したことが、6/12 の輸出管理指令（外国籍者アクセス停止）の引き金になった。報道は当該企業を **SK Telecom**（2023 年に Anthropic へ $100M 出資、Glasswing 約 150 組織の 1 社）と関連づけており、同社の Mythos アクセスは米政府の要請で取り消されたとされる。Anthropic 側はこの点について公式コメントを控えている。

（出典: [Korea JoongAng Daily](https://www.koreajoongangdaily.com/business/anthropic-confident-of-reenabling-mythos-fable-5-access-in-coming-days-executive/12727522)）

### Layer 2: Claude Design アップデート（6/17、🧪 ベータ）

Anthropic は 6/17 に Claude Design（4/17 ローンチの会話型ビジュアル制作ツール）の大型アップデートを発表。

- **デザインシステムのインポート** — GitHub リポジトリ / デザインファイル / 生アップロードから 1 つ以上のデザインシステムを取り込み、プロジェクト横断で整合を維持。
- **キャンバス直接編集** とレイアウト制御の強化。
- **エクスポート拡充** — PDF / PowerPoint / Adobe / Canva / Miro / Vercel ほか。
- **Claude Code 連携の強化** — デザインシステムを Claude Design に取り込んだうえで、`/design` で**ターミナルからデザインプロジェクトを作成・編集・同期**、`/design-sync` で Claude Code と同期。プロトタイプ→出荷の handoff を一層スムーズに。
- **使用量上限の共有** — **chat / Claude Cowork / Claude Code をまたいだ共有 usage limits** を導入。1 ターンあたりのトークン消費削減・エラー率低下も。
- **管理者ロール追加**（ガバナンス・デザインシステム承認用）。
- **対象**: Claude Pro / Max / Team / Enterprise のベータ。

> 注: `/design` / `/design-sync` は Claude Design ベータの機能として案内されており、6/17 時点で Claude Code 公式 CHANGELOG（Layer 1）には記載がない。Claude Code の正規スラッシュコマンドとして確定したかは未確認のため、本レポートでは Claude Design 側の機能として扱う。

（出典: [TechRepublic](https://www.techrepublic.com/article/news-anthropic-claude-design-overhaul-enterprise-teams/)）

### Layer 3: プラットフォーム障害は沈静化傾向

- **6/18**: claude.ai に影響する障害（06:55–07:40 UTC）→ 解決済み。
- **6/17**: Claude Opus 4.8 で elevated errors が複数発生 → いずれも調査・対応・モニタリングを経て解決済み。
- **6/10**: Claude Haiku 4.5 のエラー率上昇 → 解決済み。
- **6/19 時点**: 進行中のインシデントなし。90 日稼働率は claude.ai 98.93% / Claude API 99.29% / Claude Code 99.15% / Claude Console 99.42%。

6/5 以降続いていた連続障害（6/16 で「12 日間に 10 回目」）と比べ、直近は沈静化傾向。

（出典: [status.claude.com](https://status.claude.com/)）

## バグ修正・パフォーマンス改善

新規 CLI リリースがないため Layer 1 の修正項目はなし。Claude Design 側では 1 ターンあたりトークン消費削減・エラー率低下が報告された（上記参照）。

## リリース一覧

| 項目 | 日付 | 種別 | 主要変更 |
|------|------|------|---------|
| CLI | — | — | 新規リリースなし（最新は v2.1.181 / 6/17） |
| Anthropic ソウルオフィス開設 | 2026-06-18 | Layer 2 | 韓国拠点開設、Naver（エンジニア全部門に Claude Code・アジア最大）/ Nexon / Samsung SDS 等の採用発表 |
| Fable 5 / Mythos 5 復旧見通し | 2026-06-18 | Layer 2（📢） | Ciauri「数日以内に再提供と確信」=❓噂→📢公式発言に格上げ、日付・範囲は未確定 |
| Claude Design アップデート | 2026-06-17 | Layer 2（🧪） | デザインシステムインポート / キャンバス直接編集 / `/design`・`/design-sync` の Claude Code 連携 / chat・Cowork・Claude Code 横断の使用量共有 |

## 情報源一覧

- [Korea JoongAng Daily — Anthropic confident of re-enabling Mythos / Fable 5 access in coming days](https://www.koreajoongangdaily.com/business/anthropic-confident-of-reenabling-mythos-fable-5-access-in-coming-days-executive/12727522)
- [The Korea Times — Anthropic opens Seoul office to expand ties with Korean AI ecosystem](https://www.koreatimes.co.kr/business/tech-science/20260618/anthropic-opens-seoul-office-to-expand-ties-with-korean-ai-ecosystem)
- [UPI — Anthropic opens Seoul office amid U.S. AI export controls](https://www.upi.com/Top_News/World-News/2026/06/18/korea-Anthropic-Seoul-office-Korea-partnerships-Washington-AI-export-controls/4641781769900/)
- [TechRepublic — Anthropic Adds Brand Controls, Code Sync to Claude Design](https://www.techrepublic.com/article/news-anthropic-claude-design-overhaul-enterprise-teams/)
- [status.claude.com](https://status.claude.com/)
</content>
