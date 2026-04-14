# Deep Dive: Claude for Office（Microsoft Office Add-ins）

**調査日:** 2026-04-14
**関連する日次レポート:** [2026-04-14 v2.1.105・Word Add-in GA](../reports/2026-04-14_v2.1.105-word-addin-and-opus-4.7-leak.md) / [2026-04-07 M365全プラン展開](../reports/2026-04-07_m365-expansion-and-deny-rule-vulnerability.md)

## 概要

Claude for OfficeはAnthropicが提供するMicrosoft Office（Word・Excel・PowerPoint）向けのネイティブAdd-inスイートである。Microsoft AppSourceマーケットプレイスから入手でき、各Officeアプリ内のサイドバーとしてClaudeを直接利用可能。2026年4月13日のWord Add-in GA化により、Office三大アプリすべてでの統合が完了した。クロスアプリ共有コンテキスト機能により、Word・Excel・PowerPoint間でシームレスにデータと会話の文脈を引き継げる点が最大の特徴。

## 背景知識・技術解説

### そもそも何か

Claude for Officeは、AIチャットボットを既存のOffice作業環境に直接組み込むAdd-inである。ユーザーはブラウザやClaude.aiとOfficeアプリの間を行き来する必要がなく、Word・Excel・PowerPoint内のサイドパネルからClaudeに直接指示を出し、ドキュメントの読み取り・編集・分析を実行できる。技術的にはMicrosoft Office Add-inフレームワーク（Office.js）を使用しており、Anthropic APIとのバックエンド通信を行う。

なお、Claude for OfficeとMicrosoft 365コネクタは別の機能である：
- **Claude for Office（本調査対象）**: Word/Excel/PowerPoint内でClaudeを使うAdd-in
- **Microsoft 365コネクタ**: Claude.ai側からSharePoint・OneDrive・Outlook・Teamsのデータにアクセスするための連携機能

### なぜ重要か

Microsoft Officeは世界で15億人以上が使用するデファクトの業務ソフトウェアである。Officeネイティブ統合により、Claudeは「AIチャットツール」から「日常業務ツール内蔵のアシスタント」にポジションが変わる。特に法務・金融・コンサルティングなどの文書集約型業界では、ドキュメント作業中にコンテキストを失わずにAIを活用できる点が大きい。

Microsoft自身のCopilotとの直接競合でもあり、Anthropicがプラットフォーム戦略としてMicrosoftエコシステム内に存在感を確立した重要な一手。Copilotの有料版普及率がMicrosoft 365顧客ベースの約3%に留まる中、代替としてのポジションを狙っている。

### これまでの経緯

| 時期 | 出来事 |
|------|--------|
| 2025年10月 | Microsoft 365とClaude のエンタープライズ向け初期統合 |
| 2026年1月7日 | Claudeが正式にMicrosoftデータプロセッサとなり、M365のセキュリティ・コンプライアンスフレームワーク内で運用開始 |
| 2026年1月24日 | Claude for ExcelがProプラン（$20/月）以上に提供開始 |
| 2026年2月 | Claude for Excel・PowerPoint正式リリース。法務プラグイン（Claude Cowork向け）も同時期に提供 |
| 2026年3月11日 | Claude for OfficeがPro・Team・Enterprise全プランで提供開始。限定的な無料ティアも追加 |
| 2026年3月 | Excel↔PowerPoint間のクロスアプリ共有コンテキスト機能を追加 |
| 2026年4月7日 | Microsoft 365コネクタが無料プランを含む全プランに展開 |
| 2026年4月10日 | Claude for Word パブリックベータ開始（Mac・Windows） |
| 2026年4月13日 | Claude for Word GA化 → Office三大アプリの完全統合が完了 |

## 機能の詳細

### Claude for Word

Word内サイドバーとして動作。文書の読み取り・編集・分析を実行。

**主な機能:**
- **ドキュメント分析**: 質問に対しセクション単位のクリック可能な引用付きで回答
- **編集**: 選択テキストの書式・スタイル・番号付けを保持したまま編集
- **Track Changes統合**: AIの編集がすべてWord標準の変更追跡として表示
- **コメントスレッド処理**: 査読者コメントへの一括対応
- **セマンティック検索**: 文書内の条項や用語を意味ベースで検索
- **テンプレート入力**: 契約書等のテンプレートフィールドの自動入力

**法務向けユースケース:**
- 契約条件の要約（当事者、期限、準拠法等）
- 市場標準との乖離条項の特定
- インデムニティ条項の相互化
- 相手方修正案の分析

### Claude for Excel

スプレッドシートの分析・構築・デバッグを実行。

