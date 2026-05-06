# 2026-05-07 Claude Code 新機能調査レポート — Code with Claude SF キーノート（5/6 9 AM PT）で Code Review / Security Reviews / CI Auto-Fix / Remote Agents が GA 昇格・Outcomes / Multi-Agent Orchestration がパブリックベータ・Dreaming が研究プレビュー始動・SpaceX Colossus 1 提携で 300MW / 220,000 GPU 確保・Pro/Max/Enterprise レート制限倍増 + ピーク時間制限撤廃、CLI は v2.1.129（5/6 01:40 UTC、--plugin-url + Homebrew/WinGet 自動更新 + ゲートウェイモデルディスカバリー opt-in 化）→ v2.1.131（5/6 07:47 UTC、Windows VS Code 起動修正・Mantle x-api-key 修正）→ v2.1.132（5/6 22:08 UTC、CLAUDE_CODE_SESSION_ID + CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN + 多数 fix）の 3 連続リリース

**調査日**: 2026-05-07
**対象期間**: 2026-05-05 〜 2026-05-07
**調査モード**: フルモード（Layer 1〜3 全層）

---

## 概要

本日（5/7 JST）は **Code with Claude SF 2026（5/6 9:00 AM PT、SF Cordis Reactor 開催）** の主要発表内容が出揃った日となった。Anthropic CPO **Ami Vora** が冒頭で **"No new model today. Today is about how we are making our products work better for you."** と宣言し、新モデル（Sonnet 4.8 / Jupiter）は今回見送り。代わりに **Claude Code の既存研究プレビュー機能を一気に GA / パブリックベータ昇格** させ、SpaceX Colossus 1 提携でコンピュート不足を解消、Pro/Max/Enterprise のレート制限を倍増しピーク時間制限を撤廃する形で、**「モデルではなくプロダクト体験」に振り切ったキーノート**となった。

| カテゴリ | 主要発表 |
|---------|---------|
| **Claude Code GA 昇格（4 機能）** | ① Code Review、② Security Reviews（自動セキュリティレビュー）、③ CI Auto-Fix、④ Remote Agents（旧 Remote Control の延長） |
| **Claude Managed Agents Public Beta（3 機能）** | ① Outcomes（成功条件指定で自律反復）、② Multi-Agent Orchestration（エージェント艦隊）、③ Memory（既存パブリックベータ継続） |
| **Research Preview（1 機能）** | Dreaming（過去セッションを再点検し自己改善・メモリ artifact 生成、`/dream` コマンドで手動起動） |
| **コンピュート / レート制限** | SpaceX Colossus 1 全容量提携（**300MW / 220,000+ Nvidia GPU、1 ヶ月以内**）、orbital compute "数 GW" 追加の意向表明、**Claude Code 5 時間レート制限を倍増**（Pro / Max / Enterprise）、**Pro / Max のピーク時間制限撤廃**、API Opus レート制限大幅引き上げ |
| **戦略数値** | API トラフィック **前年比 17 倍**（Vora） |

**Layer 1（CLI チェンジログ）も活発**: 5/4 v2.1.128 以降 24 時間で **v2.1.129 / v2.1.131 / v2.1.132 の 3 リリース**が連続投入された（v2.1.130 は欠番、おそらく内部 release rolled back）。v2.1.129 は **`--plugin-url` で URL からプラグイン .zip を取得 / Homebrew・WinGet 自動更新 / ゲートウェイモデルディスカバリーを opt-in 化（v2.1.126〜v2.1.128 の自動有効化を巻き戻し）/ Ctrl+R 履歴ピッカーを v2.1.124 以前の挙動（全プロジェクト検索）に復帰** など 30 件超の改善・修正を含む大型リリース。v2.1.131 は VS Code 拡張の Windows 起動失敗（`createRequire` polyfill バグ）と Mantle エンドポイント認証の **x-api-key ヘッダー欠落**ホットフィックス。**v2.1.132 はキーノート後（22:08 UTC）リリース**で `CLAUDE_CODE_SESSION_ID` を Bash サブプロセスへ追加・`CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN` でスクロールバック保持・`/usage` Linux/X11 hang 修正・`/effort` ピッカーの環境変数 override 反映など、Code with Claude セッションでデモされた Claude Code のフロー改善が裏でフォローされている。

---

## 主要な新機能

### 1. Code Review ✅ GA 昇格（Claude Code）

