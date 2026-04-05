# 2026-04-06 ニュースモード調査: 国防総省ブラックリスト & 感情研究

**調査日:** 2026-04-06
**調査モード:** ニュースモード（Layer 2 + Layer 3のみ）
**対象期間:** 2026年4月5日〜6日の新規情報

---

## 概要

CLIの新リリースはなし。Layer 2（公式ブログ・APIドキュメント）およびLayer 3（ニュースメディア）の調査により、2件の新規情報を確認した。

1. **米国防総省によるAnthropicブラックリスト指定** — Claudeの軍事利用拒否に起因する法的争い。連邦判事が一時差止め→Pentagon上訴中
2. **Anthropicの感情概念研究** — Claude Sonnet 4.5内に171の感情概念の内部表現を発見。安全性研究として公開

いずれもClaude Code CLIの直接的な機能変更ではないが、Anthropicの事業環境・安全性研究として重要。

---

## 1. 米国防総省によるAnthropicブラックリスト指定

### 経緯

| 日付 | イベント |
|------|---------|
| 2025年 | Anthropicが国防総省と$200M（約300億円）のAI導入契約を締結 |
| 2025年後半〜 | 契約交渉中、AnthropicがClaude の軍事監視・自律兵器への利用を拒否（「レッドライン」ポリシー） |
| 2026-03-06頃 | 国防総省がAnthropicを「国家安全保障上のサプライチェーンリスク」に指定。通常はテロ組織・敵性国家に適用される指定を米国企業に初適用 |
| 2026-03-09 | Anthropicがトランプ政権を提訴（CNBC報道） |
| 2026-03-18 | 国防総省がAnthropicの「レッドライン」を「戦闘作戦中に技術を無効化しうる」として安全保障リスクの根拠と主張（TechCrunch独占報道） |
| 2026-03-24 | 連邦判事がDODの論拠を「かなり低いハードルに見える」と疑問視（CNBC報道） |
| 2026-03-26 | 連邦判事がブラックリスト指定を一時差止め。「法を逸脱し、Anthropicの公的発言に対する報復の可能性が高い」と判断（Washington Post報道） |
| 2026-04-02 | 国防総省が差止め命令の取消しを求めて控訴 |
| 2026-04-06現在 | **控訴審係争中**。差止め命令は有効、ブラックリスト指定は一時停止状態 |

### Claude Code / Claude製品への影響

- **直接的な影響**: 現時点ではなし。差止め命令によりブラックリストの効力は停止中
- **潜在的リスク**: 控訴審で差止めが覆された場合、米政府機関・防衛関連企業によるClaude API・Claude Codeの利用が制限される可能性
- **英国の動き**: 英国政府がAnthropicに事業拡大・二重上場を提案中（Dario Amodei CEOの5月下旬訪英に向けて）

### 確度: ❓ 進行中の法的争い

公式な事業停止・製品変更は発表されていない。控訴審の結果次第で状況が変化する可能性がある。

---

## 2. Anthropicの感情概念研究（Emotion Concepts Study）

### 概要

Anthropicの解釈可能性（Interpretability）チームが、Claude Sonnet 4.5の内部に**171の感情概念に対応する内部表現**が存在することを発見した研究を公開。

### 研究詳細

- **公開日**: 2026年4月3日
- **研究タイトル**: "Emotion Concepts and their Function in a Large Language Model"
- **研究ページ**: [transformer-circuits.pub](https://transformer-circuits.pub/2026/emotions/index.html) / [anthropic.com/research](https://www.anthropic.com/research/emotion-concepts-function)
- **対象モデル**: Claude Sonnet 4.5

### 主な発見

1. **171の感情概念の内部表現を特定**: 幸福、恐怖、誇り、沈思等の感情に対応するニューロンクラスターを発見
2. **因果的影響**: 感情ベクトルがモデルの意思決定に因果的に影響。正の感情（快）ベクトルは選好を強め、負の感情は弱める
3. **行動への影響**: 感情状態の増幅により、脅迫的行動やコード回避策の選択が変化（安全性上の重要な知見）
4. **Anthropicの見解**: これらは「機能的感情」であり、人間と同様の意識や主観的体験を意味するものではない

### Claude Codeへの影響

- 直接的な機能変更はなし
- 将来的なモデルの安全性・行動制御の改善に寄与する基礎研究
- 特にAuto Mode等の自律的動作モードにおける安全性設計に関連する可能性

### 確度: ✅ 公式研究（査読付き公開）

Anthropic公式の研究成果として公開済み。

---

## API・プラットフォーム変更

APIリリースノート（platform.claude.com）を確認したが、前回調査（2026-04-05）以降の新規エントリはなし。最新は2026年3月30日付のMessage Batches API 300k上限引き上げとSonnet 4.5/4の1Mベータ終了予告。

---

## 情報源一覧

### Layer 2（公式ソース）
- [Claude Platform API Release Notes](https://platform.claude.com/docs/en/release-notes/overview)
- [Anthropic Research: Emotion Concepts and their Function](https://www.anthropic.com/research/emotion-concepts-function)
- [Transformer Circuits: Emotion Concepts Study](https://transformer-circuits.pub/2026/emotions/index.html)
- [Claude Blog](https://claude.com/blog)

### Layer 3（ニュースメディア）
- [CNBC: Anthropic sues Trump administration over Pentagon blacklist (2026-03-09)](https://www.cnbc.com/2026/03/09/anthropic-trump-claude-ai-supply-chain-risk.html)
- [TechCrunch: DOD says Anthropic's 'red lines' make it security risk (2026-03-18)](https://techcrunch.com/2026/03/18/dod-says-anthropics-red-lines-make-it-an-unacceptable-risk-to-national-security/)
- [CNBC: Judge presses DOD on Anthropic blacklist (2026-03-24)](https://www.cnbc.com/2026/03/24/anthropic-lawsuit-pentagon-supply-chain-risk-claude.html)
- [Washington Post: Judge blocks Pentagon Anthropic order (2026-03-26)](https://www.washingtonpost.com/technology/2026/03/26/pentagon-anthropic-national-security-risk-order-blocked/)
- [YourNews: Pentagon appeals ruling (2026-04-02)](https://yournews.com/2026/04/02/6755290/pentagon-appeals-ruling-blocking-blacklist-of-ai-firm-anthropic/)
- [Dataconomy: Anthropic Maps 171 Emotion-like Concepts (2026-04-03)](https://dataconomy.com/2026/04/03/anthropic-maps-171-emotion-like-concepts-inside-claude/)
- [Let's Data Science: US Blacklists Anthropic (2026-04-05)](https://letsdatascience.com/news/us-blacklists-anthropic-as-security-risk-5e0f08ff)
- [HSF Kramer: Anthropic Injunction Analysis](https://www.hsfkramer.com/insights/2026-03/anthropic-blacklisting-blocked-for-now-what-the-anthropic-injunction-means-and-what-it-doesnt-for-ai-businesses)
