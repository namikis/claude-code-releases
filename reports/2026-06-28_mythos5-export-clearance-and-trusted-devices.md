# 調査レポート: Mythos 5 の輸出規制部分解除（100+ 米機関）・Trusted Devices for Remote Control

**調査日:** 2026-06-28

> **調査モード: ニュースモード**（新 CLI リリースなし → Layer 1〔チェンジログ〕はスキップ。Layer 2〔公式ブログ・APIドキュメント・Help Center〕と Layer 3〔ニュースメディア〕のみ調査）

## 概要

- **🆕 Layer 3 — 米政府が Claude Mythos 5 の輸出規制を部分解除（6/26 金曜・Lutnick 商務長官の書簡）。** 6/12 の輸出管理指令で全面停止していた Mythos 5 を、**100 を超える「信頼できる」米国機関**（Project Glasswing 参加の著名テック企業約 100 社＋連邦政府機関、クリティカルインフラの運用・防衛主体）へ展開する許可が下りた。**書簡は Fable 5（公開版）には言及せず、Fable 5 は引き続き停止**。前回 6/27 レポートはこの政策展開を捕捉できておらず（バイラルな「Fable 復活」否定と Bloomberg の Alibaba 告発に注力）、本レポートで補完する。
- **🆕 Layer 2 — Trusted Devices for Remote Control（Claude Code）が 6/25 に提供開始**（Help Center リリースノート）。**🧪 ベータ、Team / Enterprise 向け**。管理者が、メンバーが **ローカル Claude Code セッションをリモートから閲覧・操作する前にデバイス検証を必須化**できる組織横断設定。前回 6/27 レポート（v2.1.195 まで／6/26 まで）では未捕捉だったため新規追加。
- **新 CLI リリースなし**（Layer 1 はニュースモードのためスキップ。Layer 1 最新は前回の v2.1.195）。
- **公式ニュースルームの新規投稿は 6/23「Introducing Claude Tag」以降なし**（6/24〜28 に新規ブログ投稿なし）。Mythos 5 解除は Anthropic 公式ブログではなく **Lutnick 書簡＋報道（CNBC / The Hill / 9to5Mac / BeInCrypto / Yahoo / SRN〔Semafor 経由〕）ベース**。
- 参考: Apple Foundation Models 連携（`ClaudeForFoundationModels` Swift パッケージ）が検索上位に再浮上したが、**公開は 2026-06-08〜09 で既出**につき本サイクルの新情報ではなく除外。

---

## 主要トピック

### 🆕 Mythos 5 の輸出規制部分解除 — 100+ 米国機関へ展開許可（6/26）📢/🔬

**何が起きたか**

- **2026-06-26（金）**、**商務長官 Howard Lutnick** が Anthropic 宛ての書簡で、**Claude Mythos 5 を 100 を超える米国機関に展開する許可**を通知。対象は **Project Glasswing に参加する著名テック企業約 100 社＋連邦政府機関**で、いずれも**クリティカルインフラを運用・防衛する「信頼できる（trusted）」米国組織**と位置づけられる。
- これは **6/12 の輸出管理指令以来の大きな方針転換**。6/12 の指令は、Amazon CEO Andy Jassy が財務長官 Scott Bessent に Fable 5 の jailbreak 脆弱性を伝えたことを発端に、Mythos 5 と下位版 Fable 5 を全面停止していた（2 週間の交渉を経た解除）。
- **Fable 5（一般公開版）は書簡で言及されず、停止継続。** 関係者は「Fable の解放に向けても交渉が進んでいるが、時期は不明」とするにとどまる。

**ステータスの読み方（重要）**

- 今回の解除は **輸出管理上の政策決定（許可付与）**であり、各機関への**実展開・製品としての再有効化が完了したことを直ちに意味しない**。前回 6/27 レポートが報告した「**公開版 Fable 5 はトラフィックゼロ／モデルピッカー目撃は UI バグ**」という状況と矛盾しない（あちらは一般公開版 Fable 5 の話、こちらは限定提供 Mythos 5 の政策解除）。
- 対象機関の多くは**もともと Project Glasswing 経由で Mythos Preview を利用していた組織**であり、今回の解除はその限定提供ラインの**輸出規制ブロックを解いた**形。一般ユーザー・国際ユーザー・Fable 5 公開版は対象外。
- **Claude Code との直接関係は報道では言及なし。** ただし Mythos クラスは Claude Code / Claude Security 経由提供のリーク（5/25 BleepingComputer 等）があり、限定提供ラインの再開は防御的サイバーセキュリティ用途での Claude Code 内アクセス経路に間接的に関わり得る（要追跡）。

**リリース状態**: 📢 政策解除は公式（Lutnick 書簡＋複数主流メディア報道）。Mythos 5 自体は **🔮 限定提供（Glasswing + 連邦機関）への再開フェーズ**。Fable 5 公開版は **⛔ 停止継続**。

**確度**: 政策決定＝高（CNBC / The Hill / 9to5Mac / BeInCrypto / Yahoo / SRN〔Semafor〕の複数報道一致）。Anthropic 公式ブログでの正式アナウンスは 6/28 時点で未確認、実展開タイムラインは未公表。

---

### 🆕 Trusted Devices for Remote Control（Claude Code）🧪 ベータ（6/25）

**何ができるか**

