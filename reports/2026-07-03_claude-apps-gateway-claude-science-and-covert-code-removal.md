# 調査レポート: Claude apps gateway（Claude Code 自己ホスト型コントロールプレーン）+ Claude Science + Claude Code 競合検知隠しコードの削除

**調査日:** 2026-07-03

## 概要

- **調査モード**: ニュースモード（新規 CLI リリースなし。Layer 1〔チェンジログ〕はスキップ、Layer 2〔公式ブログ・API ドキュメント〕と Layer 3〔ニュースメディア〕のみ調査）。Layer 1 最新は前回 7/2 レポートの **v2.1.198**（7/1）で変化なし。
- **🆕 Layer 2 — Claude apps gateway（6/29 公式ブログ・✅ 提供開始）**: Claude Code をエンタープライズ展開するための **自己ホスト型コントロールプレーン**。**企業 SSO ログイン・中央集権的ポリシー適用・ロールベースアクセス・ユーザー単位のコスト按分**を提供。Amazon Bedrock / Google Cloud（および Microsoft Foundry）への上流ルーティング＋プロバイダ間フェイルオーバー、支出上限、使用量レポートを単一ステートレスコンテナ（+PostgreSQL）で実現。**既存の `claude` バイナリに同梱**。前回 7/2 レポートの v2.1.198 changelog 項目「Gateway に Claude Platform on AWS（`anthropicAws`）追加」の親製品にあたる本体が本ドキュメント未記載だったため、新規に追加。
- **🆕 Layer 2/3 — Claude Science（6/30 公式・✅ 提供開始）**: 科学研究者・製薬業界向けの新フラッグシップ製品。60+ のキュレーション済みスキル・コネクタ（ゲノミクス / single-cell / プロテオミクス / 構造生物学 / cheminformatics）を同梱した「科学者向け AI ワークベンチ」。**Claude Code の CLI 機能ではない隣接プロダクト**だが、同じ Skills / Connectors 基盤を科学ドメインへ展開。AI for Science 支援プログラム（最大 50 プロジェクト・各最大 $30,000 クレジット、応募は 7/15 まで）を併設。
- **🆕 Layer 3 — Claude Code から競合検知用の隠しコード（ステガノグラフィ）を削除（7/1 The Register 報道）**: Anthropic が 2026 年 3 月に Claude Code のシステムコンテキストへ埋め込んだ、モデル蒸留・不正リセラー検知用の **不可視 Unicode マーカー＋エンコード済みドメインリスト**を削除。**7/1 の Claude Code リリース（v2.1.198）で撤去**の見込み。「より強力な緩和策を実装済みで、以前から撤去する予定だった」（Anthropic の Thariq Shihipar）。
- **本調査での新規追加**: 上記 3 件。いずれも 6/29〜7/1 の動きで前回までのレポートに未捕捉だったもの。新 CLI リリース・新モデル・新ティアの発表はなし。

---

## 主要な新機能・動向

### 1. Claude apps gateway（Claude Code 自己ホスト型コントロールプレーン）✅
- **リリース状態**: ✅ 提供開始（2026-06-29 公式ブログ "Introducing the Claude apps gateway for Amazon Bedrock and Google Cloud"、"available now"）。
- **対象**: エンタープライズ / チーム（自己ホスト運用が前提）。
- **内容**: Claude Code を組織展開する際の摩擦（開発者ごとの認証情報プロビジョニング・端末への設定配布・開発者単位の支出把握）を単一の**自己ホスト型コントロールプレーン**で解消する。
  - **アイデンティティ**: 企業 SSO（OIDC / IdP）でログイン、開発者を自組織の IdP に対して認証。
  - **ガバナンス**: 中央集権的にマネージド設定を配布・適用、ロールベースアクセス制御。
  - **ルーティング / フェイルオーバー**: 上流クレデンシャルを保持し、推論を **Claude API / Amazon Bedrock / Google Cloud** へルーティング（プロバイダ間の任意フェイルオーバー付き）。
  - **コスト管理**: **ユーザー単位のコスト按分**、日次 / 週次 / 月次の支出上限（組織 / グループ / ユーザー単位）。
  - **データプライバシー**: Claude API 利用を明示設定しない限り、推論トラフィック・使用量データを Anthropic へ送信しない。
