# Deep Dive: Claude Design

**調査日:** 2026-04-28
**関連する日次レポート:**
- [2026-04-18 v2.1.111-112・Opus 4.7 GA・Claude Design](../reports/2026-04-18_v2.1.111-112-opus-4.7-and-claude-design.md)
- [2026-04-19 v2.1.114・Claude Design利用条件・Haiku 3退役](../reports/2026-04-19_v2.1.114-and-claude-design-plans.md)

## 概要

Claude Design は 2026 年 4 月 17 日に **Anthropic Labs** が発表した、Claude Opus 4.7 をエンジンに据える「会話で作る」ビジュアル制作ツール。`claude.ai/design` を入口に、自然言語のプロンプトからプロトタイプ・スライド・ランディングページ・ダッシュボード・1-pager 等を **HTML/CSS でライブレンダリング**しつつ、インラインコメント・直接編集・調整スライダーで反復改善できる。最大の差別化要素は **コードベースや Figma ファイルからチームのデザインシステムを自動抽出して適用**する点と、**Claude Code への "Hand off"** によりプロトタイプを実装まで一気通貫させる「design-to-code ループ」を成立させる点にある。Pro/Max/Team/Enterprise が対象（Free 不可）で、通常の chat / Claude Code 枠とは独立した週次クォータを消費する研究プレビュー。Mike Krieger（Anthropic 最高プロダクト責任者）はローンチに先立って Figma の取締役を辞任しており、Anthropic がモデル提供者からアプリケーションプラットフォーマーへ本格的に移行する象徴と捉えられている。

## 背景知識・技術解説

### そもそも何か

「prompt-to-design」ツールの新しい潮流に位置するプロダクトで、Vercel の **v0**（プロンプトから React/Next.js コンポーネント生成）、**Lovable**（プロンプトから本番デプロイ可能アプリ生成）、**Bolt.new**（StackBlitz のフルスタック生成）、Figma の **Make** などと地続きの市場にある。一方で対象ユーザーを「デザイナーではないファウンダー / プロダクトマネージャー / マーケター / 営業」に明確に振っており、出力フォーマットも Web プロトタイプだけでなくスライド・1-pager・ソーシャルアセットまで含む点で、開発者向け色が強い v0 / Bolt とは差別化されている。

「Anthropic Labs」は Anthropic が **2026 年 1 月に立ち上げた実験的プロダクトのインキュベーション部門**で、Claude の能力フロンティアで荒削りなプロダクトを早期ユーザーに提供し、機能するものをスケールさせる位置づけ。Claude Design はその第一弾プロダクトに該当する。

### なぜ重要か

Anthropic は 2026 年に入り **Claude Code（CLI／Web／IDE）→ Claude Cowork（デスクトップ作業ハブ）→ Claude for Office（Word/Excel/PowerPoint）→ Computer Use → Claude for Chrome → Claude Managed Agents** とアプリケーション層を立て続けに拡張してきた。Claude Design はその系譜の最新であり、「モデル API を売る会社」から「Claude を中核とする業務スイートを提供する会社」への遷移を最も視覚的に示すローンチでもある。

市場面では、4 月 14 日に The Information が事前リークした時点で **Figma・Adobe・Wix の株価が即座に下落**し、ローンチ翌週には Figma 株が 7% 下落したと報じられた。Anthropic は公式に「Canva / Figma の置き換えではなく補完」と位置付けつつ、Canva とは正式な統合パートナーシップを発表しており（Claude Design からのドラフトを Canva に直接エクスポート、Canva AI 2.0 は Claude 生成 HTML を取り込み可能）、デザインスタックの再編が始まった象徴になっている。

### これまでの経緯

| 日付 | 出来事 |
|------|--------|
| 2026-01 | Anthropic Labs を新部門として発表（実験的プロダクトインキュベーター） |
| 2026-04-14 | The Information が「Anthropic がデザインプロダクトを準備中」と報道 → Figma/Adobe/Wix 株が即下落 |
| 2026-04-16 | Canva AI 2.0 発表（Claude HTML 取り込み対応含む） |
| 2026-04-16 | Claude Opus 4.7 GA |
| 2026-04-17 | **Claude Design 正式発表（research preview）** |
| 2026-04-18 | サポート記事「Get started with Claude Design」公開（プラン・クォータ確定） |
| 2026-04-18 | Mike Krieger の Figma 取締役辞任が表面化 |

