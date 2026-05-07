# 2026-05-08 Claude Code 新機能調査レポート — 5/7 Anthropic 公式ブログで Office 4 アプリ クロスアプリ統合体験を正式 GA 発表（Excel/PowerPoint/Word が GA、Outlook が 公開ベータ、全有料プラン展開、Bedrock/Vertex AI/Foundry LLM ゲートウェイ経由対応）+ Snyk AI Security Platform に Claude モデル組み込み（5/7、Evo by Snyk が AI 資産発見・prompt injection / data exfiltration テスト・agent supply chain スキャン）+ Bloomberg「Claude Chatbot More Appealing to Consumers」スクープ（モバイル起動 5-6秒 → 1秒、Apple App Store 米国 2 位、日次サインアップ 100万人/日）

**調査日**: 2026-05-08
**対象期間**: 2026-05-07 〜 2026-05-08（5/6 Code with Claude SF キーノートのフォローアップ期間）
**調査モード**: ニュースモード（Layer 2: 公式ブログ・APIドキュメント / Layer 3: ニュースメディア のみ）

---

## 概要

5/6 Code with Claude SF キーノートの翌日となる 5/7 は、**Anthropic 公式ブログから 1 本の重要発表**（Microsoft Office 4 アプリ クロスアプリ統合体験の正式 GA）と、**サードパーティーセキュリティベンダー Snyk による Claude 組み込み発表**、さらに **Bloomberg による消費者向け Claude チャットボット戦略のスクープ**が出揃う日となった。Claude Code CLI の新規リリースは無く（5/6 v2.1.132 が最新のまま）、本日の調査はニュースモードで Layer 2 / Layer 3 のみ実施。

| カテゴリ | 主要発表 |
|---------|---------|
| **Microsoft Office 統合 GA**（Layer 2） | Anthropic 公式ブログ "Collaborate with Claude across Excel, PowerPoint, Word and Outlook"（5/7）。**Excel / PowerPoint / Word が GA、Outlook が公開ベータ、全有料プラン**（Mac / Windows）。Microsoft AppSource 2 リスティング（Excel/PPT/Word 統合 + Outlook 別）、**Bedrock / Vertex AI / Microsoft Foundry の LLM ゲートウェイ経由ルーティング対応**、OpenTelemetry セキュリティ監視・Analytics API（per-user / per-app）でエンタープライズ統制 |
| **Snyk + Claude 組み込み**（Layer 3） | Snyk AI Security Platform 全体に Claude モデル組み込み（5/7 GlobeNewswire 経由 PR）。**自動脆弱性検出・優先順位付け・開発者向け修正**、コード / 依存関係 / コンテナ / **AI 生成 artifacts** 横断。**Evo by Snyk** が AI ガバナンス（モデル / エージェント / MCP サーバー / データセット / サードパーティーツール発見）、prompt injection / data exfiltration テスト、agent supply chain スキャン |
| **消費者戦略スクープ**（Layer 3） | Bloomberg "Anthropic Is Making Its Claude Chatbot More Appealing to Consumers"（5/7）。**モバイルアプリ起動時間 5-6 秒 → 1 秒**（Mike Krieger Labs 共同 lead 発言）、Apple App Store 米国 **2 位**（ChatGPT 1 位、Gemini 3 位）、3 月時点で日次サインアップ **100 万人/日**（年初比 4 倍）、ヘルス / トラベル / レシピ等の personal query 改善を late last year から従業員にタスク化 |
| **報道二次フォロー**（Layer 3） | 9to5Mac "Anthropic updates Claude Managed Agents with three new features"（5/7）— 5/6 Code with Claude SF 発表（Dreaming 研究プレビュー、Outcomes / Multi-Agent Orchestration 公開ベータ）の二次報道。**新情報なし**（既知内容） |

**Layer 1（CLI チェンジログ）**: 本日新規リリースなし。最新は v2.1.132（5/6 22:08 UTC、`CLAUDE_CODE_SESSION_ID` + `CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN` 等）。

---

## 主要な新発表

### 1. ✅ Microsoft Office 4 アプリ クロスアプリ統合体験 — 正式 GA 公式ブログ発表（5/7）