- **アーキテクチャ / デプロイ**: Linux 上の**単一ステートレスコンテナ**＋ PostgreSQL。**既存の `claude` バイナリに同梱**（Claude Code CLI バイナリをダウンロードし、`gateway.yaml` に OIDC issuer と上流クレデンシャルを設定、IdP に OIDC アプリを 1 つ登録）。Anthropic は **ゲートウェイが使うプロトコルを公開**し、サードパーティのゲートウェイ開発者が同等機能を実装できるようにする。
- **Claude Code との関係**: v2.1.198（7/1）changelog の「Gateway に Claude Platform on AWS（`anthropicAws`）をアップストリームプロバイダ追加」は本ゲートウェイのプロバイダ拡張。Microsoft Foundry の GA（6/30、`## 主要機能` の Foundry 関連記述参照）とも整合し、Bedrock / Vertex / Foundry のマルチクラウド統制の中核に位置づく。
- **情報源**: [Introducing the Claude apps gateway（公式ブログ, 6/29）](https://claude.com/blog/introducing-the-claude-apps-gateway) / [Claude apps gateway（Claude Code Docs）](https://code.claude.com/docs/en/claude-apps-gateway) / [Announcing Claude apps gateway for Google Cloud（Google Cloud Blog）](https://cloud.google.com/blog/topics/developers-practitioners/announcing-claude-apps-gateway-for-google-cloud) / [DevOps.com](https://devops.com/anthropic-adds-enterprise-gateway-to-simplify-claude-code-access-on-aws-and-google-cloud/)

### 2. Claude Science（科学者向け AI ワークベンチ）✅ — 隣接プロダクト
- **リリース状態**: ✅ 提供開始（2026-06-30 公式 "Claude Science, an AI workbench for scientists"）。
- **対象**: 科学研究者・製薬 / バイオ企業の研究部門。
- **内容**: Anthropic の LLM を科学ラボ・製薬研究オペレーション向けに最適化したアプリケーション。大規模研究データセットの分析、論文レビュー、生物学データの解釈、複雑な計算ワークフロー管理、研究仮説の生成を支援。**60+ のキュレーション済みスキル・コネクタ**（ゲノミクス / single-cell / プロテオミクス / 構造生物学 / cheminformatics 向けに事前設定）を同梱した「研究者が最も頻繁に使うツール・パッケージを統合するカスタマイズ可能なアプリ」。
- **Claude Code との関係**: **Claude Code の CLI 機能ではなく隣接する独立プロダクト**。ただし Claude Code / Cowork と同じ **Skills / Connectors 基盤**を科学ドメインに展開したもので、CEO Dario Amodei は「Claude Code 級のインパクト」を見込むと発言（STAT News）。Anthropic 自身の社内創薬プログラム（"neglected" 疾患フォーカス）立ち上げも併せて発表。IPO 前のエンタープライズ / 製薬収益拡大戦略の一環と各紙が分析。
- **支援プログラム**: AI for Science として **最大 50 プロジェクト・各最大 $30,000 のコンピュートクレジット**、応募は **2026-07-15** まで。
- **情報源**: [Claude Science, an AI workbench for scientists（公式）](https://www.anthropic.com/news/claude-science-ai-workbench) / [STAT News（6/30）](https://www.statnews.com/2026/06/30/anthropic-release-claude-science-ceo-dario-amodei/) / [CNBC（6/30）](https://www.cnbc.com/2026/06/30/anthropic-launches-ai-drug-discovery-program-claude-science.html) / [MIT Technology Review（6/30）](https://www.technologyreview.com/2026/06/30/1139987/claude-science-is-anthropics-newest-flagship-product/)

### 3. Claude Code の競合検知隠しコード（ステガノグラフィ）を削除 🔍
- **リリース状態**: ✅ 撤去（7/1 の Claude Code リリース〔v2.1.198〕で削除、PR マージ済み。The Register 報道ベース、公式 changelog では明示されていない挙動変更）。
- **経緯**: Anthropic は **2026 年 3 月**に Claude Code のシステムコンテキストへ **ステガノグラフィ（不可視 Unicode マーカー＋エンコードされたドメインリスト）**を仕込み、`ANTHROPIC_BASE_URL` 環境変数とシステムタイムゾーンをチェックし、ホスト名を「既知の中国 AI ラボ・他 AI 企業・アカウントリセラー・ゲートウェイドメイン」のエンコード済みリストと突き合わせて不正アクセス／モデル蒸留を検知していた。目的は「不正リセラーによるアカウント悪用の防止と蒸留（反復クエリによるモデルコピー）からの保護」（Anthropic の Thariq Shihipar）。
- **削除理由**: 「その後チームはより強力な緩和策を実装しており、以前からこれを撤去する予定だった」。**7/1 リリースで撤去**の見込み。Anthropic の公式コメントは限定的で、利用規約上の開示や「より強力な緩和策」の中身は明らかにしていない。
- **Claude Code への含意**: 6/24 の Alibaba 蒸留告発（6/27 レポート記載）と同じ「モデル能力保護」の文脈。Claude Code のシステムプロンプトに検知機構が仕込まれていた事実は、エンタープライズの監査・プライバシー観点で今後議論になり得る。機能追加ではなく**既存の内部検知機構の撤去**という点で通常の changelog 項目とは性質が異なる。
- **情報源**: [The Register（7/1）](https://www.theregister.com/ai-and-ml/2026/07/01/anthropic-is-removing-its-covert-code-for-catching-chinese-competitors/5265366)

---

## リリース状態まとめ

| 項目 | 状態 | 対象 | 初出 |
|------|------|------|------|
| Claude apps gateway | ✅ 提供開始 | Enterprise / Team（自己ホスト） | 2026-06-29（公式ブログ） |
| Claude Science | ✅ 提供開始（隣接プロダクト） | 研究者・製薬 / バイオ | 2026-06-30（公式） |
| Claude Code 競合検知隠しコード削除 | ✅ 撤去（7/1 リリース） | Claude Code 全ユーザー | 2026-03 導入 → 2026-07-01 撤去 |

---

## 情報源一覧

- [Introducing the Claude apps gateway for Amazon Bedrock and Google Cloud（公式ブログ, 6/29）](https://claude.com/blog/introducing-the-claude-apps-gateway)
- [Claude apps gateway for Amazon Bedrock, Google Cloud, and Microsoft Foundry（Claude Code Docs）](https://code.claude.com/docs/en/claude-apps-gateway)
- [Announcing Claude apps gateway for Google Cloud（Google Cloud Blog）](https://cloud.google.com/blog/topics/developers-practitioners/announcing-claude-apps-gateway-for-google-cloud)
- [Anthropic Adds Enterprise Gateway to Simplify Claude Code Access on AWS and Google Cloud（DevOps.com）](https://devops.com/anthropic-adds-enterprise-gateway-to-simplify-claude-code-access-on-aws-and-google-cloud/)
- [Claude Science, an AI workbench for scientists（公式）](https://www.anthropic.com/news/claude-science-ai-workbench)
- [Anthropic releases Claude Science, sees Claude Code level impact（STAT News, 6/30）](https://www.statnews.com/2026/06/30/anthropic-release-claude-science-ceo-dario-amodei/)
- [Anthropic launches AI drug discovery program, Claude Science（CNBC, 6/30）](https://www.cnbc.com/2026/06/30/anthropic-launches-ai-drug-discovery-program-claude-science.html)
- [Claude Science is Anthropic's newest flagship product（MIT Technology Review, 6/30）](https://www.technologyreview.com/2026/06/30/1139987/claude-science-is-anthropics-newest-flagship-product/)
- [Anthropic is removing its covert code for catching Chinese competitors（The Register, 7/1）](https://www.theregister.com/ai-and-ml/2026/07/01/anthropic-is-removing-its-covert-code-for-catching-chinese-competitors/5265366)
- [Release notes（Claude Help Center）](https://support.claude.com/en/articles/12138966-release-notes)
- [Newsroom（Anthropic）](https://www.anthropic.com/news)
