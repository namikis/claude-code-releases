# 2026-05-04 ニュースモード調査: Code with Claude SF 5/6 公式アナウンス済みと判明・5/6-5/7 ウェビナー連発

**調査モード:** ニュースモード（新 CLI リリースなし、v2.1.126 継続最新）
**調査日:** 2026-05-04
**対象期間:** 2026-05-03 〜 2026-05-04（前回 5/3 レポート以降）

---

## 概要

新 CLI リリースは 5/3〜5/4 に発生せず、`v2.1.126`（5/1 リリース）が引き続き最新。Layer 2（公式）と Layer 3（メディア）に絞った調査の結果、**前回（5/3）レポートで「❓ 噂・未確認」として記録していた「5/6 Anthropic Developer Event」が、実は 2026-03-18 に Anthropic 公式ブログで既にアナウンス済みのカンファレンス「Code with Claude」だった**ことが判明した。前回調査で `claude.com/code-with-claude` ドメインの公式告知を捕捉できず、メディア予測のみを根拠に「噂」扱いとしていたのを訂正する。

**同時に判明した追加情報：**

| 項目 | 内容 |
|------|------|
| **Code with Claude SF** | 5/6（水）8 AM–8 PM PT、Anthropic 開発者カンファレンス本体、In-person アプリ受付終了・Livestream 無料登録継続 |
| **Code with Claude: Extended SF** | 5/7（木）独立開発者・スタートアップファウンダー向けの companion event |
| **Claude for Nonprofits ウェビナー** | 5/6（水）10:00 AM PT、Projects/Skills/Connectors の grant writing デモ |
| **Claude for Financial Services ウェビナー** | 5/7（木）"Putting agents to work" |
| **The Briefing: Financial Services**（既出） | 5/5（火）11:00 AM EST、NYC livestream（前回レポート記載済み） |

**結論：5/5〜5/7 は Anthropic にとってイベント連発週で、5/6 SF キーノート（9–10 AM PT、Ami Vora CPO 登壇）は「live demos of new capabilities」が公式に予告されており、新製品・新機能発表の主要トリガーとなる蓋然性が高い。**

---

## 主要な訂正情報

### Code with Claude SF（5/6）— ❓ 噂 → 📢 公式予告へステータス変更

#### 発見の経緯

前回（5/3）レポートでは、NxCode / Fordel Pulse / AI Nexus Daily / Mfierce 等のメディアが「**5/6 に Anthropic developer event を予定**」「Sonnet 4.8 / Claude Jupiter 正式発表期待」と報じている件を、**公式 events ページに記載なし**として「❓ 噂・未確認」と整理していた。今回の Layer 2 詳細調査で：

- `claude.com/code-with-claude` および `claude.com/code-with-claude/san-francisco` の公式予告ページの存在を確認
- `claude.com/blog/code-with-claude-san-francisco-london-tokyo`（**2026-03-18 公式ブログエントリ**）で正式アナウンス済みであることを確認
- `anthropic.com/events` に "Code with Claude" の直接掲載はないが、Anthropic 公式ドメイン（`claude.com`）配下で詳細スケジュール・登壇者・トラック情報が公開されている

つまり**「噂」ではなく、約 1.5 ヶ月前から公式に予告されていた 3 都市開催の開発者カンファレンス**である。前回の判定は調査ソースの不備（claude.com 配下の events 系ページを確認せず anthropic.com/events だけで判定）に起因する誤りだった。

#### イベント詳細

**Code with Claude（Anthropic 開発者カンファレンス、3 都市開催）**

| 都市 | Main Day | Extended Day |
|------|---------|-------------|
| **San Francisco** | **2026-05-06（Wed）** | 2026-05-07（Thu） |
| London | 2026-05-19（Tue） | 2026-05-20（Wed） |
| Tokyo | 2026-06-10（Wed） | 2026-06-11（Thu） |

