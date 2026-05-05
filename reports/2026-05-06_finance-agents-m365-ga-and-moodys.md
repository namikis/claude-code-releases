# 2026-05-06 ニュースモード調査: 5/5 Financial Services Briefing で 10 Finance Agent Templates／Microsoft 365 完全統合 GA／Moody's MCP App／Dario Amodei × Jamie Dimon 初共演／5/6 Code with Claude SF キーノート目前

**調査モード:** ニュースモード（Layer 2 + Layer 3、Layer 1 はスキップ）
**調査日:** 2026-05-06
**対象期間:** 2026-05-05 〜 2026-05-06 朝（前回 5/5 レポート以降）

---

## 概要

前回（5/5 朝）レポート時点では「The Briefing: Financial Services は予定通り開催」までしか把握できていなかったが、**5/5 NYC livestream で Anthropic は金融セクター向けの大型製品スタックを公式発表した**。中核は ① **10 種類の Finance Agent Templates** を Claude Cowork / Claude Code プラグインおよび Claude Managed Agents Cookbook として公開、② **Microsoft 365 アドイン（Excel / PowerPoint / Word が GA、Outlook が beta）でアプリ間コンテキスト自動キャリーオーバー**、③ **Moody's が信用格付けプラットフォームを Claude にネイティブアプリとして埋め込み**（600M 社の信用・リスクデータ）、④ **Anthropic CEO Dario Amodei と JPMorgan Chase CEO Jamie Dimon が初の共同ステージ登壇**、⑤ Claude Opus 4.7 が **Vals AI Finance Agent benchmark で 64.37%** を達成（業界トップ）。これらはいずれも Claude Code / Cowork ユーザーから即座に利用可能。

戦略的には、5/4 の Blackstone × H&F × Goldman Sachs JV（$1.5B、PE 傘下中規模企業ターゲット）と組み合わせて、**「中規模企業 → JV による implementation サービス」「大規模機関 → 自社で agent 構築する DIY ツールスタック」の二段構え**が完成。Fortune は「Anthropic は単なる AI ソフト会社から脱却し、ウォール街のオペレーティング層構築を目指す」と分析。

**5/6 Code with Claude SF キーノート（9:00 AM PT = 日本時間 5/7 1:00 AM）はまだ開催前**（本レポート公開時点）で、Sonnet 4.8 / Claude Jupiter / Claude Cardinal / KAIROS など各種リーク・噂は ❓ 噂・未確認のまま据え置き。Code with Claude SF の発表内容は次回（5/7）レポートで反映予定。

**Layer 1（CLI チェンジログ）はスキップ**。GitHub Releases / CHANGELOG.md は前回 v2.1.128（5/4 23:01 UTC）以降の更新なし。

---

## Layer 2: 公式発表（5/5 The Briefing: Financial Services）

### 1. 10 Finance Agent Templates（2026-05-05 GA）

**発表**: Anthropic Newsroom「Agents for financial services and insurance」（5/5）

#### テンプレート一覧（10 種類）

**研究・顧客対応系（5 種）:**
| テンプレート | 用途 |
|------------|------|
| **Pitch builder** | ピッチブック / 提案書の自動構築 |
| **Meeting preparer** | 会議資料・参加者ブリーフィング準備 |
| **Earnings reviewer** | 決算（Earnings）レビューと差分分析 |
| **Model builder** | 財務モデル（DCF / LBO 等）構築 |
| **Market researcher** | 市場・業界・コンペ分析 |

**財務・オペレーション系（5 種）:**
| テンプレート | 用途 |
|------------|------|
| **Valuation reviewer** | 評価査証（valuation review、comparables 選定 + methodology check） |
| **General ledger reconciler** | 総勘定元帳調整 |
| **Month-end closer** | 月次決算クロージング |
| **Statement auditor** | 決算書監査 |
| **KYC screener** | 顧客確認スクリーニング（Know Your Customer） |

#### アーキテクチャ（3 要素構成）

各テンプレートは「**reference architecture**」として以下を packaging：

1. **Skills** — タスク用の指示・ドメイン知識（markdown SKILL.md）
2. **Connectors** — 必要データへの governed access（MCP / 専用コネクタ）
3. **Subagents** — メインエージェントから呼び出される追加 Claude モデル（comparables 選定 / methodology チェック等の sub-task 専用）

