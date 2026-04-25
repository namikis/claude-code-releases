# Claude Code 調査レポート: Rate Limits API リリース・Anthropic × NEC 戦略提携・2026 米中間選挙セーフガード・Project Deal 公開

**調査日**: 2026-04-25
**対象期間**: 2026-04-24 前回レポート作成時点以降 〜 2026-04-25
**調査モード**: ニュースモード（Layer 2 公式ブログ・APIドキュメント / Layer 3 ニュースメディア。Layer 1 チェンジログは v2.1.119 以降の新リリースなし）
**備考**: Claude Code CLI は **v2.1.119（4/23 23:24 UTC）が依然として最新**。2026-04-24 のレポート（`2026-04-24_v2.1.119-postmortem-and-managed-agents-memory.md`）以降、CLI 側の新リリースは確認されず。本レポートは Layer 2/3 で発表された **Rate Limits API（4/24）**、**Anthropic × NEC 戦略提携（4/24）**、**米中間選挙セーフガード更新（4/24）**、**Project Deal 実験公開（4/24）**、および **GitHub Copilot Individual プラン縮小（4/24）の競合動向** をカバー

---

## 概要

- **Layer 2: Claude Platform リリースノート 4/24 エントリ追加**: **Rate Limits API**（管理者向け）が GA でリリース。組織・ワークスペース単位の設定済みレート制限を Admin API キーで照会可能。**ゲートウェイ・プロキシの自動同期、社内アラート、ワークスペース設定の監査** がユースケース
- **Layer 2: Anthropic Engineering Blog「Anthropic and NEC collaborate to build Japan's largest AI engineering workforce」**（2026-04-24）公開。**NEC が Anthropic 初の日本ベース Global Partner** に。**約 30,000 人の NEC グループ社員** に Claude を提供、Claude Cowork を全社展開予定、**金融・製造業・地方自治体・サイバーセキュリティ向け業界特化 AI ソリューション** を共同開発
- **Layer 2: Anthropic Blog「An update on our election safeguards」**（2026-04-24）公開。**2026 年米中間選挙** に向けた誤情報・有権者操作対策。Claude Opus 4.7・Sonnet 4.6 で **適切回答率 99.8〜100%**、**Claude UI 上で TurboVote バナー** を表示
- **Layer 2: Anthropic Research「Project Deal: our Claude-run marketplace experiment」**（2026-04-24）公開。**SF 本社の社員間マーケットプレイス** で Claude が双方の代理人として 186 件の取引（総額 $4,000+）を仲介。エージェント間交渉の実証実験
- **Layer 3: GitHub Copilot Individual プラン縮小**（2026-04-24）。**Pro/Pro+/Student の新規申込停止**、Pro から Opus モデル（4.5/4.6/4.7）削除。**Anthropic 4/22 Pro プラン Claude Code 削除事件** の翌週、競合 AI コーディングツール側でも同種のプラン構造見直しが発生

CLI バージョンは v2.1.119 のままだが、**プラットフォーム・エンタープライズ・政策面で重要な発表が集中した一日**となった。

---

## 主要な新機能・発表

### 1. Rate Limits API（2026-04-24）✅ GA