「テキストから UI を生成する」系統のツール自体は v0（2023）、Galileo AI、Uizard、Magic Patterns 等が先行していたが、**Claude Design の独自性は (1) Opus 4.7 のビジョン能力と (2) リンク済みコードベース／Figma ファイルからのデザインシステム自動抽出と (3) Claude Code へのシームレスなハンドオフ**の組み合わせにある。

## 機能の詳細

### 何ができるか

| カテゴリ | 例 |
|----------|------|
| **ウェブ系** | ランディングページ、ダッシュボード、設定ページ、検索 UI、フォーム、モバイル UI |
| **プロトタイプ** | インタラクティブプロトタイプ（複数画面・状態を含む）、オンボーディングフロー（例: 5 画面の段階的ガイド） |
| **プレゼンテーション** | スライドデッキ、1-pager、社内提案資料 |
| **マーケティング** | ソーシャルメディアアセット、キャンペーンビジュアル |

出力は **HTML/CSS によるライブレンダリング**でチャットの隣に表示される（例：「価格ページを作って」と頼むと、Claude が HTML/CSS を書き、隣のキャンバスでそのまま動くページが見える）。

### 入力できるもの

- **テキストプロンプト**（基本）
- **画像**（ラフスケッチ、参考画像）
- **ドキュメント**: DOCX / PPTX / XLSX
- **コードベース**: GitHub リポジトリ接続またはローカルディレクトリ接続（`Import` ボタンから）
- **Figma ファイル**: デザインシステム抽出元として読み込み可能

コードベースを接続すると、Claude が以下を自動解析する:

- コンポーネント構造
- スタイリング・テーマ（カラー、スペーシング、タイポグラフィ）
- ファイル構成

これにより、新規生成するプロトタイプにチームのデザインシステムが**自動的に**適用される（v0 / Lovable では Figma インポートはできるが GitHub リポからのデザインシステム推論は持たない、というのが明確な差別化点）。

### 編集機能（反復改善）

- **会話による反復**: 「もっと余白を広く」「ヒーローセクションを左寄せに」など自然言語で指示
- **インラインコメント**: 特定要素にピン留めしてコメント
- **直接編集**: テキストの直接書き換え
- **カスタムスライダー**: 「フォーマリティ」「密度」など属性を連続値で調整

### 設定・利用方法

| 項目 | 内容 |
|------|------|
| **入口 URL** | `claude.ai/design` |
| **対象プラン** | Pro / Max / Team / Enterprise（**Free 不可**） |
| **Enterprise の既定** | **デフォルト オフ**。組織管理者が Organization settings で明示有効化 |
| **動作モデル** | Claude Opus 4.7（Anthropic 最高性能のビジョンモデル） |
| **クォータ** | 既存プラン枠を消費、ただし **Claude chat / Claude Code とは独立した週次 allowance**。超過後は extra usage 有効化で継続利用可 |
| **段階ロールアウト** | 4/17〜順次開放 |

Enterprise では管理者が組織設定から有効化操作を行わない限りエンドユーザーは利用できない。Pro / Max / Team はデフォルトで利用可能。

### Claude Code への Hand off（最重要機能）

実装フェーズへの橋渡しが Claude Design の核心的な差別化要素。

1. キャンバス右上の **`Export`** → **`Hand off to Claude Code`** をクリック
2. Claude が以下をハンドオフバンドルにパッケージング:
   - プロジェクトのデザインファイル（HTML/CSS、コンポーネント定義）
   - **チャットの全ログ**（設計意図・決定の根拠を保持）
   - README（モデルがバンドルをどう解釈すべきか指示）
   - 貼り付け用プロンプト（バンドル URL 込み）
3. ハンドオフ先を選択:
   - **ローカル Claude Code**: 手元のリポジトリに対して実装開始
   - **Claude Code Web**: クラウド上で実装（リモートエージェント）

リンク済みコードベースがある場合、Claude Code はすでにそのコンポーネント・パターンを理解しているため、**「プロトタイプ」と「出荷可能コード」のギャップを大幅に圧縮**する設計。設計意図・コンポーネント選択・アーキテクチャ判断が再解釈されずに引き継がれるのが、他の prompt-to-design ツールに対する本質的アドバンテージ。