#### 提供形態（3 経路）

| 経路 | 形態 | 対象 |
|------|------|------|
| **Claude Cowork** | プラグイン | 有料プラン（Pro / Max / Team / Enterprise） |
| **Claude Code** | プラグイン | 有料プラン |
| **Claude Managed Agents** | Cookbook（コピー可能なコードスニペット） | パブリックベータ |

#### 推奨モデル

**Claude Opus 4.7** が推奨。**Vals AI Finance Agent benchmark で 64.37%** を達成（業界最高、5/5 時点）。

#### 重要なメッセージング

The Register 記事は「64.37% は **independent deployment** には不十分」とのニュアンスを明示し、Anthropic の position として「ユーザーは review / iterate / approve のループに firmly に留まる」と言及。**これは Anthropic が Auto Mode / Cowork で繰り返している「Human in the Loop」原則の延長**。

#### リリース状態

- ✅ **GA**（10 テンプレート全て即日利用可能、5/5 から）
- 一部（Managed Agents Cookbook）はパブリックベータ扱い

---

### 2. Microsoft 365 完全統合（2026-05-05 GA）

**発表**: Anthropic Newsroom（5/5）/ Fortune（5/5）

#### 統合内容

| アプリ | ステータス | 提供形態 |
|--------|----------|---------|
| **Microsoft Excel** | ✅ GA | Add-in（Microsoft AppSource、Insert > Get Add-ins から「Claude by Anthropic」） |
| **Microsoft PowerPoint** | ✅ GA | Add-in |
| **Microsoft Word** | ✅ GA | Add-in（4 月にすでに add-in 自体は出ていたが、5/5 で M365 統合体験として正式 GA 扱い） |
| **Microsoft Outlook** | 🧪 ベータ | Add-in（5/5 ベータ launch、Outlook が新規追加） |

#### 重要な改善点

**アプリ間コンテキストの自動キャリーオーバー** — Excel で行った分析がそのまま PowerPoint デッキに引き継がれ、「再説明不要」で deck 作成が完了。これまで M365 アプリ間で手動コピペが必要だったコンテキストが自動的に persist。**Outlook 統合により、メールの内容を即座に他アプリへ橋渡し**可能（beta）。

#### Claude Cowork / Claude Code との関係

M365 add-in 群は Claude Cowork を bridge にして Claude Code とコンテキスト共有が可能（Cowork セッションが M365 アプリ間および Claude Code 間の hub）。

#### リリース状態

- ✅ **GA**（Excel / PowerPoint / Word add-in）
- 🧪 **ベータ**（Outlook add-in）
- Windows / Mac / Web 全プラットフォーム対応

---

### 3. Moody's MCP App（2026-05-05、共同顧客向け）

**発表**: Anthropic Newsroom（5/5）

#### 統合内容

- **Moody's の信用格付け（credit ratings）プラットフォーム全体を Claude にネイティブアプリとして埋め込み**
- **600M 社（公開・非公開）の信用 / リスク独自データ**にアクセス可能
- MCP 経由（Anthropic と Moody's の共同顧客向け、Claude を離れずに分析完結）

#### 戦略的意義

- 金融機関向け Claude エージェントが **ファクトベースの信用評価データを inline で参照**できるようになる（KYC screener / Valuation reviewer / Pitch builder 等の Finance Agent Templates との直接統合）
- **Bloomberg / FactSet / S&P Capital IQ 等の伝統的データプロバイダ陣営に対する Anthropic 経由の入り口**として機能

#### リリース状態

- ✅ **GA**（Anthropic / Moody's の共同顧客向け、有料プランベース）

---

### 4. Dario Amodei × Jamie Dimon 初共同ステージ（2026-05-05）

**発表**: Fortune / Bloomberg（5/5）

- **JPMorgan Chase 会長兼 CEO の Jamie Dimon が Anthropic CEO Dario Amodei と初共演**
- ステージで議論された主要トピック：
  - AI が市場・労働力・経済に与える影響
  - **Dimon: 「20 分で Claude にダッシュボードを作らせた」と称賛**
  - **Amodei: Anthropic の「80x growth」について「fundamental uncertainty」を認めつつ、根本的な楽観論を表明**
