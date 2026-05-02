# 2026-05-03 ニュースモード調査: Hegseth「ideological lunatic」発言・White House による Mythos 70社拡大計画ブロック・5/5 Financial Services Briefing 予告

**調査日**: 2026-05-03
**モード**: ニュースモード（Layer 2 公式・Layer 3 メディア、Layer 1 CLI チェンジログはスキップ）
**前回調査**: 2026-05-02 フルモード（v2.1.126 大型リリース・Pentagon 7社+Oracle AI契約・Anthropic 除外継続）

---

## 概要

CLI v2.1.126（5/1 02:05 UTC）以降、新しい Claude Code リリースは確認できず（npm 上 v2.1.126 が継続最新、GitHub Releases も同様）。Anthropic Newsroom（anthropic.com/news）は **4/28「Claude for Creative Work」** が最新エントリで、5/1〜5/3 に新規エントリなし。Platform API Release Notes も **4/30「Sonnet 4.5/4 の 1M context window beta retirement 発効」** が最新で、5/1〜5/3 に新規エントリなし。Help Center Release Notes も新規エントリなし。

ただし **Layer 3 で 4 件の重要な政府関係続報** を確認し、いずれも前回（5/2）レポートに未記載：

| # | カテゴリ | 内容 | 確度 | ソース | 日付 |
|---|---------|------|------|--------|------|
| ① | **DoD/政治** | **Defense Secretary Pete Hegseth が Senate Armed Services Committee 公聴会（4/30）で Anthropic CEO Dario Amodei を「ideological lunatic」と呼称** — Senator Jacky Rosen (D-NV) からの追及を受けた応答 | 確定（複数報道） | [Bloomberg](https://www.bloomberg.com/news/articles/2026-04-30/hegseth-calls-amodei-a-lunatic-and-defends-pentagon-use-of-ai) / [Axios](https://www.axios.com/2026/05/01/washington-new-anthropic-problem) / [BGov](https://news.bgov.com/bloomberg-government-news/hegseth-calls-amodei-a-lunatic-and-defends-pentagon-use-of-ai) | 2026-04-30 |
| ② | **DoD/政治** | **White House が Anthropic の Mythos 拡大計画（50→120 社）を阻止** — 国家安全保障 + コンピュート可用性懸念。WSJ スクープ（4/30）→ Bloomberg / Sherwood / Cryptobriefing / Gateway Pundit / Blockonomi など複数報道で広がる | 確定（複数報道、Anthropic 公式コメントなし） | [Bloomberg (4/30)](https://www.bloomberg.com/news/articles/2026-04-30/white-house-opposes-anthropic-plan-for-mythos-access-wsj-says) / [Sherwood](https://sherwood.news/tech/white-house-nixes-anthropic-plan-to-expand-mythos-access-to-more-companies/) / [Gateway Pundit](https://www.thegatewaypundit.com/2026/05/trump-administration-fights-anthropics-plan-expand-mythos-ai/) / [Blockonomi](https://blockonomi.com/trump-administration-halts-anthropics-mythos-ai-expansion-plans-over-security-fears/) | 2026-04-30〜2026-05-02 |
| ③ | **公式イベント予告** | **Anthropic「The Briefing: Financial Services」livestreamed event を 5/5 11:00 AM EST 開催予告** — NYC、新製品機能発表予定（金融機関向け）。Application closed、livestream は anthropic.com/events で公開 | 📢 公式アナウンス済み | [Anthropic Events](https://www.anthropic.com/events/the-briefing-financial-services-virtual-event) | 2026-05-05 開催予告 |
| ④ | **Layer 3 噂** | **メディア（Fordel/Mfierce/AI Nexus Daily/NxCode）が「5/6 Anthropic Developer Event」を予測** — Sonnet 4.8 / Claude Jupiter（コードネーム）正式発表の可能性。**Anthropic 公式アナウンスは確認できず**、3/31 の Claude Code ソースリーク内 `sonnet-4-8` 言及からの推測 | ❓ 噂（公式未確認） | [AI Nexus Daily](https://www.ainexusdaily.com/article/anthropic-source-leak-claude-sonnet-4-8-undercover-mode) / [Fordel Pulse](https://fordelstudios.com/pulse/anthropic-leaks-claude-code-source-opus-47-sonnet-48-mythos-exposed) / [NxCode](https://www.nxcode.io/resources/news/claude-sonnet-4-8-release-date-features-what-to-expect-2026) | 2026-05-06（予測） |

加えて、**resultsense.com の 5/1 サマリー**で UK AI Safety Institute が「GPT-5.5 が Mythos 同等のオフェンシブ・サイバー能力に到達」と報告した点が言及されており、これは前回未捕捉の二次情報。

---

## ① Hegseth「ideological lunatic」発言（4/30 Senate Armed Services Committee）

### 経緯

2026-04-30（Thursday）、Senate Armed Services Committee で Defense Department FY2027 予算と Iran 戦争に関する公聴会。Defense Secretary **Pete Hegseth**、Joint Chiefs Chairman **Gen. Dan Caine**、Pentagon CFO **Jules Hurst** が証言。

公聴会は基本的に Iran 戦争・$1.45T 予算・Pentagon 解雇問題を中心に進行したが、Senator **Jacky Rosen（D-NV）** が **Anthropic を "supply chain risk" と指定した DoD の判断について追及**。Hegseth は名指しを避けつつ Dario Amodei CEO を念頭に置いた発言を行った。

### Hegseth の発言

> **"Anthropic is run by an ideological lunatic who shouldn't have a sole decision-making over what we do."**
>
> （Anthropic はイデオロギー的狂人によって運営されており、その人物に我々の行動を一任させるべきではない）

加えて Hegseth は、米国は AI に致死的標的決定をさせていないと主張。Anthropic が Claude を mass surveillance および完全自律兵器運用への利用を拒否していることを批判。

### Anthropic 側の反応

- 公式コメントなし（CNBC への引用拒否継続中）
- Dario Amodei CEO は 4/17 White House Susie Wiles 首席補佐官・Scott Bessent 財務長官と会談済み（紛争解消交渉開始）
- 4/30 時点で訴訟は控訴審係属中（一時差止め命令は有効）

### 重要性

- **Pentagon Defense Secretary が公聴会で AI ベンダー CEO を公然と名指し批判**（極めて稀）
- **5/1 Pentagon の 7社+Oracle 契約発表（Anthropic 除外）の前日**に発言
- **White House の和解交渉路線（Susie Wiles 会談、4/29 Axios「Trump officials draft plan to bring Anthropic back」、4/28 Axios「White House drafts guidance to bypass Anthropic's risk flag」）と矛盾**
- → **ホワイトハウスと Pentagon の温度差を裏付ける** 5/1 報道の文脈と整合（5/2 レポート ② で言及した「DoD CTO Emil Michael の Mythos 別枠評価」発言と表裏）

### 情報源
- [Bloomberg - Hegseth Calls Amodei a 'Lunatic' and Defends Pentagon Use of AI (2026-04-30)](https://www.bloomberg.com/news/articles/2026-04-30/hegseth-calls-amodei-a-lunatic-and-defends-pentagon-use-of-ai)
- [MSN - Hegseth calls Anthropic CEO a 'lunatic,' defends Pentagon AI use](https://www.msn.com/en-us/news/technology/hegseth-calls-anthropic-ceo-a-lunatic-defends-pentagon-ai-use/ar-AA227pKG)
- [Axios - Washington has a new Anthropic problem (2026-05-01)](https://www.axios.com/2026/05/01/washington-new-anthropic-problem)
- [Bloomberg Government - Hegseth Calls Amodei a 'Lunatic'](https://news.bgov.com/bloomberg-government-news/hegseth-calls-amodei-a-lunatic-and-defends-pentagon-use-of-ai)
- [YouTube - Hegseth: "Anthropic is run by an ideological lunatic"](https://www.youtube.com/watch?v=Zp3wcnKGCMo)
- [Let's Data Science - Rosen Confronts Hegseth Over Anthropic Security Label](https://letsdatascience.com/news/rosen-confronts-hegseth-over-anthropic-security-label-1befedaf)

---

## ② White House、Mythos 拡大計画（50→120 社）を阻止（4/30 WSJ → 5/2-3 続報）

### 経緯

WSJ が 4/30 にスクープ。Anthropic は Project Glasswing 参加組織を **現在の約 50 社（一部報道では 12 創設パートナー＋40 社の重要インフラ管理組織）から 70 社追加で 120 社に拡大する計画** を White House に提示していたが、**White House が反対**。

### 反対理由

| 観点 | 内容 |
|------|------|
| **国家安全保障** | Mythos がエクスプロイトを autonomously chain できる能力（27 年前 OpenBSD バグ・全主要 OS/ブラウザで数千ゼロデイ発見・非専門家でも一晩で完全動作するエクスプロイトを取得可能）を、120 社規模に拡散することのリスク。「If it falls in the wrong hands could cause doomsday」（Gateway Pundit 引用） |
| **コンピュート可用性** | Anthropic 自体のコンピュート供給が不足、120 社をサポートすると **既存政府機関（NSA など）への access が劣化する懸念**。Anthropic は同時に Google/Broadcom（4/6）・CoreWeave（4/10）・AWS（4/20、5GW 拡張）と相次いで容量契約を締結中だが、即時供給には不十分 |

### 情勢上の意味

- **連邦政府は Mythos 利用拡大を望むが、民間への拡大は阻止** という二重姿勢
  - **連邦機関方向**: NSA は実利用中（4/19 Axios）、商務省 AI 標準化センター・エネルギー省・財務省金融システム保護部門は評価中（4/18 RedState）、CISA は OMB がアクセス整備中（4/17 Bloomberg、ただし 4/21 Axios で「実際にはアクセスなし」と訂正）
  - **民間方向**: Project Glasswing 12 創設＋40 重要インフラ組織は維持、ただし 70 社拡大計画は阻止
- 同時期に「**非認可ユーザーが private online forum で Mythos アクセスを取得**」した breach も判明（resultsense.com 5/1 サマリー）→ controlled-access モデルの限界を露呈
- **Hegseth の "ideological lunatic" 発言（4/30）と同日**に WSJ がスクープ → Pentagon と White House の温度差を再強調

### Anthropic 側の対応

- 公式コメントなし
- Project Glasswing は 4/7 発表時点から「一般公開予定なし」「dual-use 懸念」を明言済み
- 4/13 報道で米 FRB・財務省・英イングランド銀行・カナダ銀行が緊急会合を実施した文脈

### Claude Code への影響

- **直接の影響なし**: Project Glasswing は招待制研究プレビューで、Claude Code は商用 Pro/Max/Team/Enterprise 全プランで通常通り利用可能
- **間接的影響**: Mythos の controlled-access モデルが White House の介入で固定化されると、**Cyber Verification Program（5/1 公開）等を経由した個別組織解禁トラックが Claude Security の主要拡大経路** となる可能性

### 情報源
- [Bloomberg - White House Opposes Anthropic's Mythos AI Expansion, WSJ Reports (2026-04-30)](https://www.bloomberg.com/news/articles/2026-04-30/white-house-opposes-anthropic-plan-for-mythos-access-wsj-says)
- [Sherwood News - White House nixes Anthropic plan to expand Mythos access](https://sherwood.news/tech/white-house-nixes-anthropic-plan-to-expand-mythos-access-to-more-companies/)
- [Gateway Pundit - Trump Administration Fights Anthropic's Plan To Expand Mythos AI](https://www.thegatewaypundit.com/2026/05/trump-administration-fights-anthropics-plan-expand-mythos-ai/)
- [Blockonomi - Trump Administration Halts Anthropic's Mythos AI Expansion Over Security Fears](https://blockonomi.com/trump-administration-halts-anthropics-mythos-ai-expansion-plans-over-security-fears/)
- [Cryptobriefing - White House blocks Anthropic's Mythos expansion](https://cryptobriefing.com/white-house-blocks-anthropics-mythos-expansion-over-security-concerns/)
- [TheNextWeb - Trump administration blocks Anthropic's Mythos rollout](https://thenextweb.com/news/white-house-opposes-anthropic-mythos-expansion)
- [Parameter - Trump Administration Halts Anthropic's Mythos AI Expansion](https://parameter.io/trump-administration-halts-anthropics-mythos-ai-expansion-over-security-fears/)
- [resultsense - Anthropic Mythos: zero-day discovery, White House blocks expansion (2026-05-01)](https://www.resultsense.com/news/2026-05-01-anthropic-mythos-cyber-alarm)

---

## ③ Anthropic「The Briefing: Financial Services」livestreamed event 予告（5/5）📢

### 概要

Anthropic 公式 events ページに掲載された **livestreamed virtual event**。

| 項目 | 内容 |
|------|------|
| **日時** | 2026-05-05（Tuesday）11:00 AM – 12:30 PM EST |
| **会場** | Virtual（livestreamed from New York City） |
| **対象** | CIO / CTO / COO / Chief Data Officer / Innovation heads at financial institutions |
| **内容** | Anthropic C-suite executives + 主要金融機関リーダーが登壇。「Anthropic's vision for AI in finance」、デプロイ実例、**新製品機能発表とライブデモ** |
| **登録** | クローズ済み（livestream のみ公開） |
| **視聴 URL** | [anthropic.com/events/the-briefing-financial-services-virtual-event](https://www.anthropic.com/events/the-briefing-financial-services-virtual-event) |

### 期待される発表内容（推測）

- **Claude Financial Services Agents** または金融機関向け Managed Agents プリセット
- **Claude Security の Financial Services 特化機能**（5/1 公開ベータの拡張、JPMorgan Chase 等の事例）
- **Compliance / Audit 系 MCP コネクタ**
- **Cowork on Bedrock** の金融機関 reference architecture

### 文脈

- **2025-11 Anthropic Financial Services Plugins for Claude**（LinkedIn 投稿経由で確認）の延長線
- **2026-04-10 CNBC 報道**：FRB Powell + 財務長官 Bessent が米主要銀行 CEO と Mythos AI サイバー脅威について協議
- **2026-04-13 Wall Street Banks try out Anthropic's Mythos**（Insurance Journal）
- **2026-04-23 Goldman Sachs が Hong Kong バンカーの Claude アクセスを遮断**（FT スクープ）→ 金融機関の Claude 採用は同時にコンプライアンスリスクも露呈
- **2026-04-29 Anthropic $50B/$900B 調達ラウンドの Goldman Sachs / JPMorgan / Morgan Stanley 主幹事候補**

→ 5/5 イベントは **Anthropic の金融セクター戦略を明示する場** として注目度高い。**5 月取締役会での $50B 調達ラウンド決定**（4/29 Bloomberg/TechCrunch スクープ）の前後でもあり、IPO ロードショーの一環の可能性も。

### 情報源
- [Anthropic Events - The Briefing: Financial Services Virtual Event](https://www.anthropic.com/events/the-briefing-financial-services-virtual-event)
- [Anthropic Events overview](https://www.anthropic.com/events)

---

## ④ メディア予測: 5/6 Anthropic Developer Event ❓

### 概要

複数のメディア（NxCode / Fordel Studios Pulse / AI Nexus Daily / Mfierce Medium 記事）が「**5/6 に Anthropic developer event を予定**」と報じ、**Sonnet 4.8 / Claude "Jupiter" の正式発表が期待される** との予測を展開。

### 根拠

- **2026-03-31 Claude Code ソースコードリーク事件**（59.8MB npm source map、Chaofan Shou 発見、512K 行 TypeScript）で `sonnet-4-8` モデル名・"Undercover Mode" 内部機能・"Claude Jupiter v1" コードネームを確認
- **Anthropic の慣例**: Opus → Sonnet が 1〜4 週間遅れ。Opus 4.7 が 4/16 GA リリース → 5 月中の Sonnet 4.8 リリースが予測される
- Sonnet 4.8 の Sonnet 4.7 スキップ（Opus と番号合わせる慣行）

### 公式確認状況

- **Anthropic 公式 events ページに 5/6 イベントの掲載なし** ← **重要**
- Anthropic Newsroom / Help Center / Platform Release Notes に 5/6 言及なし
- → **公式アナウンスは確認できず、メディア予測の域を出ない（❓ 噂）**

### 期待される変更点（メディア予測）

| 項目 | 予測内容 |
|------|---------|
| 価格 | $3 / $15 per M tokens（Sonnet 4.6 と同じ） |
| ビジョン | 2,576px 高解像度サポート（Opus 4.7 から移植） |
| 指示追従 | Opus 4.7 の improvement 移植 |
| ベンチマーク | SWE-bench / MMLU 系の改善 |

### 情報源
- [NxCode - Claude Sonnet 4.8: Release Date, Features & What to Expect (2026)](https://www.nxcode.io/resources/news/claude-sonnet-4-8-release-date-features-what-to-expect-2026)
- [AI Nexus Daily - Anthropic Source Code Leak Reveals Claude Sonnet 4.8 and Secret Undercover Mode](https://www.ainexusdaily.com/article/anthropic-source-leak-claude-sonnet-4-8-undercover-mode)
- [Fordel Pulse - Anthropic Accidentally Leaks Claude Code Source — Opus 4.7, Sonnet 4.8, and Mythos Next-Gen Exposed](https://fordelstudios.com/pulse/anthropic-leaks-claude-code-source-opus-47-sonnet-48-mythos-exposed)
- [Medium (Mfierce) - The Claude Code Leak: Opus 4.7, Sonnet 4.8, and Mythos](https://medium.com/@mfierce0/the-claude-code-leak-opus-4-7-sonnet-4-8-and-mythos-a-rare-unfiltered-look-inside-anthropic-70c6f735810a)

---

## ⑤ 補足: UK AI Safety Institute、GPT-5.5 のオフェンシブ・サイバー能力評価（resultsense 5/1 サマリー言及）

### 概要

resultsense.com の 5/1 Mythos cyber alarm 記事内で **「UK AI Safety Institute reported GPT-5.5 reaching similar offensive-cyber capabilities」** との記述。OpenAI の GPT-5.5 が **Mythos と同等の autonomous offensive cyber capability** を達成したと UK AISI が独立評価で報告したとされる。

### 重要性

- Mythos は Anthropic 単独の現象ではなく、**フロンティア LLM 全般のオフェンシブ・サイバー能力到達** を示唆
- UK AISI による Mythos の独立評価（4/14 公開）に続き、**比較ベースライン形成** が始まっている
- Project Glasswing の controlled-access モデルが業界標準になり得るかの判断材料

### 注意

resultsense.com は二次情報まとめサイト。**UK AISI の一次ソース公開**は本調査範囲では確認できず、続報待ち。

### 情報源
- [resultsense - Anthropic Mythos: zero-day discovery, White House blocks expansion (2026-05-01)](https://www.resultsense.com/news/2026-05-01-anthropic-mythos-cyber-alarm)

---

## CURRENT_FEATURES.md 更新箇所

### 米国防総省（DoD）ブラックリスト指定セクション
- **2026-04-30 Hegseth 発言** を追記:
  - Senate Armed Services Committee 公聴会で Senator Jacky Rosen (D-NV) からの追及に応答
  - 「Anthropic is run by an ideological lunatic who shouldn't have a sole decision-making over what we do」発言
  - 5/1 Pentagon 7社+Oracle 契約発表の前日、White House の和解交渉路線と矛盾
- **2026-04-30 White House による Mythos 70社拡大計画ブロック** を追記:
  - 50→120 社拡大計画を阻止
  - 国家安全保障 + コンピュート可用性懸念
  - 連邦機関方向への利用拡大は継続、民間拡大のみ阻止という二重姿勢
  - 同時期に non-authorized users が private forum で Mythos アクセスを取得した breach も判明

### 予定・未確認情報セクション
- **The Briefing: Financial Services（5/5）📢** を新規追加:
  - Anthropic 公式 livestreamed event、11:00-12:30 EST、NYC、新製品機能発表予定
  - 金融機関 CIO/CTO/COO 対象、Anthropic C-suite 登壇
- **5/6 Anthropic Developer Event（メディア予測）❓** を新規追加:
  - メディアが Sonnet 4.8 / Claude Jupiter 発表予測
  - 公式 events ページに記載なし、確度低
- **Sonnet 4.8 リリース予測（5 月内）❓** を更新:
  - 公式アナウンスなしの状態を継続確認、5/2 レポート時点と同じ ❓

### 主要機能・更新履歴
- 5/3 ニュースモード調査の追加

---

## 結論

CLI v2.1.126（5/1）以降、新しい Claude Code リリースは確認できず、Anthropic Newsroom / Platform Release Notes / Help Center にも 5/1〜5/3 の新規エントリなし。**Layer 1（CLI）は静穏**。

ただし **Layer 3 で 4 件の重要な政府関係続報** を確認:
1. **Hegseth「ideological lunatic」発言**（4/30 Senate）— Defense Secretary が AI ベンダー CEO を公然と名指し批判する稀な事例。White House の和解交渉路線と矛盾し、Pentagon-White House の温度差を再強調
2. **White House による Mythos 70社拡大計画ブロック**（4/30 WSJ）— 連邦機関方向への利用拡大は継続、民間拡大のみ阻止という二重姿勢。Cyber Verification Program 等の個別組織解禁トラックの相対的重要度上昇
3. **5/5 Financial Services Briefing**（公式予告）— Anthropic の金融セクター戦略明示の場、IPO ロードショーの一環の可能性
4. **5/6 Developer Event 予測**（メディア・公式未確認）— Sonnet 4.8 / Claude Jupiter 発表期待、ただし公式 events ページに記載なし

次回以降の重点監視:
- **5/5 Financial Services Briefing 内容** — Claude Financial Services Agents / Compliance MCP / Cowork 金融 reference の有無
- **5/6 Developer Event の有無と内容** — Sonnet 4.8 GA / Jupiter 発表があるか
- **Anthropic 公式の Hegseth 発言・Mythos 拡大ブロックへの応答**
- **Anthropic $50B/$900B 調達ラウンドの 5 月取締役会決定**
- **訴訟控訴審の動向**
- **CLI v2.1.127 以降のリリース**