### エクスポート・共有

| 形式 | 用途 |
|------|------|
| **ZIP** | プロジェクト一括ダウンロード |
| **PDF** | レビュー用配布 |
| **PPTX** | スライドとして PowerPoint へ |
| **Canva** | パートナーシップによる直接連携。マーケ仕上げ・公開用 |
| **スタンドアロン HTML** | Web で動くプロトタイプとして書き出し |
| **Claude Code（Local / Web）** | 実装ハンドオフ |

組織内で **共有リンク（閲覧専用 / コメント / 編集アクセス）** を発行可能。

### 制限事項・注意点

| 区分 | 内容 |
|------|------|
| **既知のバグ（公式 Help 記載）** | インラインコメントの消失、コンパクトビューでの保存エラー、大規模コードベース接続時のラグ、チャットエラー |
| **設計上の制約** | Figma のような **マルチユーザーリアルタイム共同編集なし**、フレーム単位レビュー＆承認ワークフローなし、ベクターイラスト生成は対象外、永続的に同期されたデザインシステム共有は部分的、**ローンチ時点で React / Tailwind 等への直接コード書き出しは非対応**（Claude Code ハンドオフ経由になる） |
| **トークン消費** | 早期ユーザーから「2 セッションで Pro の週次枠の 58% を消費した」との報告。週に複数プロジェクトを回すなら **Max を推奨** |
| **大規模リポ** | パフォーマンス低下のため特定ディレクトリへの接続を推奨（`node_modules` 等を除外） |
| **多言語対応** | ヘルプ記事は複数言語提供だが、地域制限の明記はなし |

## 関連機能との比較

### vs Figma

| 観点 | Claude Design | Figma |
|------|---------------|-------|
| 強み | プロンプトから動くプロトタイプまでの **速度** | コンポーネントシステム、リアルタイムコラボ、Dev Mode の React/Tailwind コードエクスポート、ベクターイラスト、永続バージョン履歴 |
| 弱み | シングルユーザー体験、レビュー&承認フローなし、ベクター非対応、ネイティブコードエクスポートなし | プロンプトからの初期生成は弱い（Make でカバー中） |
| 価格 | Claude Pro $20/月（バンドル） | $15/編集者/月 |

### vs Canva

**競合ではなく補完／統合パートナー**。Claude Design → Canva へのエクスポートが正規連携、逆に Canva AI 2.0 は Claude HTML 取り込みに対応。Canva は Brand Intelligence と Slack/Notion/Gmail/HubSpot/Drive/Zoom の 6 種エージェント連携で「マーケティング配信」サイドを強化。

### vs v0 / Lovable / Bolt

| ツール | ポジション |
|--------|-----------|
| **v0**（Vercel） | 純粋な React/Next.js コンポーネント出力に強い。開発者向け |
| **Lovable** | プロンプトからフルデプロイ済みアプリを生成。E2E |
| **Bolt** | StackBlitz ベースのフルスタック生成 |
| **Claude Design** | プロンプト → プロトタイプ + 構造化されたハンドオフでスタックを問わず Claude Code に渡せる「中間」ポジション。**ターゲットは非デザイナー（ファウンダー / PM）** |

### vs Claude Cowork の "Design" プラグイン

両者は別物。Cowork 内の Design プラグイン（Anthropic Verified）は **既存デザインのクリティーク・UX ライティング・WCAG 2.1 AA アクセシビリティ監査・リサーチ統合・開発ハンドオフ**を行う「レビュアー型」エージェント。Claude Design は「ジェネレーター型」サーフェス。両者を組み合わせる運用が想定される。

## ユースケース・活用例

| シナリオ | 効果 |
|----------|------|
| **ソロ開発者のランディングページ** | 半日かかっていたヒーロー画像 + レイアウト作業を約 1 時間に圧縮 |
| **ファウンダー / 営業のピッチデッキ** | 「数分でラフから完全なデッキ」 |
| **PM のワイヤーフレーム / モックアップ** | 仕様議論用のプロトタイプを即時生成 |
| **マーケのキャンペーン展開** | LP + ソーシャルアセット + プレゼンを統一デザインで一括 |
| **デザイナーの方向性探索** | 同じブリーフで複数の方向性を素早く出して絞り込み |

