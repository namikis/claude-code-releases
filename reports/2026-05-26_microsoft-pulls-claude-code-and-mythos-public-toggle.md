# 調査レポート: Microsoft が主要製品チームから Claude Code を撤収（6/30 期限、Copilot CLI 移行）& Mythos トグルが公開版 Claude Code に一時出現（BleepingComputer 裏付け）

**調査日:** 2026-05-26
**調査モード:** ニュースモード（新規 CLI リリースなし、v2.1.150 が継続最新。Layer 1 = チェンジログはスキップ。Layer 2 公式ブログ・API ドキュメント / Layer 3 ニュースメディアのみ調査）

## 概要

前回レポート（5/25、Project Glasswing 初回アップデート + Mythos→Claude Code リーク）以降、**新規 CLI リリースはなし**（v2.1.150 が継続最新）。Layer 2・3 から **2 件の新情報 + 1 件の確度補強**を確認した。

1. **Microsoft が Claude Code を主要製品チームから撤収（✅ 確認済み、Layer 3）** — Microsoft の **Experiences + Devices グループ**（Windows / Microsoft 365 / Outlook / Teams / Surface を開発）が **2026 年 6 月 30 日**（同社会計年度末）までに Claude Code の利用を停止し、**GitHub Copilot CLI** へ移行するよう指示された。EVP Rajesh Jha のコメントあり。当初の報道は 5/15（winbuzzer）だが、5/24-25 に The Next Web / Windows Central / The Decoder 等が**公式コメント込みで二次的に広く報道**。**当リポジトリ未記載のため新規計上**。
2. **Mythos トグルが公開版 Claude Code に一時出現（❓ → 確度補強、Layer 3）** — 5/23 の testingcatalog リーク（ソースコード文字列のみ）に続き、**5/25 に BleepingComputer**（主流セキュリティメディア）が報道。一部ユーザーの**公開版 Claude Code / Claude Security に `claude-mythos-1-preview` を有効化するトグルが一時的に出現**し、その後削除されたことを確認。単一リーク → 複数ソース + 実 UI 痕跡へと確度が向上（ただし依然 ❓ 公式発表なし）。
3. **Claude Code サンドボックスバイパスの silent パッチ（5/20 SecurityWeek、Layer 3 セキュリティ）** — Anthropic が Claude Code のネットワーク egress フィルタを回避できる 2 件のサンドボックスバイパスを**告知なく修正**していたと SecurityWeek が 5/20 に開示。既に過去の 2.1.x で修正済みの回顧的開示。

なお **$30B / $900B 資金調達ラウンド**は 5/26 時点でも**正式クローズの確認報道なし**（「来週クローズ可能性」5/22 Bloomberg から進展なし）。確度・記載に変化なし（既出・据え置き）。

---

## 詳細

### 1. Microsoft が Claude Code を主要製品チームから撤収（6/30 期限、Copilot CLI 移行） ✅