- **両者とも雇用への悲観論を拒否**しつつ、不確実性の幅を率直に認めるトーン
- ウォール街最大手バンクのトップが Anthropic ステージに登壇 → **JPMorgan が Anthropic の早期参考導入企業として名乗りを上げた**シグナル

---

### 5. The Register / Fortune の総括メッセージ

#### Fortune の論調

> **「Anthropic は単なる AI ソフト会社から脱却し、ウォール街のオペレーティング層構築を目指す」**
> 戦略は二段構え：
> 1. 大規模機関向け：自社で AI agent 構築 / 運用できる **DIY ツールスタック**（Cowork / Code / Managed Agents / Finance Templates / M365 / Moody's）
> 2. 中堅企業向け：Blackstone × H&F × Goldman Sachs JV（$1.5B）による implementation サービス

#### The Register の論調

> Finance Agent Templates の Vals AI score 64.37% は **independent deployment には不十分**。Anthropic 自身が「ユーザーは review / iterate / approve のループに firmly に留まる」と明記しており、**Auto Mode / Cowork で繰り返している「Human in the Loop」原則の延長**。

---

## Layer 3: メディア・コミュニティ

### Code with Claude SF（5/6）開催前の最新リーク

5/5 公開の Wes Roth ツイート（X）が **「Claude Cardinal」**（内部コードネーム）の存在をリーク：

| 項目 | 内容 |
|------|------|
| **コードネーム** | Claude Cardinal |
| **機能** | ユーザー対話の「visual retrospective（視覚的振り返り）」 |
| **詳細** | user activity / memory usage の visual analytics |
| **発表期待** | 5/6 Code with Claude SF キーノートで発表される可能性 |
| **確度** | ❓ 噂・未確認（Anthropic 公式言及なし） |

**注**: Anthropic は本年 3/12 に Claude のメインアプリ向けに「interactive charts and diagrams」機能を出している（free tier 含む全プラン）。Cardinal はこれとは異なり、**「ユーザー自身の使い方を視覚化する」メタな retrospective ツール**と位置づけられている。Claude Code セッションサマリーの強化版／メモリ管理 UI / usage tracking 系統と連動する可能性が考えられる。

### Code with Claude SF 期待リスト（5/6 9:00 AM PT 開催、未開催）

| 候補 | 確度 | 根拠 |
|------|-----|------|
| **Sonnet 4.8 GA リリース** | ❓ 噂継続 | 3/31 ソースコードリーク内 `sonnet-4-8` 言及 + Opus 4.7 GA（4/16）から約 3 週間後パターン |
| **Claude Jupiter / 次世代モデル** | ❓ 噂継続 | リーク内 `claude-jupiter` + 5/1 TestingCatalog Jupiter-v1-p レッドチーム報告 + 過去パターン（Neptune→Claude 4 数週間後） |
| **Claude Cardinal**（visual retrospective） | ❓ 噂・新規（5/5 Wes Roth リーク） | 内部コードネーム |
| **KAIROS（バックグラウンドエージェント）** | ❓ 噂継続 | リーク内 "always-on background agent" フラグ |
| **Computer Use の研究プレビュー → ベータ昇格** | ❓ 推測 | 現状 Pro / Max・macOS 限定 |
| **Routines（4/15 開始）の GA 化** | ❓ 推測 | 現状研究プレビュー |
| **Managed Agents 関連の新機能** | ❓ 推測 | 4/8 公開ベータ → 4/23 Memory 公開ベータ追加 |

**重要**: いずれも Anthropic 公式確認なし。5/6 キーノート結果で次回（5/7）レポートで一括更新予定。

---

## リリース状態サマリー（5/5 〜 5/6 朝）

| 機能 | 確度 | 提供開始 | 対象プラン |
|------|------|---------|----------|
| 10 Finance Agent Templates | ✅ GA | 2026-05-05 | 有料プラン全般（Cowork / Code プラグイン）+ Managed Agents Cookbook（パブリックベータ） |
| Microsoft 365 統合（Excel / PowerPoint / Word） | ✅ GA | 2026-05-05（M365 統合体験として） | 全プラン（add-in 自体は無料、Claude 利用には有料サブスクリプション） |
| Microsoft 365 統合（Outlook） | 🧪 ベータ | 2026-05-05 | 全プラン |
| Moody's MCP App | ✅ GA | 2026-05-05 | Anthropic / Moody's 共同顧客の有料プラン |
| Claude Cardinal（visual retrospective） | ❓ 噂 | 未発表（5/6 期待） | 不明 |
| Sonnet 4.8 / Claude Jupiter / KAIROS | ❓ 噂 | 未発表（5/6 期待） | 不明 |

