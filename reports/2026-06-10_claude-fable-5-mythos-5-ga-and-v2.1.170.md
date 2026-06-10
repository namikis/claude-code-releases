# 調査レポート: Claude Code v2.1.170 + Claude Fable 5 / Mythos 5 一般提供開始

**調査日:** 2026-06-10

## 概要

- **Mythos クラスモデルがついに一般提供（✅ GA）開始** — 6/9、Anthropic は Mythos クラスの公開版を **「Claude Fable 5」** として一般リリースし、安全分類器を一部解除した **「Claude Mythos 5」** を Project Glasswing 等の限定提供で同時投入。これまで本ドキュメントで「📢 発表のみ（coming weeks）」として追跡してきた *Mythos クラス general release* が確度更新（📢 → ✅ GA）。
- **CLI v2.1.170（6/9 17:23 UTC）** で Claude Code が Fable 5 に対応。`/model fable`（または `--model claude-fable-5`）で選択でき、**デフォルトモデルは Opus 4.8 のまま据え置き**（Fable 5 は「エスカレーション用モデル」）。自己ホストランナー向け `post-session` ライフサイクルフック追加、VS Code 統合ターミナル起動時のトランスクリプト保存不具合を修正。
- **Fable 5 のコーディング性能**: SWE-bench Verified **95.0%** / SWE-bench Pro **80.3%**（GPT-5.5 58.6%）/ Terminal-Bench 2.1 **88.0%** / FrontierCode Diamond **29.3%**（Opus 4.8 13.4%）。価格 **$10/$50 per MTok**、1M コンテキスト、128k 出力。
- **プラン提供**: 6/9〜**6/22 は Pro/Max/Team/Enterprise で追加課金なし**、6/23 以降は容量次第で usage credits 必要。**Amazon Bedrock で launch 同時 GA**（US East N. Virginia / Europe Stockholm）。Mythos 5 は Bedrock Limited Preview。
- **コーポレート**: 5/28 に **Series H $65B / $965B post-money** がクローズ（従来追跡の $30B/$900B 噂を上回る確定額）、6/1 に **SEC へ S-1 を機密申請（IPO 準備）**。

新規 CLI リリースは v2.1.170 の 1 本（前回 6/9 レポートは v2.1.169 まで）。

---

## 主要な新機能

### 1. Claude Fable 5 — Mythos クラスの一般提供モデル ✅ GA

**リリース状態**: ✅ GA（2026-06-09）
**対象プラン**: Pro / Max / Team / Enterprise（6/22 まで無料同梱）/ API / Bedrock
**対象プラットフォーム**: Claude API / Claude Code（CLI/VS Code 拡張）/ Amazon Bedrock / Claude アプリ / GitHub Copilot