- **Team / Enterprise プラン**の管理者が、メンバーに対し **ローカル Claude Code セッションをリモートから「閲覧（view）」または「操作（steer）」する前にデバイス検証を必須化**できる、組織横断（org-wide）設定。
- claude.ai / Claude モバイルアプリ / Claude Desktop から Remote Control セッションにアクセスする際、**サインイン済みアカウントだけでなく「既知のデバイス」＋「最近の認証」**にアクセスを紐付ける。
- **デバイス登録（enrollment）**: メンバーが Remote Control に使う**各ブラウザ・各スマホ・各デスクトップアプリが個別に資格情報（credential）を登録**。登録は**フルサインインの直後にのみ提示**され、実際の認証フローの一部としてデバイスが信頼リストに加わる（バックグラウンドでの暗黙登録は行わない）。

**利用条件・状態**

- **リリース状態**: 🧪 **ベータ**。
- **対象プラン**: **Team / Enterprise**。
- **デフォルト**: **オフ**（管理者が明示的に有効化するまで無効）。
- **位置づけ**: 5/6 に GA 化した **Remote Agents（旧 Remote Control）** のエンタープライズ向けセキュリティ強化。スマホ/Web からローカルセッションを操作できる利便性に対し、デバイス境界＋直近認証を要求してアクセスを引き締める。

**情報源**: [Release notes — Claude Help Center（6/25「Enable Trusted Devices for Remote Control」）](https://support.claude.com/en/articles/12138966-release-notes) / [Continue local sessions from any device with Remote Control — Claude Code Docs](https://code.claude.com/docs/en/remote-control)

---

## Layer 2/3: その他の動向

### 公式ニュースルーム — 新 Claude Code 製品発表なし（6/24〜28）

- Anthropic 公式ニュースルームは **6/23「Introducing Claude Tag」以降、6/24〜28 に新規投稿なし**（直近は 6/17 ソウルオフィス、6/12 Fable5/Mythos5 停止声明、6/11 Claude Corps）。
- Claude Tag for Slack（🧪 ベータ、Enterprise/Team、Opus 4.8）は前回までに反映済み。

### Apple Foundation Models 連携 — 既出（新情報ではない）

- `ClaudeForFoundationModels` Swift パッケージ（Apple の Foundation Models framework から Claude へハンドオフ、iOS/iPadOS/macOS/visionOS/watchOS 27 対応）が検索上位に再浮上したが、**公開は 2026-06-08 ブログ・6/9 提供開始で既出**。本サイクルの新情報ではないため記録のみ。

---

## リリース状態まとめ

| トピック | 状態 | 対象 | 備考 |
|---------|------|------|------|
| Claude Mythos 5（輸出規制解除） | 📢 政策解除 → 🔮 限定再開フェーズ | Glasswing 約 100 社 + 連邦機関（クリティカルインフラ） | 6/26 Lutnick 書簡。実展開タイムライン未公表 |
| Claude Fable 5（公開版） | ⛔ 停止継続 | 全ユーザー | 書簡で言及なし。解放交渉は継続も時期不明 |
| Trusted Devices for Remote Control | 🧪 ベータ | Team / Enterprise | 6/25。デフォルトオフ、デバイス検証必須化 |

---

## 情報源一覧

- [US government allows Anthropic to release Mythos 5 — CNBC（6/26）](https://www.cnbc.com/2026/06/26/us-government-anthropic-claude-mythos5-ai.html)
- [Anthropic cleared to release Claude Mythos 5 to over 100 US institutions — 9to5Mac（6/26）](https://9to5mac.com/2026/06/26/anthropic-cleared-to-release-claude-mythos-5-to-over-100-us-institutions/)
- [Federal government permits release of Anthropic's Mythos model to select companies — The Hill](https://thehill.com/policy/technology/5943549-anthropic-mythos-5-access/)
- [Claude Mythos 5 Cleared for 100 US Institutions: Will Fable 5 Follow? — BeInCrypto](https://beincrypto.com/anthropic-mythos-5-export-block-lifted/)
- [US allows Anthropic to release Mythos AI to 'trusted' US organizations — SRN News（Semafor 経由）](https://srnnews.com/us-releases-anthropic-model-mythos-to-some-us-companies-semafor-reports/)
- [US allows Anthropic to release Mythos AI to 'trusted' US organizations — Yahoo News](https://www.yahoo.com/news/politics/articles/us-allows-anthropic-release-mythos-161756887.html)
- [Release notes（Trusted Devices for Remote Control, 6/25）— Claude Help Center](https://support.claude.com/en/articles/12138966-release-notes)
- [Continue local sessions from any device with Remote Control — Claude Code Docs](https://code.claude.com/docs/en/remote-control)
- [Anthropic Newsroom](https://www.anthropic.com/news)
- [Claude support for Apple's Foundation Models framework（6/8 既出・参考）](https://claude.com/blog/claude-for-foundation-models)

## スキップしたURL

| URL | スキップ理由 |
|-----|------------|
| https://www.cnbc.com/2026/06/26/us-government-anthropic-claude-mythos5-ai.html | フェッチ時 HTTP 403（検索スニペット＋他媒体で内容補完） |
| https://thehill.com/policy/technology/5943549-anthropic-mythos-5-access/ | フェッチ時 HTTP 403（検索スニペットで内容補完） |
