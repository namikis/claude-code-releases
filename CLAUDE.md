# Claude Code Releases プロジェクト

Claude Codeの新機能・アップデートを追跡するドキュメントリポジトリ。

## プロジェクト構成

- `CURRENT_FEATURES.md` — 現行機能一覧（累積ドキュメント）
- `reports/` — 個別の調査レポート
- `index.html`, `_sidebar.md`, `.nojekyll` — docsifyサイト用
- `.claude/agents/` — 調査エージェント定義
- `.claude/skills/` — スキル定義（research, agent-creator）
- `scripts/` — 自動化スクリプト（日次更新ジョブ）
- `logs/` — 実行ログ（gitignore対象）
- `com.claude-code-releases.daily-update.plist` — macOS launchd ジョブ定義

## ワークフロー

1. 調査エージェント（`@claude-code-feature-research`）で新機能を調査
2. `reports/` にレポートを保存
3. `CURRENT_FEATURES.md` を更新
4. `_sidebar.md` にレポートへのリンクを追加

## 応答言語

ユーザーへの応答は日本語で行う。