- **位置づけ**: 「これまで一般提供したどのモデルをも上回る」最強の公開モデル。Opus の上位に位置する新ティア「**Mythos クラス**」の安全版。ソフトウェアエンジニアリング、ナレッジワーク、ビジョン、科学研究で SOTA。
- **安全分類器**: 機微なリクエスト（①サイバーセキュリティ攻撃 ②生物・化学のデュアルユース ③蒸留＝競合モデル訓練のための抽出）は **自動的に Claude Opus 4.8 へフォールバック**。発動は平均で全セッションの **5% 未満**。外部レッドチームでは 30 種の公開ジェイルブレイク手法を併用しても有害な単発リクエストの成功はゼロ。
- **データ保持**: Mythos クラストラフィックは安全監視目的で **30 日保持**（人間アクセスは全ログ記録）。
- **コーディング実績**: Stripe が 5,000 万行規模の Ruby コードベース移行（手作業見積もり約 2 ヶ月）を **1 日**に短縮。IMC はトレーディング分析評価を「ほぼ全面的に攻略」。Hebbia Finance Benchmark で最高スコア、Cognition FrontierCode で frontier モデル最高。
- **永続メモリ**: 長時間タスクで数百万トークンを扱い、永続メモリ改善で **3 倍**の性能向上。ビジョンのみ（補助ツールなし）で Pokémon FireRed をクリア。
- **情報源**: [Anthropic - Claude Fable 5 and Claude Mythos 5](https://www.anthropic.com/news/claude-fable-5-mythos-5)

| ベンチマーク | Fable 5 | Opus 4.8 | 比較 |
|------------|---------|----------|------|
| SWE-bench Verified | 95.0% | 88.6% | +6.4pt |
| SWE-bench Pro | 80.3% | 69.2% | +11.1pt（GPT-5.5 は 58.6%） |
| Terminal-Bench 2.1 | 88.0% | 82.7% | +5.3pt |
| FrontierCode Diamond | 29.3% | 13.4% | +15.9pt |

#### Claude Code での使い方

- **モデル選択**: `/model fable`、`claude --model claude-fable-5`、または `ANTHROPIC_MODEL="claude-fable-5"`。**要 CLI v2.1.170+**。
- **デフォルトではない**: Claude Code のデフォルトモデルは引き続き **Opus 4.8**。Fable 5 は難易度の高いタスク向けの「エスカレーション用」モデルとして選択する。
- **デフォルト effort**: Fable 5 は **high**（Opus 4.8/4.6・Sonnet 4.6 と同じ。Opus 4.7 のみ xhigh）。初回切替時はそのモデルのデフォルト effort が適用され、`/effort` で再選択可能。
- **adaptive thinking**: 常時有効（生の思考出力は返らない）。
- **価格**: $10 / $50 per MTok（Mythos Preview の半額未満、Opus 標準 $5/$25 の約 2 倍）。

### 2. Claude Mythos 5 — 安全分類器を解除した限定提供版 🔬

**リリース状態**: 🔬 限定提供（Project Glasswing パートナー + 選定された生物学研究者向け trusted access）
**概要**: Fable 5 と同一の基盤モデルだが、サイバーセキュリティ分野の安全分類器を解除。サイバーセキュリティ専門家・重要インフラ事業者に Glasswing 経由で提供し、生物学研究者へ段階拡大予定。
- 科学研究で創薬プロセスを **10 倍加速**、新規仮説が研究者に約 **80%** の確率で好まれる。1 週間規模のゲノミクス研究を自律実行し、100 倍小さいにもかかわらず公開モデルを上回る。AAV 設計タスクで専用タンパク質モデルを凌駕。
- **Bedrock**: 「Claude Mythos 5 on Bedrock（Limited Preview）」としてデュアルユース性ゆえアクセス厳格制限。
- **情報源**: [Anthropic - Claude Fable 5 and Claude Mythos 5](https://www.anthropic.com/news/claude-fable-5-mythos-5) / [TechCrunch](https://techcrunch.com/2026/06/09/anthropic-released-claude-fable-5-its-most-powerful-model-publicly-days-after-warning-ai-is-getting-too-dangerous/)

### 3. CLI v2.1.170（2026-06-09 17:23 UTC）

- **Claude Fable 5 対応**（上記）。
- **`post-session` ライフサイクルフック**（自己ホストランナー向け）: 未コミット作業のスナップショットやログのエクスポートに利用。
- **バグ修正**: VS Code 統合ターミナル（または Claude Code 環境変数を継承したシェル）から起動したセッションで**トランスクリプトが保存されず `--resume` 一覧に出ない**不具合を修正。
- **情報源**: [Claude Code changelog](https://code.claude.com/docs/en/changelog) / [GitHub Releases](https://github.com/anthropics/claude-code/releases) / [DevelopersIO](https://dev.classmethod.jp/en/articles/20260609-cc-updates-v2-1-170/)

### 4. Amazon Bedrock 同日 GA

- **提供**: 6/9 launch 同時に Bedrock で GA。リージョンは **US East（N. Virginia）/ Europe（Stockholm）**。
- **モデル ID**: `anthropic.claude-fable-5`（Anthropic Messages API / bedrock-mantle）、`global.anthropic.claude-fable-5`（Converse API / bedrock-runtime）。
- **課金**: 安全分類器が発動して Opus にフォールバックした分は **Opus 価格**で課金（会話途中ブロック時は初期トークン Fable 価格 + 後続 Opus 価格）。
- **情報源**: [AWS - Claude Fable 5 on AWS](https://aws.amazon.com/blogs/aws/anthropic-claude-fable-5-on-aws-mythos-class-capabilities-with-built-in-safeguards-now-available/)

### 5. コーポレート / プラットフォーム周辺

- **Series H クローズ（5/28）**: **$65B 調達・$965B post-money valuation**。本ドキュメントでこれまで追跡していた「$30B / $900B（クローズ未確認）」の噂を上回る確定額。
- **SEC 機密 S-1 申請（6/1）**: Anthropic が IPO に向け **S-1 登録届出書を機密提出**。AI ブームの公開市場テストとして報道（CBS News 等）。
- **Claude Partner Network 拡張（6/3）**: 「Services Track」と「Partner Hub」を新設しパートナーエコシステムを拡張。
- **情報源**: [Anthropic Newsroom](https://www.anthropic.com/news) / [CBS News - Anthropic IPO](https://www.cbsnews.com/news/anthropic-ipo-confidential-filing-claude-ai/)

---

## バグ修正・パフォーマンス改善（v2.1.170）

- VS Code 統合ターミナル起動時のトランスクリプト未保存 / `--resume` 非表示の不具合修正（上記）。
- それ以外は Fable 5 対応と `post-session` フック追加が中心の軽量リリース。

---

## リリース一覧

| バージョン | 日付 (UTC) | 主要変更 |
|-----------|-----------|---------|
| v2.1.170 | 2026-06-09 17:23 | Claude Fable 5 対応（`/model fable`、要 v2.1.170+、デフォルトは Opus 4.8 据え置き）、`post-session` ライフサイクルフック、VS Code ターミナル トランスクリプト保存修正 |

> 注: v2.1.171 以降は 2026-06-10 時点で未公開（公式チェンジログ・GitHub Releases とも v2.1.170 が最新）。

---

## ステータス更新（確度の変化）

| 項目 | 旧確度 | 新確度 | 備考 |
|------|--------|--------|------|
| Mythos クラス general release | 📢 発表のみ | ✅ GA（Claude Fable 5） | 6/9 一般提供開始 |
| Mythos クラス安全解除版 | ❓/限定の噂 | 🔬 限定提供（Claude Mythos 5） | Glasswing + 生物学研究者 |
| $30B/$900B 調達ラウンド | ❓ クローズ未確認 | ✅ 確定（$65B/$965B Series H、5/28） | 規模が上振れ |
| Anthropic IPO | ❓ 噂 | 📢 機密 S-1 申請済み（6/1） | 上場時期未定 |

---

## 情報源一覧

- [Anthropic - Claude Fable 5 and Claude Mythos 5（公式）](https://www.anthropic.com/news/claude-fable-5-mythos-5)
- [Anthropic Newsroom](https://www.anthropic.com/news)
- [Claude Code changelog（公式）](https://code.claude.com/docs/en/changelog)
- [GitHub Releases - anthropics/claude-code](https://github.com/anthropics/claude-code/releases)
- [AWS - Anthropic Claude Fable 5 on AWS](https://aws.amazon.com/blogs/aws/anthropic-claude-fable-5-on-aws-mythos-class-capabilities-with-built-in-safeguards-now-available/)
- [VentureBeat - Anthropic brings Mythos to the masses with Claude Fable 5](https://venturebeat.com/technology/anthropic-brings-mythos-to-the-masses-with-claude-fable-5-its-most-powerful-generally-available-model-ever)
- [TechCrunch - Claude Fable 5 is a version of Mythos the public can access today](https://techcrunch.com/2026/06/09/anthropic-released-claude-fable-5-its-most-powerful-model-publicly-days-after-warning-ai-is-getting-too-dangerous/)
- [CNBC - Anthropic releases Mythos-like AI model to the public, Claude Fable 5](https://www.cnbc.com/2026/06/09/anthropic-mythos-claude-fable-5.html)
- [DevelopersIO - Claude Code v2.1.170 Major Update](https://dev.classmethod.jp/en/articles/20260609-cc-updates-v2-1-170/)
- [Kingy AI - Claude Fable 5 Benchmarks Explained](https://kingy.ai/ai/claude-fable-5-benchmarks-explained-coding-context-window-pricing-and-mythos-class-performance/)
- [CBS News - Anthropic files for IPO](https://www.cbsnews.com/news/anthropic-ipo-confidential-filing-claude-ai/)

## スキップしたURL

| URL | スキップ理由 |
|-----|------------|
| https://venturebeat.com/technology/anthropic-brings-mythos-to-the-masses-with-claude-fable-5-... | HTTP 403 で本文取得不可（検索スニペットで内容補足、情報源には残置） |
