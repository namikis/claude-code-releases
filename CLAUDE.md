# Claude Code Releases プロジェクト

Claude Codeの新機能・アップデートを追跡するドキュメントリポジトリ。

## プロジェクト構成

- `CURRENT_FEATURES.md` — 現行機能一覧（累積ドキュメント）
- `reports/` — 日次調査レポート
- `investigations/` — 深掘り調査レポート
- `index.html`, `_sidebar.md`, `.nojekyll` — docsifyサイト用
- `.claude/agents/` — 調査エージェント定義
- `.claude/skills/` — スキル定義（research, agent-creator, deep-dive, suggest）
- `scripts/` — 自動化スクリプト（日次更新ジョブ）
- `logs/` — 実行ログ（gitignore対象）
- `com.claude-code-releases.daily-update.plist` — macOS launchd ジョブ定義

## ワークフロー

1. 調査エージェント（`@claude-code-feature-research`）で新機能を調査
2. `reports/` にレポートを保存
3. `CURRENT_FEATURES.md` を更新
4. `_sidebar.md` にレポートへのリンクを追加
5. 深掘り調査（`/deep-dive`）で特定トピックを詳細調査 → `investigations/` に保存

## タスク完了後の改善提案

ユーザーから指示されたタスクを完了した後、そのタスクに関連する改善点が明確にある場合は `/suggest` スキルを呼び出して改善提案を行うこと。

- 改善点が特にない場合はスキルを呼ばずにそのまま終了してよい
- ユーザーが「提案不要」「改善提案はいらない」等と指示した場合はスキップする
- 些末な改善（空行調整、コメント追加等）しかない場合もスキップする

## 応答言語

ユーザーへの応答は日本語で行う。