公式チュートリアルが推奨するベストプラクティス:

- **命名の明確化**: プロトタイプ内の要素に明確な名前を付ける
- **決定の文書化**: チャットに設計意図・根拠を記録（ハンドオフ時に Claude Code が読める）
- **エッジケース検証**: 空状態・エラー状態・ローディング状態を必ず確認

ワークフロー例（Claude Design 起点の "design-to-code loop"）:

```
プロンプト
   ↓
Claude Design（プロトタイプ + デザインシステム適用）
   ↓ Hand off
Claude Code（実装、ハンドオフバンドル + リンク済みリポ）
   ↓
本番コード
```

マーケ向けには **Claude Design → Canva → 公開** の流れが推奨されている。

## リリース状態

| 項目 | 内容 |
|------|------|
| ステータス | 🔬 研究プレビュー（段階ロールアウト中） |
| 対象プラン | Pro / Max / Team / Enterprise（Free 対象外、Enterprise はデフォルト オフ） |
| 対象プラットフォーム | Web（`claude.ai/design`） |
| 動作モデル | Claude Opus 4.7 |
| 利用枠 | 既存プラン枠を消費、Claude chat / Claude Code とは独立した週次 allowance、超過後は extra usage |
| 初出 | 2026-04-17（Anthropic Labs 公式発表） |
| 公式ヘルプ初出 | 2026-04-18（support.claude.com） |

## 情報源一覧

### 公式
- [Introducing Claude Design by Anthropic Labs（公式発表）](https://www.anthropic.com/news/claude-design-anthropic-labs)
- [Get started with Claude Design（公式ヘルプ）](https://support.claude.com/en/articles/14604416-get-started-with-claude-design)
- [Using Claude Design for prototypes and UX（公式チュートリアル）](https://claude.com/resources/tutorials/using-claude-design-for-prototypes-and-ux)
- [Design プラグイン（Claude Cowork 内、別製品）](https://claude.com/plugins/design)

### 一次報道
- [TechCrunch — Anthropic launches Claude Design, a new product for creating quick visuals](https://techcrunch.com/2026/04/17/anthropic-launches-claude-design-a-new-product-for-creating-quick-visuals/)
- [VentureBeat — Anthropic just launched Claude Design, an AI tool that turns prompts into prototypes and challenges Figma](https://venturebeat.com/technology/anthropic-just-launched-claude-design-an-ai-tool-that-turns-prompts-into-prototypes-and-challenges-figma)
- [The New Stack — Anthropic launches Claude Design, a Figma and Canva rival built on Claude](https://thenewstack.io/anthropic-claude-design-launch/)
- [SiliconANGLE — Anthropic launches Claude Design to speed up graphic design projects](https://siliconangle.com/2026/04/17/anthropic-launches-claude-design-speed-graphic-design-projects/)

### 比較・解説
- [Claude Design vs Figma and Canva: 2026 Comparison（Sentisight）](https://www.sentisight.ai/how-similar-is-claude-design-to-figma-and-canva/)
- [What Claude Design Is (And What It Isn't)（Claude Lab）](https://claudelab.net/en/articles/claude-ai/claude-design-overview-figma-canva-alternative)
- [Claude Design vs Figma: Can Anthropic's New Tool Replace Your Design Stack?（MindStudio）](https://www.mindstudio.ai/blog/claude-design-vs-figma)
- [Claude Design: Anthropic's Answer to Lovable and v0, Explained（Aurora Designs）](https://aurora-designs.ca/blog/claude-design-anthropic-labs/)
- [Claude Design vs Lovable: Full 2026 Comparison（Eigent）](https://www.eigent.ai/blog/claude-design-vs-lovable)
- [Claude Design to Claude Code: AI Design Handoff（claudefa.st）](https://claudefa.st/blog/guide/mechanics/claude-design-handoff)
- [Claude Design Forces Canva and Figma to Become AI Platforms（DEV Community）](https://dev.to/simon_paxton/claude-design-forces-canva-and-figma-to-become-ai-platforms-3e5b)

### コミュニティ
- [awesome-claude-design（GitHub）](https://github.com/rohitg00/awesome-claude-design)

## スキップしたURL

該当なし。
