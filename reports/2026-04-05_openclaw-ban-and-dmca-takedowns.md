# 2026-04-05 ニュースモード調査: OpenClawサブスクリプション制限 & DMCA大量テイクダウン

**調査日**: 2026-04-05
**調査モード**: ニュースモード（Layer 2 + Layer 3のみ）
**新CLIリリース**: なし

---

## 概要

今回の調査で2つの重要な新情報を確認した：

1. **OpenClaw/サードパーティツール サブスクリプション制限**（2026年4月4日）— Claude Pro/Maxのサブスクリプションがサードパーティエージェントツールでの利用を不可に
2. **GitHub DMCA大量テイクダウン事件**（2026年4月1日）— ソースコードリーク対応で約8,100リポジトリを誤ってテイクダウン、その後大部分を撤回

---

## 主要な新情報

### 1. OpenClaw/サードパーティツール サブスクリプション制限 ✅

**発効日**: 2026年4月4日 12:00 PT

**内容**: Anthropicは、Claude Pro/Maxサブスクリプションによるサードパーティエージェントツール（OpenClaw、NanoClaw、OpenCode等）へのアクセスを遮断した。

**背景と理由**:
- Claude Code責任者 Boris Cherny: 「サブスクリプションはこれらのサードパーティツールの使用パターンに対応する設計ではなかった」
- サードパーティハーネスはAnthropicネイティブツールのプロンプトキャッシュ最適化を欠き、インフラに「過大な負荷」をかけていた
- アクティブなOpenClawセッションの約60%がサブスクリプション認証情報に依存していた
- 月額$200のサブスクリプションで$1,000以上のワークロードを処理するアービトラージを解消

**影響範囲**:
- ❌ 影響を受ける: OpenClaw、NanoClaw、OpenCode、その他の非公式OAuth統合
- ✅ 影響を受けない: Claude.ai、Claude Code（公式CLI）、Claude Desktop、Claude Cowork

**ユーザーへの移行オプション**:

| 方法 | コスト構造 | ユースケース |
|------|-----------|-------------|
| Extra Usageアドオン | セッション課金 | 軽〜中程度の利用 |
| 直接API利用 | トークン課金 | 本番ワークロード |
| Nanoclaw (SDK) | API価格 | SDK準拠の開発 |

**補償措置**:
- 月額プラン相当のワンタイムクレジット（$20〜$200）、2026年4月17日まで有効
- Extra Usageバンドルの先行購入で最大30%割引

**コミュニティの反応**:
- 一部ユーザーは月額コストが最大50倍に増加する可能性を懸念
- OpenClawの作成者 Peter Steinberger は2026年2月にOpenAIに移籍済み
- Steinbergerと投資家 Dave Morin がAnthropicと交渉を試みたが、施行を1週間遅らせるにとどまった
- 「Claudeはインフラに対価を払うビルダー向けにシフトしている」との分析

**リリース状態**: ✅ GA（即時発効）

---

### 2. GitHub DMCA大量テイクダウン事件（ソースコードリーク続報）

**発生日**: 2026年3月31日〜4月1日

**経緯**:
1. 2026年3月31日: v2.1.88のnpmパッケージにソースマップが含まれ、512,000行以上のソースコードが流出（既報）
2. 同日: AnthropicがDMCA著作権テイクダウン通知をGitHubに提出
3. **約8,100リポジトリ**がテイクダウンされた — これにはAnthropicの公開Claude Codeリポジトリの**正規フォークも含まれていた**
4. コミュニティが激しく反発、SNS上で正規リポジトリが遮断されたとの報告が相次ぐ
5. Boris Cherny（Claude Code責任者）が「事故」と認め、テイクダウン通知の大部分を撤回
6. 最終的に1リポジトリ + 96フォーク（流出ソースコードを含むもの）のみに限定

**波及効果**:
- 流出コードを元にした**OpenCode**プロジェクトが登場。GPT、DeepSeek、Gemini、Llama等あらゆるLLMで動作するオープンソースAIコーディングアシスタントとして急成長
- GitHubの歴史で最も急成長したリポジトリの一つに

