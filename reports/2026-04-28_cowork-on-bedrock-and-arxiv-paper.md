# 2026-04-28 ニュースモード調査: Claude Cowork on Amazon Bedrock & arXiv「Dive into Claude Code」アーキテクチャ論文

**調査モード:** ニュースモード（Layer 1 = CLI チェンジログはスキップ。最新は v2.1.119、v2.1.120 はロールバック済み）
**調査日:** 2026-04-28
**対象期間:** 2026-04-26 〜 2026-04-28（前回レポート 2026-04-26 以降）

---

## 概要

新しい CLI リリースは確認されず（**v2.1.119 が依然最新**、v2.1.120 は回帰のためロールバック済み）。Layer 2（公式ブログ・AWS マーケットプレイス）と Layer 3（メディア・研究コミュニティ）から以下の新情報を確認：

1. **Claude Cowork on Amazon Bedrock**（4/21 AWS Machine Learning Blog 公開、**4/27 AWS Weekly Roundup でハイライト**）— **Claude Code Desktop を含む** Cowork デスクトップアプリを Amazon Bedrock 経由で配信可能に。エンタープライズ向けの新しい配信チャネル。
2. **arXiv プレプリント「Dive into Claude Code: The Design Space of Today's and Future AI Agent Systems」**（VILA-Lab、4/14 公開、**4/27 IntelligentLiving 等で注目**）— Claude Code のアーキテクチャを系統的に分析、**「1.6% AI 決定ロジック / 98.4% 運用インフラ」**、7 モードのパーミッションシステム、5 層 compaction パイプライン、4 つの拡張機構（MCP/Plugins/Skills/Hooks）、worktree 分離 subagent delegation、append-oriented session storage 等を解明。
3. **Anthropic Sydney オフィス開設 & ANZ GM Theo Hourmouzis 任命**（4/27、Anthropic 公式 Newsroom）— APAC 4 つめの拠点（東京・ベンガルール・ソウル・シドニー）。
4. **コミュニティリリース: pentest-ai-agents**（4/27、0xSteph）— 28 専門サブエージェントで Claude Code を攻撃的セキュリティ研究アシスタント化する OSS ツールキット。
5. **Claude.ai 軽微インシデント**（4/27 14:13 UTC、約 1 分）— Elevated billing related errors。Claude Code への影響なし。

Anthropic 公式ニュースルーム・APIリリースノート・Help Center は **4/28 付の新規エントリなし**（4/27 が最新）。

---

## 主要な新情報

### Claude Cowork on Amazon Bedrock（Claude Code Desktop 含む） ✅

- **リリース状態**: ✅ GA（AWS Bedrock 経由）
- **公開日**: 2026-04-21（AWS Machine Learning Blog）／ 4/27 AWS Weekly Roundup でハイライト紹介
- **対象**: AWS Bedrock を利用するエンタープライズ顧客
- **対象プラットフォーム**: macOS / Windows / Linux（Cowork デスクトップアプリ・Claude Code Desktop）
- **概要**: Claude Cowork デスクトップアプリ（Anthropic-hosted の Cowork と同一の UX）と **Claude Code Desktop** を、Amazon Bedrock 経由で実行可能に。直接または LLM ゲートウェイ経由のいずれの構成も可能。Anthropic からのシート課金は不要、AWS の従量課金のみ。
- **含まれる機能**: プロジェクト、アーティファクト、メモリ、ファイル管理、リモートコネクタ、Skills、Plugins、MCP サーバー
- **除外される機能**: Anthropic-hosted の Chat / Computer Use / Skills Marketplace（推論が完全に Bedrock 経由になるため）
- **対応リージョン**: Claude モデルが Amazon Bedrock で利用可能な全 AWS リージョン。in-Region / geo cross-Region / global cross-Region 推論プロファイル選択可
- **エンタープライズ機能**:
  - データはユーザー AWS アカウント内に留まる（Bedrock はプロンプト・ファイル・レスポンスを保持しない）
  - AWS IAM または Bedrock API キー認証
  - VPC エンドポイントによるネットワーク隔離
  - AWS CloudTrail 監査
  - OpenTelemetry → CloudWatch 連携
  - 細粒度のコスト属性