**主な機能:**
- **データ分析**: 複数タブのワークブックを横断的に読み取り、セルレベルの引用付きで回答
- **数式サポート**: 数式の説明（平易な言語）、デバッグ（#REF!、#VALUE!、循環参照等）、新規作成
- **ピボットテーブル**: 作成・編集（ソート、フィルター、スキーマ変更）
- **チャート**: 作成・編集・可視化
- **条件付き書式**: 設定・修正
- **データ検証**: ルール設定
- **モデル選択**: Sonnet 4.6（高速）/ Opus 4.6（高性能）を切り替え可能
- **MCPコネクタ**: S&P Global、LSEG、Daloopa、Pitchbook、Moody's、FactSet等の外部データソースと直接連携

**非対応項目:** マクロ、VBA、データテーブル

### Claude for PowerPoint

プレゼンテーションの生成・編集・リファインを実行。

**主な機能:**
- **テンプレート認識**: 既存テンプレートのレイアウト・フォント・色・マスターを自動読み取り
- **スライド生成**: 自然言語からデッキ全体の構造を生成
- **個別編集**: 特定スライドのピンポイント編集
- **図表変換**: 箇条書きをネイティブPowerPointチャート・図表に変換
- **コネクタ**: 外部ツールからのデータ取り込み

### クロスアプリ共有コンテキスト

2026年3月に導入された最大の差別化機能。

**仕組み:**
- Word・Excel・PowerPointのAdd-in間で会話履歴・データ参照・分析結果を自動共有
- 1つの会話スレッドが3つのアプリにまたがって動作
- Excelのデータ→PowerPointスライドへの挿入、Word文書→スライドへの要約等をシームレスに実行

**設定方法:**
1. 3つのAdd-inをすべてインストール
2. 各アプリの設定で「Let Claude work across files」をオン

**制限事項:**
- 操作対象は「現在開いているファイル」のみ
- ファイルの新規作成・開閉・切り替えはできない
- クロスアプリセッションのチャット履歴は保存されない

### Skills（再利用可能ワークフロー）

チーム内で標準化されたワークフローを「Skills」として保存し、ワンクリックで実行可能。

**プリロード済みSkills:**
- **Excel**: LBOモデリング、DCF分析、コンパラブル分析、数式エラー監査、データクリーニング
- **PowerPoint**: 競合環境デッキ作成、データ更新、投資銀行向けデッキレビュー

サイドバーで`/`コマンドからスキルを呼び出し可能。

### 設定・利用方法

**インストール手順:**
1. Officeアプリで **Insert > Get Add-ins** を開く
2. 「Claude by Anthropic」を検索
3. 「Get it now」でインストール

**起動方法:**
- Mac: **Tools > Add-ins** から有効化
- Windows: **Home > Add-ins** から有効化
- ショートカット: **Ctrl+Option+C**（Excelの場合）

**IT管理者向けデプロイ:**
- Microsoft 365管理センターの統合アプリメニューから一括展開
- またはカスタムマニフェストXMLファイルをアップロード

**エンタープライズ接続オプション:**
- 直接Claude アカウント
- Amazon Bedrock
- Google Cloud Vertex AI
- Microsoft Foundry

### 制限事項・注意点

**プラン制限:**

| アプリ | Pro ($20/月) | Max ($100/月) | Team | Enterprise |
|--------|:---:|:---:|:---:|:---:|
| Excel | ✅ | ✅ | ✅ | ✅ |
| PowerPoint | ❌ | ✅ | ✅ | ✅ |
| Word | ❌ | ❌ | ✅ | ✅ |

※Word は2026年4月時点でTeam/Enterpriseのみ。PowerPointはMax以上。

**プラットフォーム対応:**

| プラットフォーム | Excel | PowerPoint | Word |
|-----------------|:---:|:---:|:---:|
| Web版 | ✅ | ✅ | ✅ |
| Windows (M365) | ✅ | ✅ | ✅ (Ver.2205+) |
| Mac | ✅ (16.46+) | ✅ (16.46+) | ✅ (16.61+) |
| iPad | ✅ (2.51+) | — | — |
| Android | ❌ | ❌ | ❌ |
| Excel 2016/2019 | ❌ | — | — |

**その他の制限:**
- チャット履歴はセッション間で保存されない
- データは受信後30日以内に自動削除（キャッシュは数時間）
- 使用量はClaude アカウントの既存制限に準拠
- マクロ・VBAは非対応（Excel）
- 外部ソースからの信頼できないファイルはプロンプトインジェクションのリスクあり
- 監査ログへの記録は未対応（2026年4月時点）

## 関連機能との比較

### Claude for Office vs Microsoft Copilot

| 観点 | Claude for Office | Microsoft Copilot |
|------|-------------------|-------------------|
| 提供形態 | Add-in（サイドバー） | Office内蔵 |
| 料金 | Claude有料プラン + 無料DL | $20-30/月 + M365契約が別途必要 |
| AIモデル | Claude Opus 4.6 / Sonnet 4.6 | GPT-4系 |
| 強み | 長文理解、法務・金融特化、クロスアプリコンテキスト | Office全体の深い統合、Microsoft Graph連携 |
| 弱み | チャット履歴非保存、一部プラン制限 | 有料普及率3%と低迷、特定機能の信頼性に課題 |
| 変更追跡 | Word Track Changes統合 | Word Track Changes統合 |

