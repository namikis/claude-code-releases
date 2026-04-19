# Claude Code 調査レポート: NSAがMythosを利用中の報道 & 連邦機関Mythos運用実態

**調査日:** 2026-04-20
**調査モード:** ニュースモード（Layer 2 + Layer 3 のみ）
**対象期間:** 2026-04-19〜2026-04-20（前回 2026-04-19 レポート以降の差分）

---

## 概要

新CLIリリースは前日 v2.1.114（4月18日）以降なし。Layer 2（公式ブログ・APIドキュメント）でも新規発表はなし。

一方、Layer 3（ニュースメディア）では **2026年4月19日のAxiosスクープ**「NSA using Anthropic's Mythos despite Defense Department blacklist（NSA、国防総省のブラックリスト指定にもかかわらずAnthropic Mythosを利用中）」が報じられ、Reuters / Yahoo Finance / Investing.com / Trending Topics 等がこれを転載。**Pentagon（国防総省）とその傘下機関であるNSAが同じAnthropicに対して正反対の扱いを取っている構造的矛盾**が明らかになった。

前回レポート（2026-04-18・2026-04-19）で「ホワイトハウスが米連邦機関にMythosアクセス認可」までは把握していたが、今回の Axios スクープは **NSA が既に実利用フェーズに入っている**ことを示す点で前進がある。

また 2026-04-18 付の RedState 報道も合わせ、**連邦政府内の「Anthropic blacklist policy vs. agency-level Mythos adoption」二重構造**の具体的な機関名（商務省 AI標準化イノベーションセンター、エネルギー省、財務省の金融システム保護部門、CISA）がより詳細に判明した。

Claude Code/Claude製品の直接的な機能変更はないが、**エンタープライズ・政府調達を検討中の顧客にとっては**、Anthropicの政府利用ステータスが事実上 "de facto 解禁" 方向に進んでいる状況シグナルとして重要。

---

## Layer 2: プラットフォーム・公式発表

### 新規発表なし

