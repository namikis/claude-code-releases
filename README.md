# Claude Code Releases

Claude Codeの機能・アップデートを追跡するドキュメントサイト。

## サイト

**https://namikis.github.io/claude-code-releases/**

[docsify](https://docsify.js.org/) ベースの静的サイト。GitHub Pages でホスティング。

## コンテンツ

- **[現行機能一覧](CURRENT_FEATURES.md)** — Claude Codeの全機能をカテゴリ別にまとめた累積ドキュメント
- **[調査レポート](reports/)** — 個別の調査結果レポート

---

## 日次自動更新ジョブ

毎日 **11:00 JST** に macOS launchd で以下のパイプラインが自動実行されます。

### フロー

```
launchd (11:00 JST)
  │
  ├─ Step 1: GitHub Releases API で最新バージョンを取得
  │   └─ CURRENT_FEATURES.md に既出 → 終了（何もしない）
  │
  ├─ Step 2: Claude CLI で調査エージェントを実行
  │   └─ 公式チェンジログ・ブログ・ニュースメディアを3層で調査
  │   └─ reports/ にレポート保存、CURRENT_FEATURES.md を更新
  │
  ├─ Step 3: git diff で変更を検出
  │   └─ 変更なし → 終了（何もしない）
  │
  └─ Step 4: git commit & push → GitHub Pages 自動デプロイ
```

### 「何もしない」条件

以下のいずれかに該当する場合、コミット・プッシュは行われません：

1. **新リリースが未検出**: GitHub Releases API の最新タグが `CURRENT_FEATURES.md` に既に記載済み
2. **実質的な変更なし**: エージェント実行後も `git diff` で差分がゼロ

### ファイル構成

| ファイル | 説明 |
|---------|------|
| `scripts/daily-update.sh` | オーケストレーションスクリプト（チェック→調査→コミット→プッシュ） |
| `scripts/check-new-release.sh` | GitHub Releases API で新バージョンの有無を判定 |
| `com.claude-code-releases.daily-update.plist` | macOS launchd ジョブ定義（毎日 11:00） |
| `logs/` | 実行ログ（`.gitignore` で除外済み） |

### デプロイ環境

| 項目 | 値 |
|------|-----|
| **ホスティング** | GitHub Pages（`main` ブランチ直接配信） |
| **サイトURL** | https://namikis.github.io/claude-code-releases/ |
| **デプロイ方法** | `git push origin main` → GitHub Pages が自動ビルド |
| **デプロイ制限** | 1時間あたり10ビルドまで（日次1回なので問題なし） |
| **帯域制限** | 月100GB（静的Markdownサイトのため十分） |
| **スケジューラ** | macOS launchd（スリープ復帰後に未実行分を自動実行） |
| **調査エンジン** | Claude CLI + `claude-code-feature-research` エージェント |
| **Claude CLI パス** | `/Users/tairyu/.local/bin/claude` |

### セットアップ

```bash
# launchd ジョブを登録
cp com.claude-code-releases.daily-update.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.claude-code-releases.daily-update.plist

# 手動実行（テスト用）
./scripts/daily-update.sh

# ジョブの確認
launchctl list | grep claude-code-releases

# ジョブの停止
launchctl unload ~/Library/LaunchAgents/com.claude-code-releases.daily-update.plist
```

### ログの確認

```bash
# 今日のログ
cat logs/$(date +%Y-%m-%d).log

# launchd の標準出力/エラー
cat logs/launchd-stdout.log
cat logs/launchd-stderr.log
```

---

## 手動調査の実行

Claude Code で本リポジトリを開き、以下のいずれかで調査エージェントを呼び出せます：

```
Claude Codeの新機能を調べて
@claude-code-feature-research 過去2週間の新機能を調査して
```

調査エージェントが自動的に以下を実行します：
1. 公式チェンジログ・ブログ・ニュースメディアを3層で調査
2. `reports/` に調査レポートを保存
3. `CURRENT_FEATURES.md` を最新情報でマージ更新
