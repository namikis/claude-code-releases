# 調査レポート: Project Glasswing 初回アップデート（Mythos Preview で 10,000+ 脆弱性）& Mythos が Claude Code / Claude Security に統合の兆候

**調査日:** 2026-05-25
**調査モード:** ニュースモード（新 CLI リリースなし、v2.1.150 が継続最新。Layer 1 = チェンジログはスキップ。Layer 2 公式ブログ・API ドキュメント / Layer 3 ニュースメディアのみ調査）

## 概要

前回レポート（5/21〜5/23、v2.1.146-150 + Compliance API GA + $30B クローズスクープ）以降、**新規 CLI リリースはなし**（v2.1.150 が継続最新）。Layer 2・3 から **2 件の新情報**を確認した。

1. **Project Glasswing 初回アップデート（5/22 公式 research blog）** ✅ — Anthropic と約 50 パートナーが **Claude Mythos Preview** を用いて、稼働 1 ヶ月で **10,000 件超の高/重大深刻度脆弱性**を発見。wolfSSL の証明書偽造エクスプロイト（CVE-2026-5194、パッチ済み）、Cloudflare 2,000 件・Mozilla Firefox 150 で 271 件（Opus 4.6 比 10 倍超）などの具体例を公表。**Mythos-class モデルの「general release（一般リリース）」へ向かう意向**を初めて明示した（ただし「十分なセーフガードが未確立」として現状は限定配布継続）。
2. **Mythos が Claude Code / Claude Security に統合される兆候（5/23 testingcatalog リーク）** ❓ — ソースコード文字列 "Access to the Claude Mythos model in Claude Code and Claude Security"、`claude-mythos-1-preview` のクラウド痕跡、UI への "Mythos 1" 一時表示、Claude Security の新エンタープライズダッシュボード、**Claude Opus 4.8 の内部評価**の噂を報告。①の公式「general release 意向」と整合する。

なお **$30B / $900B 評価額の資金調達ラウンド**は 5/25 時点でも Bloomberg「来週クローズ可能性」（5/22 報道）から進展なく、正式クローズ未確認のため確度に変化なし（既出・ステータス据え置き）。

---

## 詳細

### 1. Project Glasswing: An initial update（5/22 公式） ✅