- **アナウンス日**: 2026-03-18（[Anthropic 公式ブログ](https://claude.com/blog/code-with-claude-san-francisco-london-tokyo)）
- **形式**: In-person + Livestream 配信併用、いずれも参加無料
- **登録**: In-person 申込は **2026 年 4 月初旬で締切済み**（ランダム選抜 → 通知）、**Livestream 登録は引き続きオープン**（[`claude.com/code-with-claude/register-livestream`](https://claude.com/code-with-claude/register-livestream)）
- **対象**: 「software developers, engineers, and technical leaders who are building with AI」、初学者から経験者まで
- **トラック**: 3 トラック構成
  1. **Research** — モデル能力・将来ロードマップ
  2. **Claude Platform** — production-grade agents の構築
  3. **Claude Code** — long-horizon タスク・multi-repo・並列エージェント・運用インフラ

#### San Francisco 5/6 詳細スケジュール（PT）

| 時間帯 | セッション |
|--------|----------|
| 9:00–10:00 AM | **Opening Keynote**（Anthropic Leadership 登壇） |
| 10:30 AM–12:30 PM | Morning Sessions（Claude Code / Platform / Research の各トラック） |
| 12:30 PM–2:00 PM | Lunch |
| 12:30 PM–6:15 PM | Afternoon Workshops & Talks |
| 5:45 PM–8:00 PM | Evening Reception |

**全体時間: 8:00 AM–8:00 PM PT**

#### 主要登壇者（Anthropic 側）

| 氏名 | 役職 |
|------|------|
| **Ami Vora** | Chief Product Officer（CPO）|
| **Boris Cherny** | Head of Claude Code |
| **Cat Wu** | Product Lead, Claude Code |
| **Angela Jiang** | Product Lead, Claude Platform |
| **Dianne Penn** | Head of Product, Research |

**外部スピーカー所属企業**: Netflix / GitHub / Datadog / Cursor / Vercel

#### 公式予告に含まれる「新機能発表」シグナル

- **「live demos of the latest capabilities」**（公式ブログ・ランディングページ双方で明記）
- **「demos of new capabilities and conversations with the teams behind Claude」**
- 3/18 アナウンス時点で「Check back in early April for a preview of the full agenda」と予告 → 4 月頭にアジェンダ詳細公開

つまり**新製品機能のライブデモは公式に予告されている**。何が発表されるかは未公開だが、文脈と Layer 3 の噂を踏まえると候補として：

| 候補 | 確度 | 根拠 |
|------|-----|------|
| **Sonnet 4.8 GA リリース** | ❓ 噂継続 | 3/31 ソースコードリーク内 `sonnet-4-8` 言及 + Opus 4.7 GA（4/16）からの 1〜4 週間遅れパターン → 5/6 がちょうど 3 週間後で適合 |
| **Claude Jupiter / 次世代 Sonnet クラスモデル** | ❓ 噂継続 | リーク内コードネーム `claude-jupiter` 言及、Discord/Threads 上の追加観測 |
| **KAIROS（常駐バックグラウンドエージェント）** | ❓ 噂継続 | リーク内に "always-on background agent" 機能フラグの存在確認、Anthropic 公式言及なし |
| **Computer Use の研究プレビュー → ベータ昇格** | ❓ 推測 | 現状 Pro/Max・macOS 限定の研究プレビュー、3 トラック中 Claude Platform 系で扱われる可能性 |
| **Routines（4/15 開始）の GA 化** | ❓ 推測 | 現状研究プレビュー、5/6 でステータス更新の可能性 |
| **Managed Agents 関連の新機能** | ❓ 推測 | 4/8 公開ベータ → 4/23 Memory 公開ベータ追加、Claude Platform トラック中心話題 |

**重要な留意点**: 5/6 で発表される具体的内容は現時点で未公開。「Sonnet 4.8 / Claude Jupiter」はあくまでリーク由来の予測で、Anthropic 自身は一切確認していない。

#### Layer 2 / Layer 3 整合の更新

前回（5/3）「❓ 5/6 Anthropic Developer Event」と「📢 5/5 The Briefing: Financial Services」は別イベントとして並列に整理していたが、**5/5〜5/7 は連続した Anthropic イベント週**として再整理すべき：

| 日付 | 時刻 | イベント | 確度 | 主催 |
|-----|------|---------|------|------|
| 5/5（火）| 11:00 AM EST | The Briefing: Financial Services | 📢 公式予告 | Anthropic（NYC livestream）|
| **5/6（水）**| **9:00 AM PT** | **Code with Claude SF（Main）**| **📢 公式予告**| **Anthropic（SF + livestream）**|
| 5/6（水）| 10:00 AM PT | Claude for Nonprofits ウェビナー | 📢 公式予告 | Anthropic |
| 5/7（木）| 終日 | Code with Claude: Extended SF | 📢 公式予告 | Anthropic |
| 5/7（木）| TBD | Claude for Financial Services: Putting agents to work | 📢 公式予告 | Anthropic |

**観測すべきポイント:**
- **5/5 Financial Services Briefing** は金融機関向けの「product capabilities and demos」予告 → IPO ロードショーの前哨戦
- **5/6 Code with Claude SF Keynote** は CPO Ami Vora 登壇のメインキーノート → **新製品発表のメインステージ**
- 同日 10:00 AM PT に並走する Nonprofits ウェビナーは**既存の Projects / Skills / Connectors を非開発者向けにデモ**する位置づけ（grant writing をワークフロー化）→ Code with Claude キーノートとは独立コンテンツ
- 5/7 は SF Extended（インディ開発者・スタートアップ向け）+ 金融セクター "agents" ウェビナーが並走 → SF はファウンダー向け実装フォーカス、金融はエージェント運用フォーカス

---

## 続報・継続案件

### Pentagon vs Anthropic / Mythos 周辺（5/3〜5/4 新展開なし）

5/3 レポート以降、5/4 までに次の点で新たな公的進展は確認されていない：

- Pentagon の 8 社 AI 契約（Google / OpenAI / Nvidia / Microsoft / AWS / SpaceX-xAI / Reflection / Oracle、Anthropic 除外）の追加報道なし
- Hegseth「ideological lunatic」発言（4/30）への Anthropic 公式反論なし（CBS News インタビュー素材は Amodei が以前から「retaliatory and punitive」と批判していた既出の文脈）
- White House による Mythos 拡大計画（50 → 120 社）ブロック（4/30 WSJ スクープ）の追加情報なし

**[Anthropic CEO Dario Amodei calls White House's actions "retaliatory and punitive" - CBS News](https://www.cbsnews.com/news/anthropic-ceo-dario-amodei-calls-white-house-actions-retaliatory-and-punitive/)** は既存の論調の継続。新規発言なし。

### Anthropic $50B 調達ラウンド（5/3〜5/4 新展開なし）

5/1 The AI Insider 報道「**$50B raise set to close within two weeks**」（評価額 $850-900B）以降、5/4 時点で取締役会決定の報道なし。**5 月の Anthropic 取締役会（時期未公表）**で正式決定が見込まれる。

### Sonnet 4.8 / Claude Jupiter リーク（変化なし）

Layer 3 メディアでは引き続き 3/31 ソースコードリークを根拠に Sonnet 4.8 / Claude Jupiter / KAIROS / Undercover Mode の予測記事が継続発信されているが、**Anthropic 公式の確認・否定は引き続きなし**。確度は ❓ 噂レベルのまま。

---

## Layer 1（チェンジログ）状況

ニュースモード調査のため Layer 1 はスキップ。参考情報として：

- `github.com/anthropics/claude-code/releases` の最新タグは `v2.1.126`（5/1）
- v2.1.124 / v2.1.125 は欠番（GitHub Releases 404、5/2 レポートで確認済み）
- 5/4 までに新リリースの報道なし

---

## 情報源一覧

### Layer 2: 公式

- [Code with Claude — Anthropic's Developer Conference（claude.com 公式）](https://claude.com/code-with-claude)
- [Code with Claude San Francisco — May 6, 2026（公式詳細）](https://claude.com/code-with-claude/san-francisco)
- [Code with Claude comes to San Francisco, London, and Tokyo（公式ブログ 2026-03-18）](https://claude.com/blog/code-with-claude-san-francisco-london-tokyo)
- [Register for Livestream — Code w/ Claude 2026](https://claude.com/code-with-claude/register-livestream)
- [Tokyo — Code w/ Claude 2026](https://claude.com/code-with-claude/tokyo)
- [Claude for Nonprofits: Moving Your Workflow Beyond Chat（5/6 ウェビナー公式）](https://www.anthropic.com/webinars/claude-for-nonprofits-moving-your-workflow-beyond-chat)
- [The Briefing: Financial Services（5/5 イベント公式）](https://www.anthropic.com/events/the-briefing-financial-services-virtual-event)
- [Anthropic Events（events 一覧）](https://www.anthropic.com/events)
- [Anthropic CEO Dario Amodei calls White House's actions "retaliatory and punitive" - CBS News](https://www.cbsnews.com/news/anthropic-ceo-dario-amodei-calls-white-house-actions-retaliatory-and-punitive/)

### Layer 3: メディア・コミュニティ

- [Anthropic Code with Claude SF 2026 - EventBrowse.com](https://eventbrowse.com/event/anthropic-code-with-claude-sf-2026/)
- [Code with Claude developer conference coming to San Francisco, London, and Tokyo in spring 2026（daily.dev）](https://app.daily.dev/posts/code-with-claude-developer-conference-coming-to-san-francisco-london-and-tokyo-in-spring-2026-drg8bi0va)
- [Code with Claude: Live Demos in San Francisco, London & Tokyo（gend.co）](https://www.gend.co/blog/code-with-claude-live-demos-san-francisco-london-tokyo)
- [TestingCatalog: Anthropic 3 developer conferences（X/Twitter）](https://x.com/testingcatalog/status/2034426076663828529)
- [Claude Sonnet 4.8: Release Date, Features & What to Expect（NxCode 続報）](https://www.nxcode.io/resources/news/claude-sonnet-4-8-release-date-features-what-to-expect-2026)
- [Anthropic's $50B Round Set to Close Within Two Weeks（The AI Insider 5/1）](https://theaiinsider.tech/2026/05/01/anthropics-50b-round-set-to-close-within-two-weeks-as-valuation-nears-900b/)

---

## 更新サマリー（CURRENT_FEATURES.md への反映）

1. 「予定・未確認情報」セクションの **「Anthropic Developer Event（5/6 予測）❓」を「Code with Claude SF（5/6 公式）📢」へステータス変更**（噂 → 公式予告）し、3 都市開催・登壇者・タイムテーブル・トラック情報を追記
2. 同セクションに **「Code with Claude: Extended SF（5/7）📢」「Claude for Nonprofits ウェビナー（5/6）📢」「Claude for Financial Services: Putting agents to work（5/7）📢」を新規追加**
3. 既存の「The Briefing: Financial Services（5/5）📢」と合わせて **「2026-05-05〜05-07 Anthropic イベント週」として再整理**
4. Sonnet 4.8 / Claude Jupiter 関連は引き続き ❓ 噂レベルのまま維持（5/6 キーノートで動きがあれば次回更新）
5. 最終更新日を 2026-05-04 に更新、更新履歴に本調査エントリを追加