**リリース状態**: 事件報告（セキュリティインシデントの続報）

---

### 3. Claude Mythos/Capybara — ステータス更新

**前回状態**: ❓ 噂・未確認（2026-04-02時点）

**今回の追加情報**:
- トレーニング完了済み、限定的な早期アクセス顧客に試験提供中
- 「運用コストが高く、一般リリースの準備ができていない」
- 公開APIにはエンドポイント、エイリアス、ベータフラグいずれも存在しない
- ASL-4安全性閾値に該当する可能性があり、リリースがさらに遅延する可能性
- メディア推測: 2026年4月後半〜5月中旬の限定リリース

**ステータス変更**: なし（❓ 噂・未確認のまま）

---

### 4. ブログ: "Harnessing Claude's intelligence"（2026年4月2日）

**内容**: 新機能発表ではなく、Claude活用の技術ガイダンス記事。以下の3パターンを紹介：
1. Claudeが既に知っていること（汎用ツール活用）を活かす
2. 「何をやめられるか」を問う（コード実行ツール、スキル、メモリの活用）
3. キャッシュ最適化とセキュリティ境界の設定

**リリース状態**: N/A（技術ブログ記事）

---

## APIプラットフォーム リリースノート

**4月の新規エントリ**: なし（最新は2026年3月30日のまま）

---

## 情報源一覧

### Layer 2（公式ブログ・APIドキュメント）
- [Claude Platform Release Notes](https://platform.claude.com/docs/en/release-notes/overview) — 4月の新規エントリなし
- [Claude Help Center Release Notes](https://support.claude.com/en/articles/12138966-release-notes) — 4月の新規エントリなし
- [Harnessing Claude's intelligence (blog)](https://claude.com/blog/harnessing-claudes-intelligence) — 2026-04-02

### Layer 3（ニュースメディア）
- [Anthropic says Claude Code subscribers will need to pay extra for OpenClaw usage | TechCrunch](https://techcrunch.com/2026/04/04/anthropic-says-claude-code-subscribers-will-need-to-pay-extra-for-openclaw-support/)
- [Anthropic cuts off the ability to use Claude subscriptions with OpenClaw | VentureBeat](https://venturebeat.com/technology/anthropic-cuts-off-the-ability-to-use-claude-subscriptions-with-openclaw-and)
- [Anthropic blocks OpenClaw from Claude subscriptions | TNW](https://thenextweb.com/news/anthropic-openclaw-claude-subscription-ban-cost)
- [Anthropic Just Blocked Claude Subscriptions on OpenClaw | RoboRhythms](https://www.roborhythms.com/anthropic-blocks-openclaw-claude-subscription-2026/)
- [Interpreting Anthropic's Third-Party Tool Ban | Apiyi.com](https://help.apiyi.com/en/anthropic-claude-subscription-third-party-tools-openclaw-policy-en.html)
- [Anthropic took down thousands of GitHub repos | TechCrunch](https://techcrunch.com/2026/04/01/anthropic-took-down-thousands-of-github-repos-trying-to-yank-its-leaked-source-code-a-move-the-company-says-was-an-accident/)
- [Anthropic DMCA notices on leaked code | PiunikaWeb](https://piunikaweb.com/2026/04/01/anthropic-dmca-claude-code-leak-github/)
- [Anthropic Issues Copyright Takedown Requests | Slashdot](https://developers.slashdot.org/story/26/04/01/158240/anthropic-issues-copyright-takedown-requests-to-remove-8000-copies-of-claude-code-source-code)
- [Leaked Claude Code source spawns fastest growing repository | Cybernews](https://cybernews.com/tech/claude-code-leak-spawns-fastest-github-repo/)
- [Anthropic's Most Powerful Mythos/Capybara Model Releasing Soon | Medium](https://medium.com/@ZombieCodeKill/anthropics-most-powerful-mythos-capybara-model-releasing-soon-b4b3af69ef10)
