# Claude Code Releases

Claude Codeの機能・アップデートを追跡するドキュメントサイト。

## コンテンツ

- **[現行機能一覧](CURRENT_FEATURES.md)** — Claude Codeの全機能をカテゴリ別にまとめた累積ドキュメント
- **[調査レポート](reports/)** — 個別の調査結果レポート

## サイト

GitHub Pages でホスティング: [docsify](https://docsify.js.org/) ベースの静的サイト。

## 調査の実行

Claude Code で本リポジトリを開き、以下のいずれかで調査エージェントを呼び出せます：

```
Claude Codeの新機能を調べて
@claude-code-feature-research 過去2週間の新機能を調査して
```

調査エージェントが自動的に以下を実行します：
1. 公式チェンジログ・ブログ・ニュースメディアを3層で調査
2. `reports/` に調査レポートを保存
3. `CURRENT_FEATURES.md` を最新情報でマージ更新