### Claude for Office vs Microsoft 365コネクタ

| 観点 | Claude for Office | M365コネクタ |
|------|-------------------|-------------|
| 方向 | Office内でClaudeを使う | Claude.ai内でM365データを使う |
| 対象 | Word/Excel/PowerPoint | SharePoint/OneDrive/Outlook/Teams |
| 権限 | 開いているファイルの読み書き | 読み取りのみ |
| 対象プラン | Pro以上（アプリにより異なる） | 全プラン（Free含む） |

## ユースケース・活用例

### 金融・投資銀行
- Excelで財務モデル構築（LBO、DCF、3-statement）→ PowerPointでピッチデッキ自動生成 → Word で投資メモを起草。共有コンテキストにより一連の作業をシームレスに実行
- MCPコネクタでS&P Global・Bloomberg等から直接データ取得し、モデルに反映

### 法務
- Word で契約書のレビュー（乖離条項の特定、条件要約）
- Track Changesで修正を赤線表示し、相手方への修正案を自動生成
- コメントスレッドへの一括返信

### コンサルティング
- Excelのデータ分析結果をPowerPointのクライアント向け資料に自動反映
- 企業テンプレートのスタイルを維持したままスライド生成

### データ分析
- 複数タブのワークブックを横断分析
- ピボットテーブル・チャートの自動生成
- 数式エラーのデバッグと修正提案

## リリース状態

| 項目 | 内容 |
|------|------|
| ステータス | ✅ GA（Excel・Word）/ 🧪 ベータ（PowerPoint） |
| 対象プラン | Pro（Excelのみ）/ Max（Excel・PowerPoint）/ Team・Enterprise（全アプリ） |
| 対象プラットフォーム | Windows / Mac / Web版 / iPad（Excelのみ） |
| Excel 初出 | 2026年1月24日（Pro以上に提供開始） |
| PowerPoint 初出 | 2026年2月（正式リリース） |
| Word 初出 | 2026年4月10日（パブリックベータ）→ 4月13日（GA） |
| クロスアプリコンテキスト | 2026年3月（Excel↔PowerPoint）→ 4月（Word追加） |
| Office完全統合完了 | 2026年4月13日 |

## 情報源一覧

- [Use Claude for Word | Claude Help Center](https://support.claude.com/en/articles/14465370-use-claude-for-word)
- [Use Claude for Excel | Claude Help Center](https://support.claude.com/en/articles/12650343-use-claude-for-excel)
- [Use Claude for PowerPoint | Claude Help Center](https://support.claude.com/en/articles/13521390-use-claude-for-powerpoint)
- [Work across Excel, PowerPoint, and Word | Claude Help Center](https://support.claude.com/en/articles/13892150-work-across-excel-and-powerpoint)
- [Advancing Claude for Excel and PowerPoint | Claude Blog](https://claude.com/blog/claude-excel-powerpoint-updates)
- [Anthropic Rolls Out Claude for Word Add-in | OpenPR](https://www.openpr.com/news/4468672/anthropic-rolls-out-claude-for-word-add-in-now-full-microsoft)
- [Anthropic Takes on Microsoft Copilot With Deep Word Integration | Trending Topics](https://www.trendingtopics.eu/anthropic-takes-on-microsoft-copilot-with-deep-word-integration-of-claude/)
- [Anthropic Expands Claude Microsoft 365 Integration for All User Plans | UC Today](https://www.uctoday.com/productivity-automation/anthropic-expands-claude-microsoft-365-integration-for-all-user-plans/)
- [Claude for Excel and PowerPoint: Complete Guide | Pasquale Pillitteri](https://pasqualepillitteri.it/en/news/265/claude-excel-powerpoint-ai-add-ins-guide)
- [Anthropic gives Claude shared context across Excel and PowerPoint | VentureBeat](https://venturebeat.com/orchestration/anthropic-gives-claude-shared-context-across-microsoft-excel-and-powerpoint/)
- [Claude by Anthropic for Excel | Microsoft AppSource](https://marketplace.microsoft.com/en-us/product/saas/wa200009404?tab=overview)
- [Claude by Anthropic for PowerPoint | Microsoft AppSource](https://marketplace.microsoft.com/en-us/product/office/wa200010001?tab=overview)
- [Claude by Anthropic for Word | Microsoft AppSource](https://marketplace.microsoft.com/en-us/product/office/wa200010453?tab=overview)
- [Microsoft 365 Connector Security Guide | Claude Help Center](https://support.claude.com/en/articles/12684923-microsoft-365-connector-security-guide)