---

## 情報源一覧

### Layer 2: 公式

- [Anthropic Newsroom: Agents for financial services and insurance（5/5）](https://www.anthropic.com/news/finance-agents)
- [Anthropic Newsroom トップ](https://www.anthropic.com/news)
- [Anthropic Events: The Briefing: Financial Services（5/5、NYC livestream）](https://www.anthropic.com/events/the-briefing-financial-services-virtual-event)
- [Code with Claude San Francisco — May 6, 2026](https://claude.com/code-with-claude/san-francisco)
- [Claude Help Center: Use Claude for PowerPoint](https://support.claude.com/en/articles/13521390-use-claude-for-powerpoint)
- [Claude Help Center: Use Claude for Excel](https://support.claude.com/en/articles/12650343-use-claude-for-excel)

### Layer 3: メディア

- [The Register: Anthropic unleashes finance agents for Claude（5/5）](https://www.theregister.com/2026/05/05/anthropic_unleashes_finance_agents_claude/)
- [Fortune: Anthropic deepens push into Wall Street with new AI agents, full Microsoft 365 integration, Moody's data partnership（5/5）](https://fortune.com/2026/05/05/anthropic-wall-street-financial-services-agents-jamie-dimon/)
- [Bloomberg: Anthropic Unveils AI Agents to Field Financial Services Tasks（5/5）](https://www.bloomberg.com/news/articles/2026-05-05/anthropic-unveils-ai-agents-to-field-financial-services-tasks)
- [PYMNTS: Anthropic Targets Financial Services Space With New AI Agents](https://www.pymnts.com/news/artificial-intelligence/2026/anthropic-targets-financial-services-space-with-new-ai-agents/)
- [Crypto Briefing: Anthropic expands Claude into finance workflows with Microsoft 365 integration](https://cryptobriefing.com/claude-finance-integration-microsoft-365/)
- [The Next Web: Anthropic ships ten financial-services agents and pulls Opus 4.7 deeper into FIs](https://thenextweb.com/news/anthropic-financial-services-agents-claude-opus-4-7-fis)
- [Let's Data Science: Anthropic Launches Ten Finance Agent Templates for Claude](https://letsdatascience.com/news/anthropic-launches-ten-finance-agent-templates-for-claude-6516f048)
- [Wes Roth (X): Anthropic Cardinal リーク（5/5）](https://x.com/WesRoth/status/2050168360420151591)
- [TestingCatalog: Anthropic tests Jupiter-v1-p before potential launch on May 6](https://www.testingcatalog.com/anthropic-tests-jupiter-v1-p-before-potential-launch-on-may-6/)

---

## CURRENT_FEATURES.md への反映サマリー

1. **Microsoft 365 統合セクションを大幅更新** — Excel / PowerPoint / Word add-in を「✅ GA（M365 統合体験として 5/5 正式 GA、アプリ間コンテキスト自動キャリーオーバー）」に統一、**Outlook add-in を「🧪 ベータ（5/5 開始）」として新規追加**
2. **「Finance Agent Templates（10 種、5/5 GA）」をエンタープライズ・専用エージェント系に新規セクション追加** — Pitch builder / Meeting preparer / Earnings reviewer / Model builder / Market researcher / Valuation reviewer / General ledger reconciler / Month-end closer / Statement auditor / KYC screener、Skills + Connectors + Subagents 構成、Claude Cowork / Code / Managed Agents で利用可能
3. **「Moody's MCP App」を MCP コネクタセクションに追加** — 600M 社の信用格付け / リスクデータ、共同顧客向け GA
4. **「Vals AI Finance Agent benchmark で Opus 4.7 が 64.37%」をモデル性能セクションに追記**
5. **「予定・未確認情報」セクションに「Claude Cardinal（visual retrospective、❓ 噂）」を新規追加**、5/6 Code with Claude SF 期待リストを最終確認日 2026-05-06 に更新
6. **業界連携セクションに「JPMorgan Chase / Jamie Dimon が 5/5 NYC イベントで Anthropic ステージに登壇」を追加**
7. 最終更新日を 2026-05-06 に更新