**情報源**: [Claude Platform Release Notes 2026-04-24](https://platform.claude.com/docs/en/release-notes/overview) / [Rate Limits API ドキュメント](https://platform.claude.com/docs/en/build-with-claude/rate-limits-api)

#### 概要

組織と各ワークスペースに設定されているレート制限を **プログラマティックに照会** できる新しい Admin API。Claude Console の **Limits** ページで表示される情報と同等のものを API 経由で取得可能。

- **エンドポイント**:
  - `GET /v1/organizations/rate_limits` — 組織レベルのレート制限を一覧
  - `GET /v1/organizations/workspaces/{workspace_id}/rate_limits` — 特定ワークスペースのオーバーライドを一覧
- **認証**: **Admin API キー（`sk-ant-admin...`）が必要**。組織の admin ロールメンバーのみ Console から発行可能。通常の API キーでは利用不可
- **対象範囲**: Messages API およびその関連リソース（Message Batches API、Files API、Token Counting API、Agent Skills、Web Search ツール）。**Claude Managed Agents は含まれない**

#### レート制限グループの構造

- **`group_type`**: 5 種類の値で制限カテゴリを識別
  - `model_group`: モデル群単位の制限（複数モデルバージョンが共有）
  - `batch`: Message Batches API
  - `token_count`: Token Counting API
  - `files`: Files API
  - `skills`: Agent Skills
  - `web_search`: Web Search ツール
- **`models` フィールド**: `model_group` エントリでは、その制限グループに属する全モデル ID とエイリアス（dated `claude-sonnet-4-5-20250929` および undated `claude-sonnet-4-5` の両方）を返す
- **`limits` フィールド**: `{type, value}` ペアの配列。`type` は `requests_per_minute` / `input_tokens_per_minute` / `output_tokens_per_minute` / `enqueued_batch_requests` 等

#### モデル指定検索

```bash
curl "https://api.anthropic.com/v1/organizations/rate_limits?model=claude-opus-4-7" \
  --header "anthropic-version: 2023-06-01" \
  --header "x-api-key: $ANTHROPIC_ADMIN_KEY"
```

任意のモデル ID/エイリアスを `model` クエリパラメータで指定すると、そのモデルが属するグループのみ返す。**マッチしない場合は 404**。`model` パラメータは organization エンドポイントでのみ利用可能。

#### ワークスペースのオーバーライド構造

- レスポンスには **オーバーライドのみ** を含む
- グループ自体が欠落 → 組織レベルから継承（無制限ではない）
- グループ内で特定の limiter type が欠落 → その limiter は組織レベルから継承
- 各 limiter エントリには `org_limit`（組織レベルの値、未設定なら `null`）が併記される

#### 主なユースケース

1. **ゲートウェイ・プロキシの同期**: 起動時とスケジュール実行で現在の制限を読み取り、Anthropic 側の調整がドリフトしないようハードコード値を排除
2. **内部アラート**: [Usage and Cost API](https://platform.claude.com/docs/en/build-with-claude/usage-cost-api) からの実利用データと、設定済み制限を比較
3. **ワークスペース設定監査**: プロビジョニング自動化で設定したワークスペースのオーバーライドが期待値と一致しているか確認

#### 制限事項

- **このAPIで制限値を更新することはできない**（読み取り専用）。設定変更は Console の Workspaces → Limits タブから手動で行う
- ページネーションは現在常に単一ページ（`next_page` は常に `null`）。将来の拡張を見越して `next_page` でループする実装が推奨される
- デフォルトワークスペースはオーバーライドを持てないため、ワークスペースエンドポイントには現れない（組織エンドポイントを使用）

---

### 2. Anthropic × NEC 戦略提携（2026-04-24）✅ 発表・実行段階

**情報源**: [Anthropic News: Anthropic and NEC collaborate](https://www.anthropic.com/news/anthropic-nec) / [NEC Press Release 2026-04-23](https://www.nec.com/en/press/202604/global_20260423_01.html)

#### 主要ポイント

- **NEC が Anthropic 初の日本ベース Global Partner** として参加
- 米国時間 4/24（日本時間 4/23）に発表
- **NEC グループ約 30,000 人の社員** に Claude を提供。日本国内外の拠点を含む
- **Claude Cowork を全社展開** 予定（NEC の長期的な「Client Zero」イニシアチブの一環）

#### 共同開発領域

| 領域 | 内容 |
|------|------|
| **金融** | 業界規制対応、ストリクトコンプライアンス向け AI ソリューション |
| **製造業** | 高品質要件を満たす業界特化 AI |
| **地方自治体** | 日本独自の法制度対応、行政用 AI |
| **サイバーセキュリティ** | NEC の **SOC（Security Operations Center）サービス** に Claude を統合。次世代サイバーセキュリティオファリングに組み込み |

#### 戦略的意味合い

- **日本市場における Anthropic のエンタープライズ展開を加速**。日本の金融・公共セクターは厳格な規制・品質要件があり、NEC の現地パートナーシップが入り口となる
- NEC は社内に **Center of Excellence** を設立し、外部顧客提供前に自社で運用検証
- NEC BluStellar Scenario プログラムへの統合
- **2026 年 4 月の Anthropic 一連のエンタープライズ提携**（Freshfields × Cowork 5,700 人、Microsoft 365 全プラン展開等）に続く大型案件

#### 確度

✅ **発表済み・契約締結済み**。財務条件（契約金額、期間等）は非開示。社員への展開時期は段階的に実施予定。

---

### 3. 2026 米中間選挙向けセーフガード更新（2026-04-24）✅ GA

**情報源**: [Anthropic News: An update on our election safeguards](https://www.anthropic.com/news/election-safeguards-update) / [Decrypt 報道](https://decrypt.co/365486/anthropic-election-safeguards-claude-ai-us-midterms)

#### 概要

2026 年 11 月の米中間選挙、および世界各地の主要選挙に向けて、Claude が誤情報拡散・有権者操作の道具として悪用されないための **多層的セーフガード** を発表。

#### 主要対策

1. **自動検出システム**: 選挙関連の不正利用パターンを検出
2. **影響工作（Influence Operation）に対するストレステスト**: マルチターン会話シミュレーションで耐性を評価
3. **TurboVote 連携**: 投票・選挙情報を Claude UI 上の **エレクションバナー** から TurboVote（Democracy Works 運営の超党派サービス）にリダイレクト。投票登録、投票所、選挙日程、投票用紙情報をリアルタイム提供

#### モデル別評価結果

| モデル | 適切回答率 | 政治的中立性スコア | 影響工作シナリオ耐性 |
|--------|-----------|-------------------|------------------|
| **Claude Opus 4.7** | **100%** | 95% | 94% |
| **Claude Sonnet 4.6** | 99.8% | 96% | 90% |

#### 利用ポリシーの明文化

Claude の利用ポリシーで以下を明示的に禁止：

- 欺瞞的政治キャンペーンの実行
- 政治的議論に影響を与えるためのフェイクデジタルコンテンツ作成
- 有権者詐欺
- 投票システムへの干渉
- 投票プロセスに関する誤情報の拡散

#### Claude Code への影響

直接的な機能変更はないが、**システムプロンプト・モデル動作への変更** は Claude Code 経由でも観測される可能性がある。特に政治・選挙関連の質問への応答パターンが変化する可能性。

---

### 4. Project Deal: Claude 運用マーケットプレイス実験（2026-04-24）📢 研究公開

**情報源**: [Anthropic Project Deal](https://www.anthropic.com/features/project-deal) / [@AnthropicAI on X](https://x.com/AnthropicAI/status/2047728360818696302)

#### 概要

サンフランシスコ本社の社員向けに **Claude が双方の代理人として動く分類広告マーケットプレイス** を実験運用。Craigslist のような形式だが、すべての取引が AI モデル（Claude）によって行われる。

#### 実験の流れ

- **2025 年 12 月**: Claude が個別に社員にインタビューし、売却したい所有物・購入したい品物を聞き取り
- 各エージェントに **$100 の予算** を割り当て
- マッチング・価格提案・カウンターオファー・合意形成を **すべて自然言語で実行**（事前定義された交渉プロトコルなし）

#### 結果

| 指標 | 値 |
|------|---|
| 参加エージェント数 | 69 |
| 成立した取引数 | **186 件** |
| 出品アイテム数 | 500+ |
| 総取引額 | **$4,000+** |
| 参加社員の満足度 | 「同様のサービスに料金を払ってもよい」との声多数 |

#### 戦略的含意

- **AI エージェント間の自律的交渉** が現実的なマーケットプレイス運営に十分機能することを実証
- Claude Managed Agents、Auto Mode 等の **長期実行エージェント基盤** の応用例として位置付け可能
- 将来的にエンタープライズ調達・社内マーケット等への応用が示唆される

#### 確度

📢 **研究プロジェクトの公開**。製品化は明示されていないが、研究結果として公開された。

---

### 5. 競合動向: GitHub Copilot Individual プラン縮小（2026-04-24）

**情報源**: [GitHub Blog: Changes to GitHub Copilot Individual plans](https://github.blog/news-insights/company-news/changes-to-github-copilot-individual-plans/) / [GitHub Changelog 2026-04-20](https://github.blog/changelog/2026-04-20-changes-to-github-copilot-plans-for-individuals/) / [GitHub Discussion #192963](https://github.com/orgs/community/discussions/192963)

#### 概要

GitHub が個人向け Copilot プランの **縮小** を 4/24 に発表。**Anthropic 4/22 Pro プラン Claude Code 削除事件**（簡迅速 revert）と同週に発生した、AI コーディングツール業界全体のコスト構造見直しの動き。

#### 主要変更

| 変更 | 内容 |
|------|------|
| **新規申込停止** | Pro / Pro+ / Student プランの新規サインアップを一時停止 |
| **利用制限の強化** | Pro+ は Pro の **5 倍以上** の上限。VS Code と Copilot CLI で利用状況を表示 |
| **モデル可用性変更** | Pro から **Opus モデル全廃**。Pro+ では Opus 4.7 のみ残し、Opus 4.5/4.6 を削除 |
| **返金ポリシー** | Pro / Pro+ ユーザーは **5/20 まで** にキャンセルすれば残期間の返金を受けられる |

#### 根本原因（GitHub の説明）

> エージェンティックワークフローが Copilot のコンピュート需要を根本的に変えた。長時間並列セッションが、当初のプラン構造が想定したよりも遥かに多くのリソースを消費している。

#### Anthropic との対比

- **Anthropic（4/21〜22）**: Pro プランから Claude Code を一時削除 → 48 時間以内に revert（[2026-04-22 レポート](2026-04-22_cisa-access-and-trump-deal-possible.md)参照）
- **GitHub（4/24）**: Pro 新規受付停止＋ Opus モデル削除（恒久的な構造変更）
- 両社とも **「コーディングエージェントの長期実行」が既存プラン構造の前提を破壊している** ことを認める形になった
- 競合関係上、**Claude Code（Pro 維持）vs Copilot（Pro 縮小）** の構図が鮮明化。Anthropic は Pro 維持を続けるか今後注視が必要

---

## バグ修正・パフォーマンス改善

本期間中、Claude Code CLI 側の新リリースなし（v2.1.119 が継続）。Layer 2 / 3 では以下の継続性のあるトピックが報じられた：

- **品質劣化 postmortem の継続報道**: Fortune・The Decoder 等が 4/24 に追加報道。Anthropic の対応（4/23 利用制限リセット、4/20 修正完了）への評価は概ね肯定的だが、**サブスク解約者** も一定数存在することが Fortune に紹介された
- **Mythos / Sonnet 4.8 関連の継続的リーク**: 新たな大きな進展なし。**5 月予定の Sonnet 4.8 リリース** に向けた期待が継続

---

## リリース・発表一覧

### Layer 1: CLI チェンジログ
| バージョン | 日付 | 主要変更 |
|---------|------|--------|
| (なし) | — | v2.1.119 以降の新リリースなし |

### Layer 2: 公式発表
| 日付 | 種別 | 内容 |
|------|------|------|
| 2026-04-24 | プラットフォーム | **Rate Limits API GA** リリース |
| 2026-04-24 | エンタープライズ提携 | **Anthropic × NEC** Global Partner 提携、約 30,000 人展開 |
| 2026-04-24 | 政策・安全性 | **2026 米中間選挙セーフガード** 更新（TurboVote 連携） |
| 2026-04-24 | リサーチ | **Project Deal**: Claude 双方代理人マーケットプレイス実験公開 |

### Layer 3: ニュースメディア
| 日付 | メディア | 内容 |
|------|---------|------|
| 2026-04-24 | GitHub Blog | **Copilot Individual** プラン縮小（Pro 新規停止、Opus 削除） |
| 2026-04-24 | Fortune | Anthropic 品質劣化の続報、サブスク解約者の存在を紹介 |
| 2026-04-24 | The Decoder | Anthropic が品質問題確認・厳格な品質管理を約束 |
| 2026-04-24 | Dataconomy | Anthropic、Claude Code 意図的低速化を否定 |
| 2026-04-24 | Cybertechnology Insights | NEC 提携を「日本市場進出の戦略的拠点確保」と分析 |

---

## 情報源一覧

### Layer 2: 公式
- [Claude Platform Release Notes - 2026-04-24 entry](https://platform.claude.com/docs/en/release-notes/overview)
- [Rate Limits API ドキュメント](https://platform.claude.com/docs/en/build-with-claude/rate-limits-api)
- [Anthropic and NEC collaborate to build Japan's largest AI engineering workforce](https://www.anthropic.com/news/anthropic-nec)
- [NEC Press Release 2026-04-23](https://www.nec.com/en/press/202604/global_20260423_01.html)
- [An update on our election safeguards](https://www.anthropic.com/news/election-safeguards-update)
- [Project Deal: our Claude-run marketplace experiment](https://www.anthropic.com/features/project-deal)
- [@AnthropicAI on X (Project Deal announcement)](https://x.com/AnthropicAI/status/2047728360818696302)

### Layer 3: ニュース・分析
- [Fortune: Anthropic says engineering missteps were behind Claude Code's month-long decline](https://fortune.com/2026/04/24/anthropic-engineering-missteps-claude-code-performance-decline-user-backlash/)
- [The Decoder: Anthropic confirms Claude Code problems and promises stricter quality controls](https://the-decoder.com/anthropic-confirms-claude-code-problems-and-promises-stricter-quality-controls/)
- [Dataconomy: Anthropic Denies Intentional Slowdown Of Claude Code](https://dataconomy.com/2026/04/24/anthropic-denies-intentional-slowdown-of-claude-code/)
- [TechBriefly: Anthropic resolves Claude Code bugs after nerfing allegations](https://techbriefly.com/2026/04/24/anthropic-resolves-claude-code-bugs-after-nerfing-allegations/)
- [Decrypt: Anthropic Rolls Out Election Safeguards for Claude AI Ahead of US Midterms](https://decrypt.co/365486/anthropic-election-safeguards-claude-ai-us-midterms)
- [Nikkei Asia: NEC to tie up with Anthropic to cultivate corporate AI demand](https://asia.nikkei.com/business/technology/artificial-intelligence/nec-to-tie-up-with-anthropic-to-cultivate-corporate-ai-demand)
- [GitHub Blog: Changes to GitHub Copilot Individual plans](https://github.blog/news-insights/company-news/changes-to-github-copilot-individual-plans/)
- [GitHub Changelog 2026-04-20: Changes to GitHub Copilot plans for individuals](https://github.blog/changelog/2026-04-20-changes-to-github-copilot-plans-for-individuals/)
- [Cybertechnology Insights: NEC Partner With Anthropic To Expand Enterprise AI in Japan](https://cybertechnologyinsights.com/ai-security/nec-partner-with-anthropic-to-expand-enterprise-ai-in-japan/)
- [Releasebot - Anthropic Updates April 2026](https://releasebot.io/updates/anthropic)