複数メディアが、Microsoft が社内の **Experiences + Devices（E+D）グループ**で配布していた **Claude Code のライセンスを取り消し**、**GitHub Copilot CLI** への移行を指示したと報じた（出典: [The Next Web（5/25）](https://thenextweb.com/news/microsoft-claude-code-retreat-ai-cost) / [Windows Central（5/24-25）](https://www.windowscentral.com/microsoft/microsoft-cancels-claude-code-licenses-shifting-developers-to-github-copilot-cli-a-move-likely-driven-by-financial-motives) / [The Decoder](https://the-decoder.com/microsoft-pulls-claude-code-licenses-and-pushes-developers-back-toward-its-own-ai-tool/) / [winbuzzer（初報 5/15）](https://winbuzzer.com/2026/05/15/microsoft-starts-canceling-claude-code-licenses-xcxwbn/)）。

**事実関係:**

- **対象部門**: Experiences + Devices グループ（**Windows / Microsoft 365 / Outlook / Teams / Surface** を開発する中核部門）
- **期限**: **2026 年 6 月 30 日**（Microsoft の会計年度末）。エンジニアは数週間以内に Copilot CLI へ移行するよう通達
- **経緯**: Claude Code は 2025 年 12 月（一部報道では 2026 年 1 月に E+D 全体）に社内へ広く展開され、約半年で**社内の Microsoft 純正 AI コーディングツールを押しのけるほど人気化**していた
- **撤収理由（公式）**: ツールチェーンの統一。EVP（experiences and devices group VP）**Rajesh Jha** のコメント: 「Copilot CLI と Claude Code の両方を提供した目的は、実際のエンジニアリングワークフローで素早く学び、ベンチマークすることだった。Claude Code はその学びの重要な一部だった……同時に Copilot CLI は、GitHub と共に Microsoft のリポジトリ・ワークフロー・セキュリティ要件・エンジニアリングニーズに合わせて**直接形作れる製品**という、特に重要なものをもたらした」
- **撤収理由（実態分析）**: メディアは**コスト構造**を主因と分析。トークンベース課金が、エンジニアが常時 agentic コード生成を使う実利用パターンに対して予算超過を招く構図。会計年度末の 6/30 でライセンスを切ることで運用コストを削減できる

**Claude Code への含意 / 限定事項:**

- これは **Anthropic との関係終了ではない**。Claude モデルは **Copilot CLI 経由で引き続き利用可能**、消費者向け Copilot / Microsoft 365 機能でも Claude を提供継続。**Microsoft Foundry の Anthropic 契約**および **Cowork 連携も影響なし**（出典: Windows Central / The Decoder）
- 「ツールが悪いのではなく、**良すぎて常用され、その常用がトークン経済を破綻させる**」という、5/14 レポートで扱った **ServiceNow / Uber の年間 AI 予算枯渇報道**および 6/15 のサブスクリプション課金構造変更と同一の論点。エンタープライズ AI コーディングのユニットエコノミクス論争の代表事例として注目度が高い

> 評価: ✅ 確認済み（公式コメントあり）。Layer 3 のエンタープライズ採用動向ニュース。初報は 5/15 だが当リポジトリ未記載で、5/24-25 に公式コメント込みで再拡散したため今回計上。

### 2. Mythos トグルが公開版 Claude Code に一時出現（BleepingComputer 裏付け） ❓（確度補強）

5/23 の testingcatalog リーク（「予定・未確認情報」で既出）に続き、**2026 年 5 月 25 日に BleepingComputer** が、Anthropic が制限付きモデル **Mythos** の Claude Code / Claude Security への展開準備を進めているとみられると報道（出典: [BleepingComputer（5/25）](https://www.bleepingcomputer.com/news/artificial-intelligence/anthropics-restricted-claude-mythos-model-may-be-coming-to-claude-code/)）。

**新たに判明した点（5/23 リークからの進展）:**

- **公開版 Claude Code に実トグルが一時出現**: 一部ユーザーが、**公開版（public version）の Claude Code で Mythos を有効化するトグル**を一時的に確認。**`claude-mythos-1-preview`** というモデル名が、削除される前に表示された。Claude Security 側でも同様にトグルが出現
- **依然 ❓ 公式発表なし**: 全サブスクリプション層で利用可能になるか、明確なリリース日とも**不明**。Mythos が初月で 10,000 件超の高/重大深刻度脆弱性を発見できる能力（5/22 Glasswing アップデート）ゆえに、Anthropic は公開リリースを慎重に遅らせていると BleepingComputer は分析

**評価:** 5/23 はソースコード文字列・クラウド痕跡レベル（単一リーク媒体）だったが、5/25 には**主流セキュリティメディア（BleepingComputer）による報道 + 実 UI トグルの一時出現**へと確度が向上。ただし依然として公式発表・有効化手順・対象プランは未確認のため **❓ 噂・未確認**を維持。5/22 公式 Glasswing アップデートの「Mythos クラスモデルの general release 意向」と方向性は引き続き整合し、監視価値が高い。

### 3. Claude Code サンドボックスバイパスの silent パッチ（5/20 SecurityWeek） 🔒

SecurityWeek が 2026-05-20 に、Anthropic が Claude Code の**ネットワーク egress（送信）フィルタを回避できる 2 件のサンドボックスバイパス**を、告知なく（silently）修正していたと開示した（出典: [SecurityWeek（5/20）](https://www.securityweek.com/anthropic-silently-patches-claude-code-sandbox-bypass/)）。

**報じられた 2 件のバイパス:**

- **設定誤解釈バグ（CVE-2025-66479）**: 「すべてのアウトバウンドトラフィックをブロック」という設定が「すべて許可」と誤って解釈される問題
- **SOCKS5 ホスト名ヌルバイト挿入（CVE 未割り当て）**: `attacker-host.com\x00.google.com` のようなホスト名を送ると、フィルタは末尾の `.google.com` を許可と判定する一方、OS はヌルバイトで切り詰めて攻撃者ホストへ接続する。**プロンプトインジェクションと組み合わせると環境変数・認証情報の流出が可能**

**位置づけ / 注意:** 記事は「silently patched」の回顧的開示で、修正自体は**過去の 2.1.x リリースで適用済み**（記事中の具体バージョン・日付表記には不整合があり、当レポートでは SecurityWeek の開示事実のみを記載し、正確なバージョン・適用日は一次情報で要確認）。Claude Code 固有のセキュリティ事項として記録するが、現行最新（v2.1.150）には影響しない既修正案件。

### 4. $30B / $900B 資金調達ラウンド（5/26 時点ステータス）— 変化なし

5/22 Bloomberg「Anthropic to Close Over $30 Billion Round as Soon as Next Week」以降、5/26 時点でも**正式クローズの確認報道はなし**。各メディアは「the week of May 26 is closing on... finalizing a $30 billion raise at a valuation north of $900 billion」と表現するにとどまり、Anthropic 公式の発表（公式 newsroom）には未掲載。Sequoia / Dragoneer / Altimeter / Greenoaks 各 $2B co-lead、Founders Fund / General Catalyst 参加見込み、$900B 評価額（OpenAI $852B 超え）という内容に変化なし（出典: [Bloomberg（5/22）](https://www.bloomberg.com/news/articles/2026-05-22/anthropic-to-close-over-30-billion-round-as-soon-as-next-week) / [Business Standard（5/23）](https://www.business-standard.com/amp/world-news/anthropic-set-to-close-over-30-billion-round-as-soon-as-next-week-126052300112_1.html)）。**CURRENT_FEATURES.md の既存「Anthropic IPO 計画 + $30B/$900B」項目で既出のため、確度・記載に変更なし。**

---

## 結論

- **新規 CLI リリースはなし**（v2.1.150 継続）。Layer 1 はスキップ済み。
- **最重要の新情報**: **Microsoft が E+D グループから Claude Code を撤収**（✅、6/30 期限、Copilot CLI 移行）。エンタープライズ AI コーディングのユニットエコノミクス論争を象徴する Claude Code 関連の確定ニュース。当リポジトリ未記載だったため新規計上。
- **確度補強**: Mythos→Claude Code 統合の兆候が、5/23 単一リークから **5/25 BleepingComputer 報道 + 公開版 Claude Code の実トグル一時出現**へ進展（依然 ❓）。
- **セキュリティ**: Claude Code のネットワーク egress サンドボックスバイパス 2 件の silent パッチを SecurityWeek が 5/20 開示（既修正・現行版に影響なし）。
- **$30B / $900B ラウンド**: 5/26 時点もクローズ未確認。据え置き。
- CURRENT_FEATURES.md を更新（Microsoft 撤収を新規エントリ追加 + Mythos エントリに BleepingComputer 裏付け・公開版トグル一時出現を反映 + セキュリティ修正に egress バイパス開示を追記）。_sidebar.md にレポートリンク追加。

## 情報源一覧

- [The Next Web - Microsoft's quiet Claude Code retreat and the real cost of enterprise AI（5/25）](https://thenextweb.com/news/microsoft-claude-code-retreat-ai-cost)
- [Windows Central - Microsoft cancels Claude Code licenses, shifting developers to GitHub Copilot CLI](https://www.windowscentral.com/microsoft/microsoft-cancels-claude-code-licenses-shifting-developers-to-github-copilot-cli-a-move-likely-driven-by-financial-motives)
- [The Decoder - Microsoft pulls Claude Code licenses and pushes developers back toward its own AI tool](https://the-decoder.com/microsoft-pulls-claude-code-licenses-and-pushes-developers-back-toward-its-own-ai-tool/)
- [winbuzzer - Microsoft Starts Canceling Claude Code Licenses（初報 5/15）](https://winbuzzer.com/2026/05/15/microsoft-starts-canceling-claude-code-licenses-xcxwbn/)
- [BleepingComputer - Anthropic's restricted Claude Mythos model may be coming to Claude Code（5/25）](https://www.bleepingcomputer.com/news/artificial-intelligence/anthropics-restricted-claude-mythos-model-may-be-coming-to-claude-code/)
- [testingcatalog - Anthropic prepares Mythos 1 for Claude Code and Claude Security（5/23）](https://www.testingcatalog.com/anthropic-prepares-mythos-1-for-claude-code-and-claude-security/)
- [SecurityWeek - Anthropic Silently Patches Claude Code Sandbox Bypass（5/20）](https://www.securityweek.com/anthropic-silently-patches-claude-code-sandbox-bypass/)
- [Anthropic Research - Project Glasswing: An initial update（5/22 公式・背景）](https://www.anthropic.com/research/glasswing-initial-update)
- [Bloomberg - Anthropic to Close Over $30 Billion Round as Soon as Next Week（5/22）](https://www.bloomberg.com/news/articles/2026-05-22/anthropic-to-close-over-30-billion-round-as-soon-as-next-week)
- [Business Standard - Anthropic set to close over $30 billion round as soon as next week（5/23）](https://www.business-standard.com/amp/world-news/anthropic-set-to-close-over-30-billion-round-as-soon-as-next-week-126052300112_1.html)

## スキップしたURL

| URL | スキップ理由 |
|-----|------------|
| quasa.io / byteiota.com / sesamedisk.com / inkl.com / technobezz.com / windowsforum.com | 二次まとめ・転載系・実績不明ドメイン。Microsoft 撤収は The Next Web / Windows Central / The Decoder / winbuzzer で一次確認済みのため不採用 |
| releasebot.io / claudefa.st / getaiperks.com / medium（まとめ系） | 自動集約・SEO まとめ系。一次情報（公式 + 著名メディア）で確認済みのため不採用 |