Anthropic が 2026-05-22 に research blog で Project Glasswing の初回進捗レポートを公開（出典: [Anthropic Research - Glasswing initial update](https://www.anthropic.com/research/glasswing-initial-update)）。Project Glasswing は 2026-04-07 に発表された重要インフラソフトウェアの脆弱性発見イニシアチブで、**Claude Mythos Preview**（招待制・防御的サイバーセキュリティ用途限定の研究プレビュー）を約 50 のトラステッドパートナーに配布している。

**稼働 1 ヶ月の成果:**

- 約 50 パートナーが **合計 10,000 件超の高/重大深刻度脆弱性**を、世界で最もシステム上重要なソフトウェア群から発見
- 多くのパートナーがそれぞれ数百件の重大/高深刻度脆弱性を発見、一部は **バグ発見レートが従来比 10 倍超**に向上
- **オープンソース**については、Mythos Preview が 1,000+ プロジェクトで **約 6,202 件の高/重大深刻度脆弱性**を特定、うち **1,587 件が有効な true positive として確認**（Benzinga は「レビュー時点で 90.6% が正当と確認」と報道）

**具体的な発見例:**

- **wolfSSL**（数十億台のデバイスで使われる暗号ライブラリ）: Mythos Preview が **証明書偽造による資格情報窃取攻撃**を可能にするエクスプロイトを構築。**CVE-2026-5194** として採番・パッチ済み（出典: [Cryptobriefing](https://cryptobriefing.com/anthropic-glasswing-software-vulnerabilities/) / [Interesting Engineering](https://interestingengineering.com/ai-robotics/anthropic-project-glasswing-10000-software-vulnerabilities)）
- **Cloudflare**: critical-path システム全体で **2,000 件のバグ**（うち 400 件が高/重大深刻度）を発見、誤検知率は「人間のテスターより良い」と Cloudflare チームが評価
- **Mozilla**: **Firefox 150 で 271 件**の脆弱性を発見、以前の Claude Opus（4.6）でのテストより 10 倍超の改善

**Claude Security との連携:** Anthropic は Claude Security を Enterprise 向け公開ベータでリリース済みで、同製品は **3 週間で 2,100 件超の脆弱性をパッチ**したと報告。正当なセキュリティ研究者向けに **Cyber Verification Program** も運用。

**Mythos モデルの提供方針（重要な変化）:** アップデートは「**no company—including Anthropic—has developed safeguards strong enough to prevent such models from being misused**（Anthropic を含むどの企業も、こうしたモデルの誤用を防ぐ十分なセーフガードを未確立）」とし、Mythos Preview は限定配布を継続するとしつつ、「**once we've developed the far stronger safeguards we need**, Mythos-class models will become available through general release（必要なはるかに強固なセーフガードを確立できたら、Mythos クラスのモデルを一般リリースで提供する）」と **GA への意向を初めて明示**。具体的時期は示されていない。

**今後の拡大:** Project Glasswing のパートナーシップを **米国および同盟国の政府**やその他の重要インフラ運営者に拡大する計画。

**示唆:** 「脆弱性発見の速度が制約だった時代から、いまや**検証・開示・パッチ適用の人的ワークロード**が制約になった」とフレーミングを転換。

> 出典: [Anthropic Research - Glasswing initial update](https://www.anthropic.com/research/glasswing-initial-update) / [Benzinga](https://www.benzinga.com/markets/private-markets/26/05/52759147/anthropics-project-glasswing-finds-more-than-10000-critical-bugs-expands-to-additional-pa) / [Dataconomy（5/25）](https://dataconomy.com/2026/05/25/project-glasswing-mythos-10000-software-flaws/) / [Hypertext](https://htxt.co.za/2026/05/first-month-of-project-glasswing-uncovered-10k-plus-critical-vulnerabilities/)

### 2. Mythos が Claude Code / Claude Security に統合される兆候（5/23 testingcatalog リーク） ❓

testingcatalog が 2026-05-23 に、Anthropic が **Mythos 1** を Claude Code および Claude Security 製品を通じて**より広く提供する準備**を進めていると報じた（出典: [testingcatalog](https://www.testingcatalog.com/anthropic-prepares-mythos-1-for-claude-code-and-claude-security/)）。

**リーク・痕跡レベルの証拠:**

- **ソースコード文字列**: "**Access to the Claude Mythos model in Claude Code and Claude Security**" — Mythos が Claude Code 内から利用可能になる可能性を示唆
- **クラウド痕跡**: `claude-mythos-1-preview` のモデルトレースが Google Cloud / AWS の脆弱性発見プログラム上で観測
- **UI 表示**: 一部ユーザーに **"Mythos 1"** が UI へ一時的に表示された
- **Claude Security の新ダッシュボード**: エンタープライズ顧客向けに脆弱性発見表示・**7 日/30 日のヒストリカルチャート**・強化されたトリアージ結果を備えた新ダッシュボードを構築中
- **Claude Opus 4.8**: 選抜パートナーと内部評価中との噂、近い将来のリリースを示唆

**評価:** これらは公式発表ではなくリーク・コード痕跡レベル（❓ 噂・未確認）。ただし、**5/22 の公式 Glasswing アップデートが「Mythos クラスの general release 意向」を明示した**ことと方向性が一致しており、Mythos の Claude Code / Claude Security 統合は「いずれ」のレベルでは公式の意向と整合する。Claude Code 利用者にとっては、防御的サイバーセキュリティ用途で Mythos クラスモデルへアクセスできる経路が将来的に開く可能性を示すシグナル。Opus 4.8 はリーク段階で公式情報なし。

### 3. $30B / $900B 資金調達ラウンド（5/25 時点ステータス）— 変化なし

5/22 Bloomberg「Anthropic to Close Over $30 Billion Round as Soon as Next Week」以降、5/25 時点で**正式クローズの確認報道はなし**。Sequoia / Dragoneer / Altimeter / Greenoaks 各 $2B co-lead、$900B 評価額（OpenAI $852B 超え世界最高評価額 AI スタートアップへ）、Founders Fund / General Catalyst 参加見込みという内容に変化なし。Amodei は「Q1 で年率換算売上・利用が 80x 成長」「Q2 売上は $10.9B 見込み・初の黒字四半期へ」と発言（出典: [Bloomberg（5/22）](https://www.bloomberg.com/news/articles/2026-05-22/anthropic-to-close-over-30-billion-round-as-soon-as-next-week) / [Yahoo Finance](https://finance.yahoo.com/sectors/technology/articles/anthropic-set-close-30-billion-203545596.html)）。**CURRENT_FEATURES.md の既存「Anthropic IPO 計画 + $30B/$900B」項目で既出のため、確度・記載に変更なし。**

---

## 結論

- **新規 CLI リリースはなし**（v2.1.150 継続）。Layer 1 はスキップ済み。
- **Layer 2 の新情報**: Project Glasswing 初回アップデート（5/22 公式）は ✅ 確定。Claude Code エコシステムにとっては、Mythos クラスモデルの **general release 意向の初表明**が最も重要なシグナル。
- **Layer 3 の新情報**: Mythos が Claude Code / Claude Security に統合される兆候（5/23 testingcatalog リーク）は ❓。Opus 4.8 内部評価も ❓。公式 GA 意向と整合する点で監視価値が高い。
- CURRENT_FEATURES.md を更新（Project Glasswing 進捗を Mythos Preview セクションに反映 + 予定・未確認情報に「Mythos の Claude Code / Claude Security 統合」「Opus 4.8」を新規追加）。

## 情報源一覧

- [Anthropic Research - Project Glasswing: An initial update](https://www.anthropic.com/research/glasswing-initial-update)（公式、5/22）
- [Anthropic - Project Glasswing](https://www.anthropic.com/glasswing)（公式・概要）
- [testingcatalog - Anthropic prepares Mythos 1 for Claude Code and Claude Security](https://www.testingcatalog.com/anthropic-prepares-mythos-1-for-claude-code-and-claude-security/)（リーク、5/23）
- [Benzinga - Project Glasswing Finds 'More Than 10,000' Critical Bugs, Expands To Additional Partners](https://www.benzinga.com/markets/private-markets/26/05/52759147/anthropics-project-glasswing-finds-more-than-10000-critical-bugs-expands-to-additional-pa)
- [Dataconomy - Project Glasswing Mythos 10000 software flaws（5/25）](https://dataconomy.com/2026/05/25/project-glasswing-mythos-10000-software-flaws/)
- [Interesting Engineering - Claude found 10,000 critical software flaws in a month](https://interestingengineering.com/ai-robotics/anthropic-project-glasswing-10000-software-vulnerabilities)
- [Cryptobriefing - Project Glasswing uncovers over 10,000 software vulnerabilities](https://cryptobriefing.com/anthropic-glasswing-software-vulnerabilities/)
- [Hypertext - First month of Project Glasswing uncovered 10k-plus critical vulnerabilities](https://htxt.co.za/2026/05/first-month-of-project-glasswing-uncovered-10k-plus-critical-vulnerabilities/)
- [Bloomberg - Anthropic to Close Over $30 Billion Round as Soon as Next Week（5/22）](https://www.bloomberg.com/news/articles/2026-05-22/anthropic-to-close-over-30-billion-round-as-soon-as-next-week)
- [Yahoo Finance - Anthropic set to close $30 billion funding at over $900 billion valuation](https://finance.yahoo.com/sectors/technology/articles/anthropic-set-close-30-billion-203545596.html)

## スキップしたURL

| URL | スキップ理由 |
|-----|------------|
| quasa.io / aitoolly.com / aithinkerlab.com | 二次まとめ系・実績不明ドメイン。公式 + 著名メディアで一次情報を確認済みのため不採用 |
