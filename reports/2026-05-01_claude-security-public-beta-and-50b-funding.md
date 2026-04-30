# 2026-05-01 ニュースモード調査: Claude Security 公開ベータ & Anthropic $50B/$900B 調達ラウンド

**調査日**: 2026-05-01
**モード**: ニュースモード（Layer 1 CLI スキップ、Layer 2 公式・Layer 3 ニュースのみ）
**前回調査**: 2026-04-30（v2.1.123 / Goldman Sachs Hong Kong 遮断 / 1M context beta retirement）

---

## 概要

新 CLI リリースなし（**v2.1.123 が継続最新**）。Layer 2 で **2 件の重要発表**、Layer 3 で **1 件の大型ファイナンススクープ**、加えて Layer 2 障害が 4/30 にも発生。

| # | カテゴリ | 内容 | 発表元 | 日付 |
|---|---------|------|--------|------|
| ① | **Layer 2 公式（新製品 GA）** | **Claude Security 公開ベータ開始** — 旧 "Claude Code Security" 研究プレビューが Enterprise 向け公開ベータへ昇格、Opus 4.7 駆動、Claude Code on Web 統合で findings から直接パッチ開発 | [claude.com/blog](https://claude.com/blog/claude-security-public-beta) | 2026-04-30 |
| ② | **Layer 2 公式（プログラム）** | **Cyber Verification Program** 受付開始 — Opus 4.7 cyber safeguards に正当な防御目的研究がブロックされる組織向け vetting プログラム | Anthropic（Claude Security 発表内） | 2026-04-30 |
| ③ | **Layer 3 ファイナンススクープ** | **Anthropic が $50B 調達ラウンドを協議中、評価額 $850-900B** — 2 月の $380B から **約 2.4 倍**、5 月の取締役会で決定見込み、10 月 IPO 候補 | [Bloomberg](https://www.bloomberg.com/news/articles/2026-04-29/anthropic-considering-funding-offers-at-over-900-billion-value) / [TechCrunch](https://techcrunch.com/2026/04/29/sources-anthropic-could-raise-a-new-50b-round-at-a-valuation-of-900b/) | 2026-04-29 |
| ④ | **Layer 2 障害** | **Major クラス障害（4/30 13:10 UTC〜）** claude.ai + API unavailable + Haiku 4.5 elevated errors — 4 月 Major 障害は 4/15・4/20・4/25・4/28 に続く 5 件目 | [Claude Status](https://status.claude.com/) | 2026-04-30 |

Anthropic Newsroom（anthropic.com/news）には 4/28「Claude for Creative Work」以降新規エントリなし — 今回の Claude Security 発表は **claude.com/blog** プロダクトページ経由のみで Newsroom には未掲載。Help Center / Platform Release Notes も 4/29-30 新規エントリなし。

---

## ① Claude Security 公開ベータ開始（2026-04-30）✅ 公開ベータ

### 発表概要

**Anthropic が "Claude Security" の公開ベータを開始**。旧名称「**Claude Code Security**」として 2026-02 以降 hundreds of organizations で限定的研究プレビュー運用されていたツールが、Enterprise 顧客向け公開ベータへ昇格。

- **公式ブログ**: [claude.com/blog/claude-security-public-beta](https://claude.com/blog/claude-security-public-beta)
- **製品ページ**: [claude.com/product/claude-security](https://claude.com/product/claude-security)
- **アクセス**: claude.ai サイドバー or **claude.ai/security**
- **対象プラン**: 🧪 **Claude Enterprise（公開ベータ）** / Claude Team および Max は "coming soon"
- **モデル**: **Claude Opus 4.7** 駆動

### コア機能

#### コードベースの reasoning 型解析
- パターンマッチではなく「セキュリティ研究者と同様の reasoning」: コンポーネント間の相互作用、ファイル横断のデータフロー追跡、コード意図の理解
- **GitHub ホスト リポジトリ対応**（公開ベータ時点では GitHub のみ）
- リポジトリ全体・サブディレクトリ単位・ブランチ指定スキャン（モノレポ対応）

#### 各 Finding に含まれる情報
- **Confidence rating**（信頼度スコア）
- **Severity**（High / Medium / Low、エクスプロイト容易性ベース）
- **Likely impact**（想定影響）
- **Reproduction path**（再現手順）
- **Affected files / line numbers**
- **Recommended patch**（修正案）

#### Multi-stage validation pipeline
- 各 finding は adversarial verification を経て初めて analyst に提示 → 既存 SAST ツール比で誤検知大幅削減を主張

### Claude Code 統合（重要）

> Users can open **Claude Code sessions** against the same repository context to develop patches after reviewing findings.

- Claude Security の finding から直接 Claude Code on Web セッションを起動し、同じリポジトリコンテキストで修正パッチを開発可能
- 「セキュリティチームと開発チーム間の何日もの ping-pong を 1 セッションで完結」を主張（Anthropic 公式メッセージ）

### 公開ベータ新機能（限定 RP からの追加点）

| 機能 | 詳細 |
|------|------|
| **Scheduled scans** | 週次など定期スキャン |
| **Documented dismissal** | dismiss 時の理由記録（監査証跡） |
| **CSV / Markdown export** | 監査・チケットシステム連携 |
| **Webhook integration** | Slack / Jira / カスタムへの finding push |
| **Triage tracking** | 進捗管理改善 |

### 早期実績

- 限定 RP 中に **数百組織**でテスト済み
- **production code** で実エクスプロイト検出
- 既存ツールが**長年見逃した脆弱性**を発見した事例多数（先代 Opus 4.6 ベースで 500+ vulnerabilities in production OSS, decades-undetected bugs）

#### 顧客引用（Snowflake）
> "Claude Security surfaced novel, high-quality findings...that helped us identify and address potential security issues" — Snowflake staff engineer

### パートナーエコシステム

#### Technology Partners（Opus 4.7 を自社製品に組み込み）
- **CrowdStrike**（Falcon Platform / Project QuiltWorks）
- **Microsoft Security**
- **Palo Alto Networks**
- **SentinelOne**
- **TrendAI**（Trend Micro 系）
- **Wiz**

#### Services Partners（顧客導入支援）
- **Accenture**
- **BCG**
- **Deloitte**
- **Infosys**
- **PwC**

→ 脆弱性管理・セキュアコードレビュー・インシデント対応プログラムでの統合導入を提供。

### Mythos との関係

- Claude Security は **Opus 4.7 駆動**（Mythos ではない）
- **Mythos Preview は Project Glasswing で限定配布継続**、一般組織は Claude Security を Enterprise 経由で利用
- Anthropic は「Mythos 級の能力にアクセスせずとも supervised vulnerability discovery を Enterprise アカウントで提供」というポジショニング

### 制限事項

- **GitHub ホスト リポジトリのみ**（GitLab / Bitbucket / self-hosted 対応は未発表）
- **Enterprise 限定**（Team / Max は "coming soon"、Pro は対象外）
- Opus 4.7 cyber safeguards によるブロック → 後述の Cyber Verification Program で対応

### 情報源
- [Claude Security 公式ページ](https://claude.com/product/claude-security)
- [Claude.com Blog - Claude Security in public beta](https://claude.com/blog/claude-security-public-beta)
- [SiliconANGLE - Anthropic announces Claude Security public beta (2026-04-30)](https://siliconangle.com/2026/04/30/anthropic-announces-claude-security-public-beta-find-fix-software-vulnerabilities/)
- [The New Stack - Claude Security emerges from closed preview (2026-04-30)](https://thenewstack.io/anthropics-claude-security-beta/)
- [SecurityWeek - Anthropic Unveils Claude Security](https://www.securityweek.com/anthropic-unveils-claude-security-to-counter-ai-powered-exploit-surge/)
- [Cyber Kendra - Claude Security Now Open to All Enterprise Users](https://www.cyberkendra.com/2026/04/anthropics-claude-security-is-now-open.html)
- [Implicator - Anthropic Opens Claude Security Beta](https://www.implicator.ai/anthropic-opens-claude-security-beta-as-mythos-access-fight-deepens/)
- [Inc. - Anthropic's Powerful New Cybersecurity Tool](https://www.inc.com/chloe-aiello/anthropics-powerful-new-cybersecurity-tool-is-designed-to-find-vulnerabilities-in-your-code-and-patch-them/91338485)
- [Business Standard - Claude Security beta for enterprise](https://www.business-standard.com/technology/tech-news/anthropic-announces-claude-security-beta-for-enterprise-customers-126050100019_1.html)
- [Heise Online (English) - Claude Security vulnerability scanner](https://www.heise.de/en/news/Claude-Security-Anthropic-launches-vulnerability-scanner-for-businesses-11279045.html)
- [Digital Today - Claude Security public beta](https://www.digitaltoday.co.kr/en/view/52333/anthropic-launches-claude-security-public-beta-to-detect-and-patch-software-vulnerabilities)

---

## ② Cyber Verification Program 受付開始（2026-04-30）✅ 受付開始

### 概要

Claude Security 公開ベータと同時発表。**Opus 4.7 の cyber safeguards に正当な防御目的のセキュリティ研究がブロックされる組織向けの vetting（資格認定）プログラム**。

### 対象ユーザー

- セキュリティリサーチャー
- ペネトレーションテスト実施者
- レッドチーミング従事者
- CTF チーム
- 脆弱性研究機関

### 仕組み

- **Opus 4.7 は cyber safeguards 内蔵**（4/16 GA リリース時から実装）— "prohibited or high-risk cybersecurity uses" を自動検出・ブロック
- 正当な防御目的研究もこの safeguards に引っかかる可能性 → vetting に通過すれば **restricted version（controlled access）** で継続利用可能
- TrendAI が Cyber Verification Program 第一弾参加発表（4/30 PRNewswire）

### 既知パートナー
- TrendAI（参加発表済み）
- 他の Technology Partners（CrowdStrike / Wiz など）も同枠での運用と推察

### 情報源
- [TrendAI™ and Anthropic Advance AI-Powered Vulnerability Detection (2026-04-30)](https://www.prnewswire.com/news-releases/trendai-and-anthropic-advance-ai-powered-vulnerability-detection-and-risk-mitigation-with-claude-opus-4-7--302759231.html)
- [CrowdStrike Puts Claude Opus 4.7 to Work Across Falcon Platform](https://www.crowdstrike.com/en-us/press-releases/crowdstrike-puts-claude-opus-4-7-to-work-across-falcon-platform-project-quiltworks/)
- [Palo Alto Networks - Enhancing AI-Driven Defense with Anthropic's Claude Opus 4.7](https://www.paloaltonetworks.com/blog/2026/04/ai-driven-defense-anthropics-claude-opus/)

---

## ③ Anthropic $50B/$900B 調達ラウンド協議中（2026-04-29 Bloomberg/TechCrunch スクープ）❓ 進行中

### スクープ内容

**Bloomberg と TechCrunch が同日（4/29）に独立スクープ**。Anthropic が **約 $40-50B 規模の新規調達ラウンド**を協議中、評価額は **$850-900B レンジ**。複数の preemptive offer を受領済み。

### 主要数値

| 項目 | 値 |
|------|---|
| ラウンド規模 | **$40-50B**（推定） |
| ポストマネー評価額 | **$850-900B** |
| 前回（2026-02）評価額 | $380B → **約 2.4 倍** |
| 取締役会決定予定 | **2026 年 5 月** |
| ARR（4 月時点） | **$30B+**（一部ソースは $40B 近辺） |
| エンタープライズ売上比率 | **約 80%** |
| OpenAI 比較（2026-02） | OpenAI ポストマネー $852B → Anthropic が抜く可能性 |
| 候補 IPO 時期 | **2026 年 10 月**（候補時期） |
| IPO 主幹事候補 | Goldman Sachs / JPMorgan / Morgan Stanley（早期協議中） |

### 投資家動向

- 1 機関投資家が **$5B コミット予定**で CFO Krishna Rao への面会待ち
- 需要が available allocation を大きく超過
- Anthropic は公式コメント拒否

### 成長ドライバー（Bloomberg/TechCrunch 分析）

1. **Claude Code / Cowork** が売上の主軸
2. **Mythos 関連需要**: 米連邦機関（NSA など）+ 12 創設パートナー + 40+ 重要インフラ組織からの需要が「substantially more compute」を要求
3. **Sonnet 4.6 / Opus 4.7 アダプション**
4. **大型エンタープライズ採用**: Freshfields（5,700 人）/ NEC（30,000 人）/ Goldman Sachs / Snowflake など

### Claude Code への含意

- Anthropic の評価額急騰は **Claude Code・Cowork の収益貢献度を裏付け**
- October 2026 IPO 候補の公表 → 4/13 TradingKey 報道（IPO 噂、$380B 目標）が大幅上方修正
- 4/22 The Register 報道「Pro 試験的 Claude Code 削除」「Pro Opus 4.7 セッション 3 倍化」が背景の Pro/Max プラン構成見直し圧力につながる可能性

### 情報源
- [Bloomberg - Anthropic Weighs Funding Offers at Over $900 Billion (2026-04-29)](https://www.bloomberg.com/news/articles/2026-04-29/anthropic-considering-funding-offers-at-over-900-billion-value)
- [TechCrunch - Sources: Anthropic could raise $50B at $900B (2026-04-29)](https://techcrunch.com/2026/04/29/sources-anthropic-could-raise-a-new-50b-round-at-a-valuation-of-900b/)
- [TheNextWeb - Anthropic eyes $900B valuation](https://thenextweb.com/news/anthropic-900-billion-valuation-funding-round)
- [The AI Insider - Anthropic Nears $50B Raise Ahead of Potential IPO](https://theaiinsider.tech/2026/04/30/anthropic-nears-50b-raise-at-up-to-900b-valuation-ahead-of-potential-ipo/)
- [TechFundingNews - From $380B to $900B](https://techfundingnews.com/anthropic-50b-round-900b-valuation-ipo-report/)
- [TechBriefly - $900B valuation funding round](https://techbriefly.com/2026/04/30/anthropic-eyes-900-billion-valuation-in-massive-new-funding-round/)

---

## ④ Layer 2 障害: 4/30 Major クラス障害

### claude.ai + API unavailable（2026-04-30 13:10 UTC〜）

- **検知**: 13:10 UTC（06:10 PT）「**claude.ai and API unavailable**」investigating ステータスへ
- **エラー期間**: 12:48 PT 開始（公式 status タイムラインから推定）
- **同時障害**: 14:01 UTC「**Elevated errors on Claude Haiku 4.5**」investigating 開始
- **重要度**: 🔴 Major Outage クラス（claude.ai + API 完全 unavailable は 4/15・4/28 と同等）
- **Claude Code 影響**: ログイン経路（Anthropic OAuth）依存のため Claude Code でも認証障害発生想定

### 4 月の障害頻度（5 件目の Major クラス）

| 日付 | 種別 | 影響 |
|------|------|------|
| 2026-04-15 | Major | claude.ai/API/Code 約 3 時間 |
| 2026-04-20 | Major | （登録済み） |
| 2026-04-25 | Major | Opus 4.7 連続障害 + claude.ai 障害 |
| 2026-04-28 | Major | claude.ai/API/Code 約 78 分（Downdetector 12,000 件超） |
| **2026-04-30** | **Major** | **claude.ai/API unavailable + Haiku 4.5 elevated errors** |

→ Partial / Elevated 含めると **4 月で 12 件超**。CoreWeave / Google-Broadcom TPU 拡張・$50B 調達でキャパシティ強化を進めるが、Freshfields（5,700 人）・NEC（30,000 人）など大規模エンタープライズデプロイの加速に追いついていない構造的供給逼迫が継続。

### 情報源
- [Claude Status](https://status.claude.com/)
- [DesignTAXI - Is Claude / Anthropic AI down? April 29, 2026](https://community.designtaxi.com/topic/27733-is-claude-anthropic-ai-down-april-29-2026)

---

## CURRENT_FEATURES.md 更新箇所

### 主要機能セクション
- **Claude Security**（新規追加 🧪）
  - Enterprise 公開ベータ、Team/Max coming soon
  - Opus 4.7 駆動、GitHub ホスト リポジトリ対応
  - **Claude Code on Web 統合**でパッチ開発に直接遷移
  - 旧 "Claude Code Security" RP（2026-02〜）の正式昇格
  - パートナー: CrowdStrike / Microsoft Security / Palo Alto Networks / SentinelOne / TrendAI / Wiz
- **Cyber Verification Program**（新規追加）
  - Opus 4.7 cyber safeguards に引っかかる正当な防御目的研究向け vetting

### ビジネス・市場セクション
- **Anthropic $50B/$900B 調達ラウンド協議中（2026-04-29）**
  - 評価額 $380B → $850-900B（2 月から約 2.4 倍）
  - 5 月取締役会決定見込み、10 月 IPO 候補
  - ARR $30B+、エンタープライズ 80%
  - IPO 主幹事候補: Goldman Sachs / JPMorgan / Morgan Stanley

### セキュリティインシデント / 障害セクション
- **2026-04-30 Major クラス障害** を追記

### 廃止予定・重要な変更スケジュール
- 変更なし（前回 4/30 で Sonnet 4.5/4 1M context beta retirement 反映済み）

---

## 結論

**新 CLI リリースなしのニュースモードだったが、3 件の重要発表 + 1 件の障害**を確認。

特に **Claude Security 公開ベータ開始**は、**Claude Code から派生した最初の独立製品（Claude Code Security RP → 公開ベータでブランド分離）**であり、Claude Code on Web との統合機能を持つため Claude Code エコシステムの直接的拡張として記録すべき。Enterprise 限定だが Team/Max への展開予定があり、当該プラン利用者にとって今後の追跡対象。

**$50B/$900B ラウンド**は財務シグナルだが、Claude Code の収益貢献度を市場が高く評価している証左であり、Pro プラン構成見直し（4/22 The Register 報道の Pro Opus 4.7 過負荷問題）の文脈と直結する。

次回調査では：
- Claude Security の Team/Max 展開発表
- $50B ラウンドの 5 月取締役会後の正式発表
- Cyber Verification Program 第二陣以降のパートナー
- Pro/Max プラン構成見直しの動向
- 新 CLI リリース（v2.1.124+）の有無

を重点監視。