- **意義**: Claude Code Desktop（旧 Cowork）が **個人開発者プロダクトから AWS 顧客のエンタープライズ標準提供チャネル**へと拡張。4/24 に発表された NEC（30,000 人規模 Cowork 全社展開）など大規模顧客の受け皿となる。
- **情報源**:
  - [AWS Machine Learning Blog (2026-04-21)](https://aws.amazon.com/blogs/machine-learning/from-developer-desks-to-the-whole-organization-running-claude-cowork-in-amazon-bedrock/)
  - [AWS Weekly Roundup (2026-04-27)](https://aws.amazon.com/blogs/aws/aws-weekly-roundup-anthropic-meta-partnership-aws-lambda-s3-files-amazon-bedrock-agentcore-cli-and-more-april-27-2026/)

### arXiv「Dive into Claude Code」アーキテクチャ論文（VILA-Lab） 📊

- **公開**: 2026-04-14（arXiv:2604.14228v1）／ 2026-04-27 IntelligentLiving 等でメディア注目
- **著者**: Jiacheng Liu, Xiaohan Zhao, Xinyi Shang, Zhiqiang Shen（VILA-Lab）
- **GitHub**: [VILA-Lab/Dive-into-Claude-Code](https://github.com/VILA-Lab/Dive-into-Claude-Code)
- **キーファインディング**:
  - **コードベースの 1.6% のみが AI 決定ロジック、残り 98.4% は決定論的インフラ**（パーミッションゲート、コンテキスト管理、ツールルーティング、リカバリーロジック）
  - コアは「モデル呼び出し→ツール実行→繰り返し」のシンプルな while ループ
  - **7 モードのパーミッションシステム**（ML ベース分類器付き）
  - **5 層の compaction パイプライン**（コンテキスト管理）
  - **4 つの拡張機構**: MCP / Plugins / Skills / Hooks
  - **Subagent delegation**: worktree 分離による独立タスク実行
  - **Append-oriented session storage**: 操作履歴を append で永続化
- **5 つの設計ドライバー**: human decision authority / safety & security / reliable execution / capability amplification / contextual adaptability
- **13 の設計原則**: 上記 5 つの価値から 13 原則を経て具体実装に至るマッピングを提示
- **比較対象**: OpenClaw との対比により、同じ設計課題が異なるデプロイメント文脈で異なる解決策を生む様子を示す（per-action 分類 vs perimeter-level 制御）
- **意義**: Claude Code が公式に詳細を語っていないアーキテクチャ判断（パーミッションモード分類、compaction 戦略、拡張機構の選択基準）を**外部研究者が体系化**。Anthropic 自身ではないが、本論文は Claude Code の設計を理解する上で実質的な公開リファレンスとして機能。
- **情報源**:
  - [arXiv:2604.14228](https://arxiv.org/abs/2604.14228)
  - [Hugging Face Paper](https://huggingface.co/papers/2604.14228)
  - [IntelligentLiving 解説 (2026-04-27)](https://www.intelligentliving.co/claude-code-architecture-agents/)
  - [arxiviq Substack 解説](https://arxiviq.substack.com/p/dive-into-claude-code-the-design)

### Anthropic Sydney オフィス正式開設・ANZ GM Theo Hourmouzis 任命 📢

- **公開**: 2026-04-27（Anthropic 公式 Newsroom）
- **概要**:
  - Theo Hourmouzis を **Australia & New Zealand 担当 General Manager** に任命
  - **Sydney オフィスを正式オープン** — 東京・ベンガルール・ソウルに次ぐ APAC 4 拠点目
  - 3/10 に Bloomberg がリーク報道、3/11 Anthropic が予告ブログを公開しており、4/27 が正式オープン
- **Claude Code への影響**: 直接的な機能変更なし。ANZ 地域でのエンタープライズ販売・サポート体制強化により、現地企業の Cowork / Claude Code 導入が加速する可能性
- **情報源**: [Anthropic公式 (2026-04-27)](https://www.anthropic.com/news/sydney-fourth-office-asia-pacific)（旧予告: [2026-03-11](https://www.anthropic.com/news/sydney-fourth-office-asia-pacific)）

### コミュニティリリース: pentest-ai-agents（28 Claude Code Subagents） 📢

- **公開**: 2026-04-27
- **作者**: 0xSteph（セキュリティ研究者）
- **概要**: Claude Code を攻撃的セキュリティ研究アシスタントに変える OSS ツールキット。28 の専門 subagents を含む
- **カバレッジ**:
  - Reconnaissance / Web application testing
  - Active Directory attacks / Cloud security
  - Mobile pentesting / Wireless attacks
  - Social engineering / Exploit chaining
  - Detection engineering / Forensics
  - Malware analysis / Report generation
- **位置づけ**: Anthropic 公式ではないコミュニティ製。**Claude Mythos Preview（防御的サイバー）とは対照的に、攻撃側ワークフローを Claude Code 上で実行する事例**として注目されている
- **情報源**: [Cybersecurity News (2026-04-27)](https://cybersecuritynews.com/pentest-ai-agents-tool/)

### Claude.ai 軽微インシデント（4/27） 🟡

- **発生**: 2026-04-27 14:13 UTC、約 **1 分**
- **タイトル**: "Elevated billing related errors on Claude.ai"
- **影響範囲**: Claude.ai のみ（**Claude Code への直接影響なし**、Cowork / API も無影響と推測）
- **位置づけ**: 4/25 の Opus 4.7 連続障害（最長 3h15m）、claude.ai 20 分障害と比較すると軽微。直近の Anthropic ステータスは安定傾向
- **情報源**: [StatusGator Claude](https://statusgator.com/services/claude)

---

## Layer 別まとめ

### Layer 2: 公式ブログ・APIドキュメント

| 日付 | 種別 | 内容 |
|------|------|------|
| 2026-04-27 | Newsroom | Theo Hourmouzis を ANZ GM 任命、Sydney オフィス正式オープン |
| 2026-04-21 | AWS ML Blog | Claude Cowork（Claude Code Desktop 含む）on Amazon Bedrock GA 解説 |
| 2026-04-24 | API Release Notes | Rate Limits API GA（前回レポート反映済み） |
| — | Help Center Release Notes | 新規エントリなし（最新は 4/16 Opus 4.7） |
| — | Claude Code 公式 What's New | 新規エントリなし |

### Layer 3: ニュースメディア・研究コミュニティ

| 日付 | ソース | 内容 |
|------|--------|------|
| 2026-04-27 | AWS Weekly Roundup | Anthropic-AWS パートナーシップ拡張ハイライト、Cowork on Bedrock 紹介 |
| 2026-04-27 | IntelligentLiving | 「Inside Claude Code Architecture」記事で arXiv 論文を解説 |
| 2026-04-27 | Cybersecurity News | pentest-ai-agents（28 Claude Code subagents）紹介 |
| 2026-04-27 | StatusGator | Claude.ai billing 関連エラー（1 分） |
| 2026-04-14 (発見 4/27) | arXiv | "Dive into Claude Code" 論文公開 |

---

## 廃止予定・スケジュール（変更なし）

| モデル/機能 | 発効日 | 移行先 |
|------------|--------|--------|
| Sonnet 4.5/4 の 1M ベータ | **2026-04-30**（あと 2 日） | Sonnet 4.6 / Opus 4.6（1M GA） |
| Sonnet 4 / Opus 4 | 2026-06-15 | Sonnet 4.6 / Opus 4.7 |

---

## 情報源一覧

### Layer 2（公式）
- [AWS Machine Learning Blog: From developer desks to the whole organization (2026-04-21)](https://aws.amazon.com/blogs/machine-learning/from-developer-desks-to-the-whole-organization-running-claude-cowork-in-amazon-bedrock/)
- [Anthropic Newsroom: Sydney fourth office Asia-Pacific](https://www.anthropic.com/news/sydney-fourth-office-asia-pacific)
- [Claude Platform Release Notes](https://platform.claude.com/docs/en/release-notes/overview)
- [Claude Help Center Release Notes](https://support.claude.com/en/articles/12138966-release-notes)

### Layer 3（メディア・研究）
- [AWS Weekly Roundup (2026-04-27)](https://aws.amazon.com/blogs/aws/aws-weekly-roundup-anthropic-meta-partnership-aws-lambda-s3-files-amazon-bedrock-agentcore-cli-and-more-april-27-2026/)
- [arXiv: Dive into Claude Code (2604.14228)](https://arxiv.org/abs/2604.14228)
- [GitHub: VILA-Lab/Dive-into-Claude-Code](https://github.com/VILA-Lab/Dive-into-Claude-Code)
- [IntelligentLiving: Inside Claude Code Architecture](https://www.intelligentliving.co/claude-code-architecture-agents/)
- [Cybersecurity News: pentest-ai-agents](https://cybersecuritynews.com/pentest-ai-agents-tool/)
- [StatusGator Claude](https://statusgator.com/services/claude)