- **リリース状態**: ✅ **GA**（Code with Claude SF キーノートで正式 GA 宣言、5/6）
- **以前の状態**: 🔬 研究プレビュー（Team / Enterprise 限定、2026-03-09 launch）
- **対象プラン**: Team / Enterprise（GA 後の対象は変わらず Team / Enterprise が中心と推察、Pro / Max への展開は未確認）
- **概要**: PR がオープンされると複数の AI エージェントが並行で精査し、severity ランク付けでインラインコメントを残す。Anthropic 自社では「**every team at Anthropic** で利用」（Vora）。
- **性能**: 平均レビュー時間 **約 20 分**、1,000 行以上の大規模 PR で **84% に平均 7.5 件の指摘**（数百組織での先行運用結果）
- **価格**: トークン課金（**$15-25 / レビュー**、PR 規模・複雑度に依存）
- **情報源**: [Simon Willison Live blog（5/6）](https://simonwillison.net/2026/May/6/code-w-claude-2026/) / [Code Review Docs](https://code.claude.com/docs/en/code-review) / [InfoQ](https://www.infoq.com/news/2026/04/claude-code-review/)

### 2. Security Reviews ✅ GA 昇格（Claude Code 内蔵）

- **リリース状態**: ✅ **GA**（Code with Claude SF キーノートで GA 宣言、5/6）
- **以前の状態**: 🔬 研究プレビュー（`/security-review` スラッシュコマンドとして 2025-08〜提供）
- **対象**: Claude Code 全プラン（具体的なプラン制限は今後の Help Center 更新待ち）
- **概要**: PR / コミットに対して自動的にセキュリティ脆弱性検出を実行。`/security-review` コマンドでセッション中のペンディング変更を包括的レビューも可能。Anthropic 内部利用実績多数。
- **Claude Security との関係**: ✅ GA の Security Reviews（Claude Code 内蔵、開発者向け）と 🧪 公開ベータの **Claude Security**（claude.ai サイドバー / claude.ai/security、セキュリティチーム向け、Enterprise 限定）は**別製品**。Claude Security はリポジトリスキャン製品で Finding を Claude Code on Web に引き渡す。Security Reviews は CLI / IDE 内のフロー。
- **情報源**: [Simon Willison Live blog（5/6）](https://simonwillison.net/2026/May/6/code-w-claude-2026/) / [Automated Security Reviews in Claude Code (Help Center)](https://support.claude.com/en/articles/11932705-automated-security-reviews-in-claude-code) / [claude-code-security-review (GitHub)](https://github.com/anthropics/claude-code-security-review)

### 3. CI Auto-Fix ✅ GA 昇格（Claude Code on Web）

- **リリース状態**: ✅ **GA**（Code with Claude SF キーノートで GA 宣言、5/6）
- **以前の状態**: 🔬 研究プレビュー（2026-03〜）
- **対象**: Claude Code on Web の利用者（PR ベースのワークフロー）
- **概要**: PR の **CI 失敗とレビューコメントを継続監視** → ログ / フィードバックを読んで何を直すか判断 → 同一ブランチに自動 push。**ループしない設計**: 解決できない場合は試行内容を添えて人間にエスカレーション。Web 上の PR ビューの CI ステータスバー内トグルで有効化。
- **3 機能セット**: 2026-03 にリリースされた **「PR を自動追跡」「CI 失敗を自動修正」「レビューコメントを自動対応」** の 3 セットが完全自律 PR パイプラインを構成。今回 GA 化。
- **位置づけ**: Code with Claude では **Code Review（指摘） + Security Reviews（脆弱性指摘） + CI Auto-Fix（自動修正）** で「PR の品質を Claude が一気通貫で担保する」ストーリーが示された。
- **情報源**: [Simon Willison Live blog（5/6）](https://simonwillison.net/2026/May/6/code-w-claude-2026/) / [PR Autofix with Claude Code (GitHub Marketplace)](https://github.com/marketplace/actions/pr-autofix-with-claude-code) / [Builder.io - Every Claude Code Update From March 2026](https://www.builder.io/blog/claude-code-updates)

### 4. Remote Agents ✅ GA 昇格（旧 Remote Control の延長 / 名称統一）

- **リリース状態**: ✅ **GA**（Code with Claude SF キーノートで GA 宣言、5/6）
- **以前の状態**: 🔬 研究プレビュー（2026-01〜、Pro / Max 限定）
- **対象**: Claude Pro / Max / Team / Enterprise（GA 化に伴うプラン拡大の有無は今後 Help Center で要確認）
- **概要**: ローカル PC で Claude Code エージェントを走らせたまま、**iOS / Android / ブラウザから状態確認・承認・指示・キュー投入**を可能にする。会議室・電車・ソファから複数セッションをモニター可能。
- **特長**: エージェントはローカルマシン上で動作（フルツールアクセス保持）し、モバイルからはチャットレベルの制御のみ送受信。コード・ファイルはローカルに留まる暗号化チャネル設計（Dispatch と同じプライバシーモデル）。
- **キーノート言及**: Vora が「control your laptop from your phone」と紹介。**「Remote Control」**という旧名から **「Remote Agents」**へ呼称が更新された可能性が高い（公式 Help Center / Docs 反映待ち）。
- **情報源**: [Simon Willison Live blog（5/6）](https://simonwillison.net/2026/May/6/code-w-claude-2026/) / [VentureBeat - Anthropic released a mobile version of Claude Code called Remote Control](https://venturebeat.com/orchestration/anthropic-just-released-a-mobile-version-of-claude-code-called-remote) / [TechRadar - Remote Control mobile version](https://www.techradar.com/pro/anthropic-reveals-remote-control-a-mobile-version-of-claude-code-to-keep-you-productive-on-the-move)

### 5. Outcomes 🧪 Public Beta（Claude Managed Agents、Claude Code から利用可能）

- **リリース状態**: 🧪 **Public Beta**（5/6 GA 化前の昇格、研究プレビュー → 公開ベータ）
- **対象**: Claude Managed Agents API ユーザー全般（5/6 公式ブログ「New in Claude Managed Agents: dreaming, outcomes, and multiagent orchestration」で発表）
- **概要**: **「成功とはどんな状態か」を明示的に定義**し、Claude が反復しながら自律的にゴールを目指す機能。「ここまでやったら完了」「テスト全パス + 元 PR 説明と一致」のような **explicit success criteria** を渡すと、Claude が達成まで何回でも自分で iterate する。
- **効果**: Anthropic 計測で自己評価成功率が **最大 +10pt 向上**（Managed Agents の研究プレビュー期間データ）
- **Claude Code への含意**: Auto Mode（Pro / Max）と組み合わせると、ロングホライズン作業（リファクタ / 大規模ライブラリ移行 / バグ調査）で「人間が逐次承認しなくてもゴール条件を満たすまで走る」運用が現実味を帯びる。
- **情報源**: [Simon Willison Live blog（5/6）](https://simonwillison.net/2026/May/6/code-w-claude-2026/) / [Anthropic Blog - New in Claude Managed Agents](https://claude.com/blog/new-in-claude-managed-agents) / [Cryptobriefing](https://cryptobriefing.com/anthropic-claude-agents-dreaming/) / [Claude Managed Agents Overview Docs](https://platform.claude.com/docs/en/managed-agents/overview)

### 6. Multi-Agent Orchestration 🧪 Public Beta（Managed Agents + Claude Code Agent Teams）

- **リリース状態**: 🧪 **Public Beta**（5/6 で研究プレビュー → 公開ベータ昇格）
- **対象**: Claude Managed Agents API + Claude Code（**Claude Code 側は引き続き `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` フラグ要、experimental 表記**。本機能の "公開ベータ" は Managed Agents 側 API での状態）
- **概要**: 1 つのリードエージェントが複数のサブエージェントに**並列でタスクを分解 / 委任 / 統合**するオーケストレーション機能。各サブエージェントは独立コンテキストで動作し、結果が time-to-completion・品質双方を向上。
- **Claude Code 側の Agent Teams**:
  - lead / teammate モデル、tmux / in-process 表示、subagent 定義 reuse、TaskCreated / TaskCompleted / TeammateIdle hooks 対応
  - **既知の制限**: in-process teammate での `/resume` / `/rewind` 非対応、タスクステータスの遅延、ネストチーム不可、リーダー固定（昇格・委譲不可）
- **使用例**: PR レビューを 3 体（セキュリティ / パフォーマンス / テストカバレッジ）並列、デバッグで複数仮説を別エージェントが互いに反証しながら検証、リファクタを 4 体並列で別モジュール担当
- **情報源**: [Simon Willison Live blog（5/6）](https://simonwillison.net/2026/May/6/code-w-claude-2026/) / [Anthropic Blog - New in Claude Managed Agents](https://claude.com/blog/new-in-claude-managed-agents) / [Agent Teams Docs](https://code.claude.com/docs/en/agent-teams) / [Multi-agent Sessions Docs](https://platform.claude.com/docs/en/managed-agents/multi-agent)

### 7. Dreaming 🔬 Research Preview（Managed Agents・新機能）

- **リリース状態**: 🔬 **Research Preview**（5/6 launch、要 [アクセス申請](https://claude.com/form/claude-managed-agents)）
- **対象**: Claude Managed Agents 利用者の中で申請通過した開発者（Claude Code でも `/dream` コマンドで利用される実装が観測されているが、Managed Agents 側の機能として正式発表）
- **概要**: **エージェントが過去のセッションを再点検し、自分が見落とした点・繰り返したミス・反復パターンを抽出して memory artifact を再構成**する自己改善機能。Anthropic 公式は「**重要な"経験"の上澄み**」「**人間が経験から学ぶように、Claude も眠る間に整理する**」と説明。
- **動作モード**:
  1. **自動モード**: バックグラウンドの memory consolidation プロセスとしてセッション間に走る。stale notes の prune、重複 merge、矛盾解消、CLAUDE.md 系のリオーガナイズ
  2. **手動モード**: `/dream` コマンドで明示起動（Claude Code 側実装、コミュニティでは "Auto Dream" / "AutoDream" の呼称で観測）
- **Memory との連携**: Memory（既存 Public Beta）が「学んだことを記録」するレイヤー、Dreaming が「学んだことを精緻化・統合」するレイヤー。**Multi-Agent Orchestration と組み合わせると複数エージェント間の共通学びを横断抽出**できる。
- **想定ユースケース**: 法務 drafting・大規模ログ分析・ドキュメント品質チェック・writing automation（公式言及）。Claude Code では「同じバグパターンを毎週踏むチームのメモリを夜間に整理」用途が想定される。
- **情報源**: [Simon Willison Live blog（5/6）](https://simonwillison.net/2026/May/6/code-w-claude-2026/) / [Anthropic Blog - New in Claude Managed Agents](https://claude.com/blog/new-in-claude-managed-agents) / [Lets Data Science - Dreaming for Claude agent memory consolidation](https://letsdatascience.com/news/anthropic-introduces-dreaming-for-claude-agent-memory-consol-32a279c9) / [TestingCatalog - Anthropic debuts Dreaming](https://www.testingcatalog.com/anthropic-debuts-reaming-for-claude-managed-agents-in-new-preview/) / [US News - Dreaming Feature](https://money.usnews.com/investing/news/articles/2026-05-06/anthropic-unveils-dreaming-feature-to-help-its-ai-agents-self-improve)

### 8. SpaceX Colossus 1 提携 + Claude Code レート制限倍増

- **リリース状態**: ✅ 提携締結済み（5/6 同日発表、Bloomberg / CNBC / Engadget スクープ）
- **コンピュート規模**:
  - **Colossus 1（Memphis、TN）の全容量** を Anthropic に開放
  - **300MW 以上の AI コンピュート容量** を **1 ヶ月以内** に追加
  - **220,000+ Nvidia GPU** を確保
  - 計画: SpaceX と協業して **multi-gigawatt の orbital AI コンピュート容量**（衛星コンステレーション基盤）を開発する意向（FCC ペーパー提出済み）
- **戦略的位置づけ**:
  - SpaceX は 2026 年初頭に **xAI と合併**し、Musk は AI 領域に深く関与。Anthropic（Claude）と xAI（Grok）は競合だが、SpaceX の中立的な infra 提供者ロール（Tesla の電力 / Starlink の通信に近い汎用インフラ層）として整理
  - Musk は「Anthropic team に impressed、Claude が beneficial になる確率は probably」と発言。一方で「Claude が harm を引き起こす場合はコンピュートを reclaim する権利留保」も明言
  - Anthropic にとっては **Amazon（既存メイン基盤）+ Google（Broadcom TPU 提携、2027 稼働予定）+ CoreWeave（4/10 提携）+ SpaceX Colossus 1（5/6 提携）** の 4 軸インフラ体制が確立
- **Claude Code レート制限倍増**:
  - **Pro / Max / Enterprise の 5 時間ウィンドウのレート制限を倍増** → コンピュート供給量増を即座にユーザー還元
  - **Pro / Max のピーク時間制限を撤廃**（過去にユーザー reaction で問題化していた "peak hours" restrictions を完全削除）
  - **API の Claude Opus モデルのレート制限を大幅引き上げ**
- **情報源**: [Bloomberg - Anthropic Inks Computing Deal With SpaceX](https://www.bloomberg.com/news/articles/2026-05-06/anthropic-inks-computing-deal-with-spacex-to-meet-ai-demand) / [CNBC - Anthropic, SpaceX announce compute deal that includes space development](https://www.cnbc.com/2026/05/06/anthropic-spacex-data-center-capacity.html) / [Engadget - Anthropic is doubling Claude Code rate limits after deal with SpaceX](https://www.engadget.com/2166315/anthropic-is-doubling-claude-code-rate-limits-after-deal-with-spacex/) / [PCWorld - Anthropic doubles Claude Code limits, thanks to a deal with SpaceX](https://www.pcworld.com/article/3132997/anthropic-doubles-claude-code-limits-thanks-to-a-deal-with-spacex.html) / [Inc. - Anthropic and SpaceX](https://www.inc.com/ben-sherry/anthropic-and-spacex-just-announced-a-colossal-deal-to-supercharge-claude-ai/91341165) / [CoinDesk - Colossus 1 ahead of June IPO](https://www.coindesk.com/tech/2026/05/06/anthropic-signs-elon-musk-s-spacex-for-colossus-1-compute-ahead-of-june-ipo)

---

## CLI リリース詳細（Layer 1）

### v2.1.129（2026-05-06 01:40 UTC、キーノート前リリース）

**新機能 / 設定追加**

- `--plugin-url <url>` フラグ: URL から **プラグイン .zip アーカイブ** を取得して当該セッション内で利用（v2.1.128 の `--plugin-dir <path>.zip` の URL 版）
- `CLAUDE_CODE_FORCE_SYNC_OUTPUT=1` 環境変数: **synchronized output** を強制有効化（auto-detection が漏れる Emacs `eat` 等のターミナル向け）
- `CLAUDE_CODE_PACKAGE_MANAGER_AUTO_UPDATE`: **Homebrew / WinGet** インストール時に backgrond で upgrade コマンド実行 → 再起動プロンプト
- `skillOverrides` 設定が機能するように: `off` でモデルと `/` 双方から非表示、`user-invocable-only` でモデルからのみ非表示、`name-only` で description を畳む

**挙動変更（重要）**

- **Gateway `/v1/models` ディスカバリーを opt-in 化**（`CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1` で有効化）。**v2.1.126〜v2.1.128 では自動有効**だったが、ユーザーフィードバックを受けて **opt-in に巻き戻し**。LiteLLM / OpenRouter / 内製プロキシ等でモデル発見を望むユーザーは明示的に環境変数を設定する必要あり
- **Ctrl+R 履歴ピッカー**: 全プロジェクトを横断検索する **v2.1.124 以前の挙動に復帰**。Ctrl+S で当該プロジェクト / セッションに絞り込み（v2.1.124 以降のデフォルトの逆転）
- 第三者デプロイメント（Bedrock / Vertex / Foundry / `ANTHROPIC_BASE_URL` ゲートウェイ）: **first-party Anthropic surfaces を指す spinner tips を非表示**

**プラグイン manifest 警告**

- `themes` / `monitors` の宣言は `"experimental": { ... }` 配下に移行を推奨。トップレベル宣言は引き続き動作するが `claude plugin validate` で警告表示

**メトリクス・監視**

- `claude_code.pull_request.count` OTel メトリック: シェルコマンドだけでなく **MCP ツール経由** の PR / MR 作成もカウント
- ポリシー refusal エラーメッセージに **API Request ID** を含める（サポートデバッグ容易化）

**バグ修正**

- API エラーで未認識 400 ステータスコードが raw JSON 表示される問題 → 内部エラーメッセージ表示に
- `/clear` がターミナルタブタイトルをリセットしない問題
- `/rename` セッションタイトルチップが permission ダイアログ中に消える問題
- subagent 実行中にエージェントパネルが隠れる問題（v2.1.122 リグレッション）
- 外部エディタハンドオフ（Ctrl+G）が会話履歴をブランクにする問題
- **`/context` が ASCII 可視化グリッドを会話に dump して ~1.6k トークンを浪費する問題**
- `/agents` Library リストの矢印キーナビゲーション（ハイライト項目が viewport 外に逃げる問題）
- `/branch` 成功メッセージに新ブランチセッション ID を含めない問題（`/resume` 用）
- 太字ヘッダーで keycap / ZWJ / skin-tone emoji の末尾文字がフルスクリーンモードで欠落
- **server-managed settings ポリシーが、`user:inference` スコープ欠落の OAuth 資格情報を持つ Enterprise/Team ユーザーに適用されない問題**
- **wake-from-sleep 後の OAuth refresh レース**で全実行中セッションがログアウトされる問題
- **1 時間プロンプトキャッシュ TTL が無音で 5 分にダウングレードされる問題**
- `/clear` / コンパクション後の `/effort` / `/model` 変更時に **誤った cache-miss 警告**
- **`Bash(mkdir *)`、`Bash(touch *)` 等の allow ルールがプロジェクト内パスで尊重されない問題**
- `deniedMcpServers` パターンの `*://` スキームワイルドカードが大文字小文字混在ホスト名にマッチしない問題
- voice モード中の `--debug` で WebSocket 警告がエラーログに記録される問題
- [VSCode] `/clear` が会話コンテキストと表示トランスクリプトを clear しない問題

### v2.1.131（2026-05-06 07:47 UTC、キーノート前ホットフィックス）

- **VS Code 拡張が Windows でアクティベーション失敗** → bundled SDK にハードコードされたビルドパス（`createRequire` polyfill バグ）を修正
- **Mantle エンドポイント認証で `x-api-key` ヘッダー欠落** → 修正

> v2.1.130 は欠番（GitHub Releases / 公式 Changelog いずれにも entry なし、内部ロールバックの可能性）

### v2.1.132（2026-05-06 22:08 UTC、キーノート後リリース）

**新機能 / 環境変数**

- **`CLAUDE_CODE_SESSION_ID`** 環境変数を Bash ツールサブプロセス環境に追加: hooks に渡される `session_id` と同一値で、Bash 側スクリプト・サブプロセスからセッションを識別可能に（telemetry / log correlation 向け）
- **`CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN=1`** 環境変数: フルスクリーン alternate-screen レンダラーをオプトアウトして、**会話をターミナルのネイティブ scrollback に保持**。`/tui fullscreen` の逆操作にあたり、ログ取得・スクリーンショット系ワークフロー向けの選択肢
- Ctrl+V 画像ペースト中に **「Pasting...」** フッターヒントを表示（クリップボード読み込み待ちの可視化）

**バグ修正（抜粋）**

- **外部 SIGINT（IDE stop ボタン / `kill -INT`）でグレースフルシャットダウンが走らなかった問題** → ターミナルモード復元 + `--resume` ヒント表示が走るように
- ターミナルクローズ / SSH 切断中に native build で uncaught exception
- **`--resume` が `no low surrogate in string` で失敗する問題**（ツールエラー truncation が emoji を分割した場合）→ 既存破損セッションも load 時に sanitize
- **`--permission-mode` フラグが plan-mode セッション resume 時に無視される問題**、`ExitPlanMode` 後の plan モード再適用問題
- フルスクリーンモードがラップトップ sleep / wake、Ctrl+Z / `fg` 後にブランク画面を表示する問題（次のキーストロークまで描画されない）
- **Indic conjunct / ZWJ emoji がライン折り返しを跨ぐとき Ctrl+E / A / K / U / 矢印キーで grapheme 中央にカーソルが着地する問題**
- vim operators が NFD（decomposed）アクセント文字を含むテキストを破損させる問題
- **`/` で始まる貼り付けテキストが silently swallow される / 未知コマンド扱いされる問題**
- bracketed paste と focus events / mouse-tracking レポートが交錯すると prompt にエスケープシーケンスが残る問題
- **Cursor / VS Code 1.92–1.104 / JetBrains IDE 2025.2 のマウスホイールスクロール過速・誤方向問題**（xterm.js upstream バグの workaround）
- `/usage` Ctrl+S（Linux/X11 でクリップボードへスクリーンショットコピー）が hang する問題
- `/terminal-setup` が **Windows Terminal** で誤った Shift+Enter エラーを表示する問題（Windows Terminal は natively サポート）
- **`/effort` ピッカーが `CLAUDE_CODE_EFFORT_LEVEL` 環境変数 override を反映しない問題**
- `/status` が一部ユーザーで誤ったデフォルトモデルを表示する問題
- スラッシュコマンド autocomplete ポップアップが ~3-5 件で頭打ちになる問題（ターミナル高さスケール対応）
- **statusline の `context_window` トークンカウントが累積セッション合計を表示する問題** → 現在のコンテキスト使用量を表示するように修正
- macOS の Alt+T（thinking toggle）が "Option as Meta" 未設定ターミナル（iTerm2 / Terminal.app デフォルト）で機能しない問題
- Windows の `claude agents` から background セッション再オープン時の dead keyboard 入力
- **stdio MCP サーバーが non-protocol データを stdout に書くと unbounded メモリ増加（10GB+ RSS）する問題**
- **MCP サーバーが connect 後に `tools/list` 失敗で 0 ツール表示される問題** → 1 回リトライ + `/mcp` で「connected · tools fetch failed」表示
- 未認証 claude.ai MCP コネクタが「failed」表示される問題 → 「needs auth」表示に
- ヘッドレス `-p` モードで非 transient 4xx 接続失敗をリトライしないように
- **Bedrock / Vertex で `ENABLE_PROMPT_CACHING_1H` 設定時の 400 エラー** 修正
- `/login`、`/upgrade`、`/extra-usage` ダイアログ間の視覚一貫性向上
- `/tui fullscreen` 起動バナーに lower memory usage / mouse support / auto-copy on select の説明追加

---

## バグ修正・パフォーマンス改善（Layer 1 サマリー）

3 リリース合計で **70 件以上の修正**が投入された。特に注目すべきは：

| カテゴリ | v2.1.129 | v2.1.131 | v2.1.132 |
|---------|----------|----------|----------|
| **OAuth / 認証** | wake-from-sleep refresh レース、Enterprise scope 欠落、policy refusal API Request ID | Mantle x-api-key | unauthorized claude.ai connectors の表示改善 |
| **`Bash` / 権限** | `Bash(mkdir *)` / `Bash(touch *)` allow ルール尊重、`deniedMcpServers` 大文字小文字 | — | 外部 SIGINT graceful shutdown、`/effort` 環境変数反映 |
| **MCP** | OTel `pull_request.count` MCP 経由対応 | — | stdio MCP メモリリーク（10GB+ RSS）、`tools/list` 失敗時の retry & 表示 |
| **キャッシュ** | 1H prompt cache TTL silent ダウングレード、cache-miss 誤警告 | — | Bedrock/Vertex 1H caching 400 |
| **TUI / 表示** | `/clear` ターミナルタイトル、太字 emoji 末尾欠落、`/agents` ナビ | VS Code Windows | フルスクリーン sleep/wake、Indic / ZWJ grapheme カーソル、マウスホイール過速 |
| **`/context` / `/usage`** | `/context` ASCII grid 1.6k トークン浪費 | — | `/usage` Linux/X11 hang、statusline コンテキスト累積誤計算 |

---

## リリース一覧

| バージョン | 日付（UTC） | 主要変更 |
|-----------|------------|---------|
| v2.1.128 | 2026-05-04 23:01 | （前回レポート反映済み）45 項目改善・`--channels` コンソール認証対応 |
| **v2.1.129** | **2026-05-06 01:40** | `--plugin-url`、Homebrew/WinGet 自動更新、ゲートウェイモデルディスカバリー opt-in 化、Ctrl+R 全プロジェクト復帰、30+ 修正 |
| **v2.1.131** | **2026-05-06 07:47** | VS Code 拡張 Windows 起動修正、Mantle x-api-key 修正 |
| **v2.1.132** | **2026-05-06 22:08** | `CLAUDE_CODE_SESSION_ID`、`CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN`、外部 SIGINT graceful shutdown、stdio MCP メモリリーク修正、35+ 修正 |

> v2.1.130 は欠番（内部 release rolled back の可能性）

---

## 関連プラットフォーム動向（Layer 2 / Layer 3）

### Code with Claude SF 2026 — その他のシグナル

- **「No new model」**: Vora が冒頭で明確に否定。Sonnet 4.8 / Jupiter / Cardinal 等の事前リーク noise（4-5 月）はすべてクリア。**Opus 4.7 を「より深く使う」方向にメッセージ統一**。前 Sonnet 世代（Sonnet 4.6）と Opus 4.7 の組み合わせで多くのケースをカバーし、新世代モデルは別タイミング（おそらく 5/19 London / 6/10 Tokyo or Q3）に温存
- **API トラフィック前年比 17 倍**: Vora 発表数値。OpenAI 比較値・MAU は非公開
- **3 トラック構成**: Research / Claude Platform / Claude Code が並走。Claude Code トラックでは long-horizon タスク・multi-repo 作業へのスケーリングが主題
- **5/7 SF Extended Day**: インディ開発者・スタートアップファウンダー向け companion event。コミュニティトークと workshop 中心、5/6 メイン日とは別構成
- **次回**: London 5/19-20 / Tokyo 6/10-11

### Layer 3 — メディア論調

- **Engadget / PCWorld / TechRadar**: SpaceX 提携と Claude Code レート制限倍増を 1 セットで報道。「**Anthropic がコンピュート不足を逆に GA 機能のローンチを加速する材料に転換**」のフレーミング
- **Bloomberg / CNBC**: SpaceX 提携を **Anthropic の 6 月 IPO 想定**（4/29 スクープの $850-900B 評価額）の文脈で扱う。Colossus 1 全容量確保を「IPO ロードショーの追い風」と評価
- **CoinDesk**: 「ahead of June IPO」と明示。OpenAI / SpaceX / Anthropic のプレ IPO トリオを Pre-IPO Perpetual Futures（OKX 取扱）の文脈で連結
- **Spyglass**: **xAI が SpaceX のもう一方の AI 顧客**である状況を整理し、Musk の中立化（Tesla の電力供給と類比）を分析

### Layer 2 — 公式ブログ反映

- 5/6 公式ブログ「**New in Claude Managed Agents: dreaming, outcomes, and multiagent orchestration**」: 法務 drafting・ログ分析・ドキュメント品質チェック・writing automation を初期ユースケースとして紹介
- 5/5 公式ブログ「**Deploying Claude across financial services**」: 5/5 NYC The Briefing の正式ブログ化、Finance Agent Templates と M365 統合 GA を中心に整理（既反映）
- 5/1 公式ブログ「**How a non-technical project manager built and shipped a stress management app with Claude Code in six weeks**」: 既反映、非技術者ケーススタディ

---

## 情報源一覧

### Layer 1（公式チェンジログ）

- [Claude Code Changelog (公式)](https://code.claude.com/docs/en/changelog)
- [Release v2.1.129 (GitHub)](https://github.com/anthropics/claude-code/releases/tag/v2.1.129)
- [Release v2.1.131 (GitHub)](https://github.com/anthropics/claude-code/releases/tag/v2.1.131)
- [Release v2.1.132 (GitHub)](https://github.com/anthropics/claude-code/releases/tag/v2.1.132)
- [CHANGELOG.md (raw)](https://raw.githubusercontent.com/anthropics/claude-code/refs/heads/main/CHANGELOG.md)
- [Releasebot - Claude Code Updates by Anthropic - May 2026](https://releasebot.io/updates/anthropic/claude-code)

### Layer 2（公式ブログ・APIドキュメント・ドキュメント）

- [Anthropic Blog](https://claude.com/blog)
- [Code with Claude San Francisco — May 6, 2026](https://claude.com/code-with-claude/san-francisco)
- [Code with Claude (公式 events)](https://claude.com/code-with-claude)
- [Agent Teams Docs](https://code.claude.com/docs/en/agent-teams)
- [Code Review Docs](https://code.claude.com/docs/en/code-review)
- [Automated Security Reviews in Claude Code (Help Center)](https://support.claude.com/en/articles/11932705-automated-security-reviews-in-claude-code)
- [Claude Managed Agents Overview (公式 Docs)](https://platform.claude.com/docs/en/managed-agents/overview)
- [Multiagent Sessions (公式 Docs)](https://platform.claude.com/docs/en/managed-agents/multi-agent)
- [claude-code-security-review (GitHub)](https://github.com/anthropics/claude-code-security-review)
- [Claude API Release Notes](https://platform.claude.com/docs/en/release-notes/overview)
- [Release notes (Help Center)](https://support.claude.com/en/articles/12138966-release-notes)

### Layer 3（ニュースメディア）

- [Simon Willison - Live blog: Code w/ Claude 2026](https://simonwillison.net/2026/May/6/code-w-claude-2026/)
- [Engadget - Anthropic is doubling Claude Code rate limits after deal with SpaceX](https://www.engadget.com/2166315/anthropic-is-doubling-claude-code-rate-limits-after-deal-with-spacex/)
- [PCWorld - Anthropic doubles Claude Code limits, thanks to a deal with SpaceX](https://www.pcworld.com/article/3132997/anthropic-doubles-claude-code-limits-thanks-to-a-deal-with-spacex.html)
- [Bloomberg - Anthropic Inks Computing Deal With SpaceX](https://www.bloomberg.com/news/articles/2026-05-06/anthropic-inks-computing-deal-with-spacex-to-meet-ai-demand)
- [CNBC - Anthropic, SpaceX announce compute deal](https://www.cnbc.com/2026/05/06/anthropic-spacex-data-center-capacity.html)
- [Inc. - Anthropic and SpaceX colossal deal](https://www.inc.com/ben-sherry/anthropic-and-spacex-just-announced-a-colossal-deal-to-supercharge-claude-ai/91341165)
- [CoinDesk - Anthropic signs SpaceX for Colossus 1 ahead of June IPO](https://www.coindesk.com/tech/2026/05/06/anthropic-signs-elon-musk-s-spacex-for-colossus-1-compute-ahead-of-june-ipo)
- [Spyglass - Anthropic Boosts SpaceX into the Neocloud Orbit](https://spyglass.org/anthropic-spacex-xai-data-centers/)
- [Cryptobriefing - Anthropic brings dreaming, outcomes, and multiagent orchestration](https://cryptobriefing.com/anthropic-claude-agents-dreaming/)
- [TestingCatalog - Anthropic debuts Dreaming for Claude Managed Agents](https://www.testingcatalog.com/anthropic-debuts-reaming-for-claude-managed-agents-in-new-preview/)
- [US News - Anthropic Unveils 'Dreaming' Feature](https://money.usnews.com/investing/news/articles/2026-05-06/anthropic-unveils-dreaming-feature-to-help-its-ai-agents-self-improve)
- [Lets Data Science - Anthropic introduces dreaming](https://letsdatascience.com/news/anthropic-introduces-dreaming-for-claude-agent-memory-consol-32a279c9)
- [Technobezz - Anthropic Introduces Dreaming Feature](https://www.technobezz.com/news/anthropic-introduces-dreaming-feature-for-claude-agents-to-self-improve-overnight)
- [VentureBeat - Anthropic released a mobile version of Claude Code called Remote Control](https://venturebeat.com/orchestration/anthropic-just-released-a-mobile-version-of-claude-code-called-remote)
- [TechRadar - Remote Control mobile version](https://www.techradar.com/pro/anthropic-reveals-remote-control-a-mobile-version-of-claude-code-to-keep-you-productive-on-the-move)
- [Techzine - Remote Control extends Claude Code to the mobile app](https://www.techzine.eu/news/devops/139101/remote-control-extends-claude-code-to-the-mobile-app/)
- [InfoQ - Anthropic Introduces Agent-Based Code Review for Claude Code](https://www.infoq.com/news/2026/04/claude-code-review/)
- [FindSkill.ai - Code With Claude SF Tomorrow Playbook](https://findskill.ai/blog/code-with-claude-may-6-livestream-playbook-five-launches/)
- [GadgetBond - Code with Claude 2026 dates confirmed](https://gadgetbond.com/code-with-claude-2026-anthropic-developer-conference/)
- [EventBrowse - Anthropic Code with Claude SF 2026](https://eventbrowse.com/event/anthropic-code-with-claude-sf-2026/)