- [Claude Platform Release Notes](https://platform.claude.com/docs/en/release-notes/overview): 最新エントリは 2026-04-16 の **Opus 4.7 GA** と **Claude in Amazon Bedrock 全顧客解放** で、4月19日・20日の新規エントリはなし
- [Claude Help Center Release Notes](https://support.claude.com/en/articles/12138966-release-notes): 直近の更新は 2026-04-18 の Claude Design ヘルプ記事公開（前回レポート済み）
- [Anthropic 公式ニュース](https://www.anthropic.com/news): 4月17日の Claude Design、4月16日の Opus 4.7、4月14日の Vas Narasimhan 取締役就任・Google/Broadcom コンピュート提携拡大以降、4月18〜20日の新規エントリなし
- CHANGELOG.md / GitHub Releases: v2.1.114（4月18日）以降の新リリースなし

### 4月23日（3日後）: API デフォルトモデル切替 — 引き続き予定通り 📢 → ✅予定

- Enterprise pay-as-you-go および Anthropic API（第一者）で `opus` エイリアスが **Opus 4.6 → Opus 4.7** へ自動切替
- 本日時点で Anthropic からの計画変更アナウンスなし
- モデルIDピンニングを行っていない本番API利用者は今週中に事前検証推奨
- Haiku 3 API リタイア（4月19日発効）とあわせ、**同じ週で2つのモデルIDレベル変更が重なる**点に注意

---

## Layer 3: ニュースメディア

### 1. Axios スクープ（2026-04-19）: NSAがMythosを利用中 🔴重要

**見出し**: [Scoop: NSA using Anthropic's Mythos despite Defense Department blacklist](https://www.axios.com/2026/04/19/nsa-anthropic-mythos-pentagon)

#### 主要事実

| 項目 | 内容 |
|------|------|
| **利用機関** | **米国国家安全保障局（NSA）** |
| **利用モデル** | **Claude Mythos Preview**（Project Glasswing限定） |
| **主な用途** | NSA自身の環境・インフラに対する**セキュリティ脆弱性スキャン** |
| **ステータス** | 既にアクセス権を取得し**実利用中**（評価段階ではなく運用フェーズと報じられる） |
| **Pentagonの立場** | 2026年2月にAnthropicをサプライチェーンリスク指定、配下のベンダーにも関係回避を要求。NSAはその Pentagon の**直接的な傘下機関**（組織的矛盾） |
| **Anthropic側コメント** | 直接コメントはないが、Amodei CEOが2026-04-17にホワイトハウス（Wiles首席補佐官・Bessent財務長官）と「productive」な会談を行った文脈 |

#### なぜ重要か

- **Pentagonが管理する情報機関（NSA）が、Pentagonのブラックリスト対象企業と取引している**という構造的矛盾を初めて明確に示した報道
- Pentagon は「大量国内監視 + 自律兵器利用」を要求 → Anthropic が拒否 → ブラックリスト指定、という紛争構造に対し、NSAは **Mythosを防御的サイバーセキュリティ用途**で使っているため、Anthropicの "red line" ポリシー内で利用可能
- 裁判所の差止命令（3月26日）と控訴（4月2日）で宙吊り状態の法的係争中、**行政府内で事実上の "de facto 解禁"** が進行していることを示す
- Claude/Mythosの**国家顧客に対する販売チャネル拡大**の先例に

#### Trending Topics（4月19日）による追加情報

[NSA Already Uses Anthropic's Most Powerful AI Model "Mythos" Despite Pentagon Ban](https://www.trendingtopics.eu/nsa-already-uses-anthropics-most-powerful-ai-model-myhtos-despite-pentagon-ban/)

- Project Glasswing を通じて**約40組織**がMythosアクセス権を取得済み
- 公式パートナー12社（AWS、Apple、Broadcom、Cisco、CrowdStrike、Google、JPMorganChase、Linux Foundation、Microsoft、NVIDIA、Palo Alto Networks）に加え、**英MI5（情報局保安部）が英国AI安全研究所（UK AISI）経由でアクセスを取得**
- MI5 は英国AISI のMythos評価（4月14日公開、CTF 73%成功率・TLOシミュレーション完走）を介したセカンダリアクセスと報じられる

### 2. RedState（2026-04-18）: 連邦機関がブラックリストを迂回 🟡補足

**見出し**: [The Pentagon Blacklisted Anthropic. Federal Agencies Are Using It Anyway](https://redstate.com/ben-smith/2026/04/18/pentagon-blacklisted-anthropic-federal-agencies-are-using-it-anyway-n2201421)

#### 行政府内の利用機関

RedState の報道で明示された、Pentagon のブラックリスト指定にもかかわらずAnthropic/Mythosを評価・利用中の米連邦機関：

| 機関 | 用途 |
|------|------|
| **商務省（DOC）配下 AI標準化イノベーションセンター** | Mythos モデルを積極的に**評価中** |
| **エネルギー省（DOE）** | エネルギーシステム（電力グリッド等）保護のための脆弱性検出評価 |
| **財務省金融システム保護部門** | 金融インフラ保護のための脆弱性検出評価 |
| **CISA（サイバーセキュリティ・インフラ安全保障庁）** | 国家サイバーセキュリティ目的での評価 |
| **ホワイトハウス** | 民間機関全体への展開についてAnthropicと交渉中 |

#### 要点

> "政策は一つのことを述べているが、システムはすでに別のことを行っている"（Pentagon policy says one thing, the system is already doing another）

行政府と文民機関が Pentagon の指定を実質的に迂回している構造。控訴審の判決次第で解消される可能性があるが、短期的には**連邦機関のAnthropicツール利用は拡大方向**。

### 3. Bloomberg / Axios / CSO Online（4月17日）の続報（参照のみ）

前回レポート（2026-04-18 分）で詳細を扱い済み：

- Axios（4/17）: [Peace talks at White House](https://www.axios.com/2026/04/17/anthropic-trump-administration-mythos)
- Axios（4/17）: [Bessent and Wiles met Anthropic's Amodei in sign of thaw](https://www.axios.com/2026/04/17/anthropic-white-house-wiles-bessent-amodei)
- CNBC（4/17）: [Anthropic's Dario Amodei meets with White House about Mythos](https://www.cnbc.com/2026/04/17/anthropic-dario-amodei-trump-mythos.html)
- CNN Business（4/17）: [CEO of blacklisted Anthropic and White House hold 'productive' discussions on AI](https://www.cnn.com/2026/04/17/business/anthropic-white-house-meeting-dario-amodei)

### 4. 業界動向（Claude Code 直接関連、参照のみ）

- [Hackaday（4/19）: "Can Claude Write Z80 Assembly Code?"](https://hackaday.com/2026/04/19/can-claude-write-z80-assembly-code/) — レトロコンピューティング領域における Claude Code の実用性検証記事。機能変更ではなくエコシステム話題
- GitHub Issues: 4月19日に #50933（tools/tui 領域の enhancement）、#50932（hooks 領域の enhancement）を含む複数の機能要望・バグ報告が新規起票。**v2.1.115 以降での対応観測用**

---

## リリース一覧

新CLIリリースなし（前回の v2.1.114〔4月18日〕から未更新）。

---

## 確度と影響度まとめ

| 項目 | 確度 | 影響度 | 備考 |
|------|------|-------|------|
| Axios スクープ: NSA による Mythos 利用 | 📰 Layer 3 スクープ | 🟡 中 | Anthropic の政府 "de facto 解禁" シグナル、エンタープライズ調達判断材料に |
| 連邦機関のMythos評価（商務省AISI、DOE、財務省、CISA） | 📰 Layer 3 複数報道 | 🟡 中 | Pentagon ブラックリスト係争中も並行で評価進行 |
| MI5（英国）のUK AISI 経由アクセス | 📰 Layer 3 報道 | 🟢 小 | 英国側での Mythos 利用拡大の兆候 |
| 4月23日 API デフォルトモデル切替 | 📢 発表 → ✅ 予定（3日後） | 🔴 大 | 本番APIでモデルピン未設定なら必ず事前検証 |

---

## 情報源一覧

### Layer 2（プラットフォーム・公式）
- [Claude Platform Release Notes](https://platform.claude.com/docs/en/release-notes/overview) — 新規エントリなし
- [Claude Help Center Release Notes](https://support.claude.com/en/articles/12138966-release-notes) — 新規エントリなし
- [Anthropic 公式ニュース](https://www.anthropic.com/news) — 新規エントリなし

### Layer 3（ニュースメディア・コミュニティ）
- **[Axios - Scoop: NSA using Anthropic's Mythos despite Defense Department blacklist (2026-04-19)](https://www.axios.com/2026/04/19/nsa-anthropic-mythos-pentagon)**（主要スクープ）
- [Yahoo Finance / Reuters - US security agency is using Anthropic's Mythos despite blacklist, Axios reports](https://finance.yahoo.com/news/us-security-agency-using-anthropics-181218592.html)
- [Investing.com / Reuters mirror](https://www.investing.com/news/stock-market-news/us-security-agency-is-using-anthropics-mythos-despite-blacklist-axios-reports-4622241)
- [SRN News - US security agency is using Anthropic's Mythos despite blacklist](https://srnnews.com/us-security-agency-is-using-anthropics-mythos-despite-blacklist-axios-reports/)
- [Trending Topics - NSA Already Uses Anthropic's Most Powerful AI Model "Mythos" Despite Pentagon Ban](https://www.trendingtopics.eu/nsa-already-uses-anthropics-most-powerful-ai-model-myhtos-despite-pentagon-ban/)
- [RedState - The Pentagon Blacklisted Anthropic. Federal Agencies Are Using It Anyway (2026-04-18)](https://redstate.com/ben-smith/2026/04/18/pentagon-blacklisted-anthropic-federal-agencies-are-using-it-anyway-n2201421)
- [Hackaday - Can Claude Write Z80 Assembly Code? (2026-04-19)](https://hackaday.com/2026/04/19/can-claude-write-z80-assembly-code/)

### 関連（前回までに扱い済み、文脈用）
- [Axios - Peace talks at White House (2026-04-17)](https://www.axios.com/2026/04/17/anthropic-trump-administration-mythos)
- [Axios - Bessent and Wiles met Anthropic's Amodei (2026-04-17)](https://www.axios.com/2026/04/17/anthropic-white-house-wiles-bessent-amodei)
- [CNBC - Anthropic's Dario Amodei meets with White House about Mythos (2026-04-17)](https://www.cnbc.com/2026/04/17/anthropic-dario-amodei-trump-mythos.html)
- [CNN Business - CEO of blacklisted Anthropic and White House hold 'productive' discussions (2026-04-17)](https://www.cnn.com/2026/04/17/business/anthropic-white-house-meeting-dario-amodei)