- **リリース状態**: ✅ **GA**（Excel / PowerPoint / Word）/ 🧪 **公開ベータ**（Outlook）
- **発表媒体**: [Anthropic 公式ブログ "Collaborate with Claude across Excel, PowerPoint, Word and Outlook"](https://claude.com/blog/collaborate-with-claude-across-excel-powerpoint-word-and-outlook)（5/7）
- **対象プラン**: **すべての有料プラン**（Pro / Max / Team / Enterprise）— 5/5 The Briefing: Financial Services 時点では「Pro: Excel のみ / Max: Excel + PowerPoint / Team・Enterprise: 全アプリ」というプラン階層差があったが、**5/7 公式ブログ表記は "All paid plans" に統一**された可能性あり（Help Center 反映状況は要追跡）
- **対象プラットフォーム**: Windows / Mac（Web 版 Office・iPad は引き続き対応、Android 非対応）
- **概要**: Excel・PowerPoint・Word・Outlook の Microsoft Office 4 アプリで、**1 つの会話を維持したままアプリ間を移動**できるクロスアプリ統合体験を正式 GA 化。アプリ A の変更がアプリ B / C / D に**リアルタイム反映**される双方向同期。

#### 5/5 → 5/7 の差分（何が新しいか）

5/5 の The Briefing: Financial Services（NYC）で「**Microsoft 365 完全統合体験として 4 アプリ間コンテキスト自動キャリーオーバーを GA 化**」とアナウンスされたが、**正式な公式ブログ + 製品発表**として整理され、以下の点が初めて明示された:

1. **「全有料プラン」表記** — 従来のプラン階層表（Pro: Excel のみ等）が "all paid plans" に統一された記述に
2. **Microsoft AppSource の 2 リスティング体制** — Excel / PowerPoint / Word を 1 つの統合リスティングに、Outlook を別途公開ベータ用リスティングとして分離。**Microsoft 管理センター経由で IT 管理者が一括デプロイ可能**
3. **LLM ゲートウェイ経由ルーティング** — 組織が既存の **Amazon Bedrock / Google Cloud Vertex AI / Microsoft Foundry** の Claude エンドポイントに M365 アドインをルーティング可能（既存の AI ガバナンス / 監査基盤を再利用できる）
4. **OpenTelemetry セキュリティ監視** — 組織が OpenTelemetry を構成して M365 アドイン経由の Claude 利用ログを収集可能
5. **Analytics API**（**per-user / per-app activity tracking**） — エンタープライズが個別ユーザー / アプリごとの活動を追跡

#### Outlook の具体機能（公開ベータ詳細追補）

- **Inbox triage**: 受信トレイの整理
- **Draft composition**: 宛先・件名の自動入力で返信草稿生成
- **Calendar availability check**: 予定空き状況の確認・自動提案

#### 4 アプリ シナジーの典型ワークフロー

公式ブログ提示の代表例: **「Outlook で受信メールをトリアージ → 添付を Word で開いてチームテンプレートに沿ってメモ起草 → Excel で裏付け分析 → PowerPoint でデッキに変換」を再説明なしで一気通貫実行**。Excel で前提条件を変えると、PowerPoint のチャート・Word メモ内の数値が**自動更新**される。

#### Claude Code エコシステムへの含意

5/6 キーノートで GA された Claude Code 側の **Code Review / Security Reviews / CI Auto-Fix / Remote Agents** と、5/7 ブログで GA された **Microsoft Office 4 アプリ統合**は、**同じ "Cowork as hub" アーキテクチャ**で接続される。Cowork デスクトップアプリの Skills Marketplace / コネクタ統制機能を中央 hub として、開発者ワークフロー（Claude Code）とビジネスユーザーワークフロー（M365 アドイン）が同一エンタープライズ統制下で運用できる体制が完成した。

- **情報源**:
  - [Anthropic 公式ブログ "Collaborate with Claude across Excel, PowerPoint, Word and Outlook"（5/7）](https://claude.com/blog/collaborate-with-claude-across-excel-powerpoint-word-and-outlook)
  - [Use Claude for Excel (Help Center)](https://support.claude.com/en/articles/12650343-use-claude-for-excel)
  - [Use Claude for PowerPoint (Help Center)](https://support.claude.com/en/articles/13521390-use-claude-for-powerpoint)
  - [Use Claude for Word (Help Center)](https://support.claude.com/en/articles/14465370-use-claude-for-word)
  - [Work across Excel, PowerPoint, and Word (Help Center)](https://support.claude.com/en/articles/13892150-work-across-excel-powerpoint-and-word)
  - [M365 Connector for Claude (Microsoft Marketplace)](https://marketplace.microsoft.com/en-us/product/saas/anthropic.microsoft-365-connector-for-claude)

---

### 2. ✅ Snyk AI Security Platform に Anthropic Claude モデル組み込み（5/7）

- **リリース状態**: ✅ 既存共同顧客向けに**本日提供開始**、2026 年通じて拡大ロールアウト
- **発表媒体**: [Snyk PR "Snyk Embeds Anthropic's Claude to Advance AI-Powered Security for Software Development"（5/7、GlobeNewswire）](https://www.daily-tribune.com/online_features/press_releases/snyk-embeds-anthropics-claude-to-advance-ai-powered-security-for-software-development/article_6d065327-a995-5f4d-bd88-1a20ce927137.html)
- **対象**: Snyk AI Security Platform 全体（コード / 依存関係 / コンテナ / **AI 生成 artifacts** 横断）。Snyk と Anthropic の共同顧客は本日から利用可能
- **概要**: Snyk が Claude モデルを **AI Security Platform** に深層統合し、**自動脆弱性検出 → 優先順位付け → 開発者向け修正** までを統合フローで提供。「フロンティアモデルが見つけた findings を、Snyk が priorityzied / developer-ready fixes に変換し、コードが書かれている workflow 内に自動投入」というポジショニング

#### Evo by Snyk（AI ガバナンスエンジン）

Snyk は本発表で **Evo by Snyk** という AI ガバナンス製品も Claude モデル動力化したと明記。能力:

| 能力 | 概要 |
|------|------|
| **AI 資産発見** | 組織内のすべての AI 資産を継続発見: モデル / エージェント / **MCP サーバー** / データセット / サードパーティーツール |
| **agent supply chain スキャン** | 動作中エージェントを **prompt injection / data exfiltration** に対して red-team |
| **Runtime policy enforcement** | tool call レベルでランタイムポリシー強制（damage 発生前の遮断） |

#### Claude Code との関係性

Snyk 側ステートメントは **「Why Anthropic Launching Claude Code Security Is Great News for the Industry」**（[Snyk公式ブログ](https://snyk.io/articles/anthropic-launches-claude-code-security/)）と直接連動。Claude Code 側の **Security Reviews ✅ GA**（5/6）と **Claude Security 🧪 公開ベータ**（4/30）が "Anthropic 一次提供のセキュリティレイヤー" を担当する一方、**Snyk + Claude は "Snyk プラットフォーム上での補完的セキュリティ製品"** として並列ポジショニング。**MCP サーバーが Evo by Snyk のスキャン対象に含まれている**ことから、Claude Code のサブエージェント / hooks / MCP サーバー構成も Snyk によるサプライチェーン検証の対象になる可能性が示唆される。

- **情報源**:
  - [Snyk PR (Manila Times、5/8 配信)](https://www.manilatimes.net/2026/05/08/tmt-newswire/globenewswire/snyk-embeds-anthropics-claude-to-advance-ai-powered-security-for-software-development/2338822)
  - [Snyk PR (Daily Tribune、5/7)](https://www.daily-tribune.com/online_features/press_releases/snyk-embeds-anthropics-claude-to-advance-ai-powered-security-for-software-development/article_6d065327-a995-5f4d-bd88-1a20ce927137.html)
  - [TipRanks: Snyk embeds Claude](https://www.tipranks.com/news/private-companies/snyk-embeds-anthropics-claude-to-scale-ai-native-application-security)
  - [Snyk 公式ブログ - Claude Code Security について](https://snyk.io/articles/anthropic-launches-claude-code-security/)
  - [Yahoo Finance（5/7）](https://finance.yahoo.com/sectors/technology/articles/snyk-embeds-anthropics-claude-advance-174900036.html)

---

### 3. 📰 Bloomberg スクープ — Anthropic、消費者向けに Claude チャットボット強化戦略（5/7）

- **発表媒体**: [Bloomberg "Anthropic Is Making Its Claude Chatbot More Appealing to Consumers"（5/7）](https://www.bloomberg.com/news/articles/2026-05-07/anthropic-is-making-claude-chatbot-more-appealing-to-consumers)
- **状態**: ✅ 戦略確認済み（Mike Krieger 公式コメント引用）
- **概要**: もともとビジネス向けに claude を売ってきた Anthropic が、**最近の消費者展開での進捗を活かして消費者市場攻略を本格化**するという戦略スクープ。**late last year から従業員に対しヘルス / トラベル / レシピ等のパーソナルクエリ処理品質改善をタスク化**

#### 公開された定量データ

| 指標 | 値 |
|------|---|
| **モバイルアプリ起動 → クエリ送信時間** | **5-6 秒 → 1 秒**（Mike Krieger 共同 Labs lead 発言） |
| **Apple App Store 無料アプリ順位（米国）** | **2 位**（1 位: ChatGPT、3 位: Gemini） |
| **3 月時点 日次サインアップ** | **100 万人 / 日**（年初比 **4 倍**） |
| **品質・洗練・パフォーマンスの 3 軸**で改善中（Krieger） | アプリ起動速度・モバイル UX 改善が最優先 |

#### Claude Code への含意（間接的）

Claude Code は元々消費者プロダクトではなく開発者プロダクトだが、**Anthropic 全社の "consumer pivot" は Claude Code の resourcing 配分や Pro / Max プランの roadmap に影響しうる**:
- **モバイルアプリ起動時間最適化への投資** → Claude Code iOS / Android 経由の Remote Agents（5/6 GA）にも波及する可能性
- **Pro / Max プランの "consumer 向け価格点" 維持インセンティブ** → 5/6 発表の Pro / Max ピーク時間制限撤廃 + 5 時間レート制限倍増の戦略的根拠を補強

- **情報源**:
  - [Bloomberg（5/7）](https://www.bloomberg.com/news/articles/2026-05-07/anthropic-is-making-claude-chatbot-more-appealing-to-consumers)
  - [Bloomberg Law（同記事）](https://news.bloomberglaw.com/artificial-intelligence/anthropic-is-making-claude-chatbot-more-appealing-to-consumers)
  - [Yahoo Finance 転載](https://finance.yahoo.com/news/anthropic-is-making-its-claude-chatbot-more-appealing-to-consumers-001336445.html)
  - [The Star 転載](https://www.thestar.com.my/tech/tech-news/2026/05/07/anthropic-is-making-its-claude-chatbot-more-appealing-to-consumers)
  - [Startup Fortune 分析](https://startupfortune.com/anthropics-consumer-claude-push-shows-even-safety-focused-labs-cannot-ignore-chatgpts-daily-use-dominance/)

---

### 4. 報道二次フォロー: 9to5Mac による Claude Managed Agents 3 機能の解説記事（5/7、新情報なし）

[9to5Mac "Anthropic updates Claude Managed Agents with three new features"（5/7）](https://9to5mac.com/2026/05/07/anthropic-updates-claude-managed-agents-with-three-new-features/) は 5/6 Code with Claude SF キーノート発表の **Dreaming（🔬 研究プレビュー）/ Outcomes（🧪 公開ベータ）/ Multi-Agent Orchestration（🧪 公開ベータ）** を再整理した二次解説記事。**新情報なし**だが、5/7 時点で消費者向けテック媒体まで波及した記録として保存。

---

## 影響なし / 非確認の情報

| 項目 | 状態 |
|------|------|
| **Claude Sonnet 4.8 / Jupiter 公式リリース** | ❓ 噂継続。5/6 キーノートで Vora が **"No new model today"** 明言、5/7-5/8 にも公式アナウンスなし。直近の 512K 行ソースコード leak（3/31）以外に新材料なし |
| **Claude Code v2.1.133+ リリース** | ❌ なし。最新は v2.1.132（5/6 22:08 UTC） |
| **Code with Claude London (5/19) / Tokyo (6/10) の追加発表** | ❌ なし（事前告知のみ。当日発表は引き続き要監視） |

---

## 5/7-5/8 のリリース一覧

| 日付 | 種別 | 内容 |
|------|------|------|
| 5/7 | Anthropic 公式ブログ | "Collaborate with Claude across Excel, PowerPoint, Word and Outlook" — Office 4 アプリ統合 GA |
| 5/7 | サードパーティー PR | Snyk Embeds Anthropic's Claude（Snyk AI Security Platform へ Claude 組み込み） |
| 5/7 | Bloomberg | Anthropic Is Making Its Claude Chatbot More Appealing to Consumers（消費者戦略スクープ） |
| 5/7 | 9to5Mac | Anthropic updates Claude Managed Agents with three new features（5/6 発表の二次解説、新情報なし） |
| 5/7 | Manila Times / GlobeNewswire | ICODA Becomes an Official Claude Partner（Claude Partner Network 拡大、小ニュース） |
| 5/8 | — | 本日 Anthropic 公式・Claude Code CLI 共に新規発表なし（執筆時点） |

---

## 情報源一覧

### Layer 2: 公式ブログ・APIドキュメント
- [Anthropic 公式ブログ - Collaborate with Claude across Excel, PowerPoint, Word and Outlook（5/7）](https://claude.com/blog/collaborate-with-claude-across-excel-powerpoint-word-and-outlook)
- [Anthropic Newsroom](https://www.anthropic.com/news)
- [Claude.com Blog](https://claude.com/blog)
- [Use Claude for Excel (Help Center)](https://support.claude.com/en/articles/12650343-use-claude-for-excel)
- [Use Claude for PowerPoint (Help Center)](https://support.claude.com/en/articles/13521390-use-claude-for-powerpoint)
- [Use Claude for Word (Help Center)](https://support.claude.com/en/articles/14465370-use-claude-for-word)
- [Work across Excel, PowerPoint, and Word (Help Center)](https://support.claude.com/en/articles/13892150-work-across-excel-powerpoint-and-word)
- [M365 Connector for Claude (Microsoft Marketplace)](https://marketplace.microsoft.com/en-us/product/saas/anthropic.microsoft-365-connector-for-claude)
- [Anthropic 公式ブログ - New in Claude Managed Agents（5/6 既出）](https://claude.com/blog/new-in-claude-managed-agents)

### Layer 3: ニュースメディア・サードパーティー PR
- [Bloomberg - Anthropic Is Making Its Claude Chatbot More Appealing to Consumers（5/7）](https://www.bloomberg.com/news/articles/2026-05-07/anthropic-is-making-claude-chatbot-more-appealing-to-consumers)
- [Bloomberg Law（同記事 mirror）](https://news.bloomberglaw.com/artificial-intelligence/anthropic-is-making-claude-chatbot-more-appealing-to-consumers)
- [Yahoo Finance（Bloomberg 転載）](https://finance.yahoo.com/news/anthropic-is-making-its-claude-chatbot-more-appealing-to-consumers-001336445.html)
- [The Star（Bloomberg 転載）](https://www.thestar.com.my/tech/tech-news/2026/05/07/anthropic-is-making-its-claude-chatbot-more-appealing-to-consumers)
- [Startup Fortune - Consumer Claude push 分析](https://startupfortune.com/anthropics-consumer-claude-push-shows-even-safety-focused-labs-cannot-ignore-chatgpts-daily-use-dominance/)
- [Snyk PR（Manila Times、5/8）](https://www.manilatimes.net/2026/05/08/tmt-newswire/globenewswire/snyk-embeds-anthropics-claude-to-advance-ai-powered-security-for-software-development/2338822)
- [Snyk PR（Daily Tribune、5/7）](https://www.daily-tribune.com/online_features/press_releases/snyk-embeds-anthropics-claude-to-advance-ai-powered-security-for-software-development/article_6d065327-a995-5f4d-bd88-1a20ce927137.html)
- [TipRanks - Snyk embeds Anthropic's Claude](https://www.tipranks.com/news/private-companies/snyk-embeds-anthropics-claude-to-scale-ai-native-application-security)
- [Yahoo Finance - Snyk embeds Anthropic's Claude](https://finance.yahoo.com/sectors/technology/articles/snyk-embeds-anthropics-claude-advance-174900036.html)
- [Snyk 公式ブログ - Why Anthropic Launching Claude Code Security Is Great News](https://snyk.io/articles/anthropic-launches-claude-code-security/)
- [9to5Mac - Anthropic updates Claude Managed Agents with three new features（5/7、二次解説）](https://9to5mac.com/2026/05/07/anthropic-updates-claude-managed-agents-with-three-new-features/)
- [Storyboard18 - Today in AI（5/7、Dreams + SpaceX サマリー）](https://www.storyboard18.com/digital/today-in-ai-anthropic-unveils-dreams-feature-for-claude-anthropic-taps-spacex-supercomputer-97463.htm)
- [Manila Times - ICODA Becomes an Official Claude Partner（5/7）](https://www.manilatimes.net/2026/05/07/tmt-newswire/globenewswire/icoda-becomes-an-official-claude-partner/2338149)
- [GuruFocus - Anthropic Enhances Claude Chatbot Amid Consumer Market Expansion（5/7）](https://www.gurufocus.com/news/8843353/anthropic-enhances-claude-chatbot-amid-consumer-market-expansion)
- [Meyka - Anthropic May 7: SpaceX Deal Doubles Claude Usage Limits](https://meyka.com/blog/anthropic-may-7-spacex-deal-doubles-claude-usage-limits-0705/)
- [Releasebot - Anthropic Release Notes May 2026](https://releasebot.io/updates/anthropic)
- [atalupadhyay - Anthropic's Claude Developer Conference 2026](https://atalupadhyay.wordpress.com/2026/05/07/anthropics-claude-developer-conference-2026-the-complete-guide-to-autonomous-software-engineering/)
