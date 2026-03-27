# 調査レポート: Claude Code 過去2週間の新機能（2026年3月14日〜28日）

**調査日:** 2026-03-28

## 概要

2026年3月14日〜28日の2週間で、Claude Codeはv2.1.76からv2.1.85まで計**10バージョン**をリリースした。主要な新機能として、**Computer Use（デスクトップ操作）**、**Dispatch（クロスデバイス タスク委任）**、**Auto Mode（自動承認モード）**、**PowerShellツール（Windows向け）**、**MCP Elicitation（対話型入力）**、**トランスクリプト検索**、**Opus 4.6の出力トークン上限引き上げ（64k/128k）**、**`--bare`フラグ**、**`--channels`プレビュー**、**Hook/Agent系の大幅強化**などが含まれる。安定性・パフォーマンス面でも100件以上のバグ修正と多数の最適化が実施された。

---

## 詳細

### 1. Computer Use（デスクトップ操作）— 研究プレビュー（3月24日発表）

Claude Codeが組み込みツールでは対応できないタスクに遭遇した場合、**自動的にComputer Useモードに切り替わり、画面を直接操作**する。スクリーンショットの取得→画面分析→アクション実行（クリック、タイプ、スクロール等）のループで動作する。

**できること:**
- ブラウザの操作（Webサイト訪問、フォーム入力、データ抽出）
- ファイルシステム・テキストエディタの操作
- システムアプリケーション（Terminal、設定等）の制御
- 手動の開発ワークフローの自動化

**ツール優先順位:** Claude Codeは最も精度の高いツールから優先的に使用する:
1. 専用コネクタ（Slack、Google Calendar等）がある場合はそれを使用
2. シェルコマンドで可能ならBashを使用
3. ブラウザ作業でChrome拡張がセットアップ済みならそれを使用
4. 上記いずれも使えない場合に**Computer Use**を使用

**利用条件:**
- macOS限定（Windows対応は近日予定）
- Pro / Maxプラン加入者向け
- Claude Desktopアプリが起動中であること
- 設定 > Desktop app > General から Computer Use をONに
- macOSのアクセシビリティ権限と画面収録権限の付与が必要

**安全対策:**
- 初めてアプリにアクセスする際はユーザーに許可を求める
- プロンプトインジェクション検出の自動スキャン
- ユーザーはいつでもClaudeを停止可能
- 一部アプリはデフォルトでブロック
- Dispatchセッションでは承認が30分で失効

**制限事項:**
- まだ初期段階であり「常に完璧に動作するわけではない」
- 画面ベースの操作はAPI直接連携より低速
- 複雑なタスクではリトライが必要な場合がある
- 研究プレビュー中は機密データの取り扱いは避けることを推奨

（出典: [Put Claude to work on your computer | Claude](https://claude.com/blog/dispatch-and-computer-use), [CNBC](https://www.cnbc.com/2026/03/24/anthropic-claude-ai-agent-use-computer-finish-tasks.html), [MacRumors](https://www.macrumors.com/2026/03/24/claude-use-mac-remotely-iphone/)）

### 2. Dispatch（クロスデバイス タスク委任）— 3月24日発表

Computer Useと同時に発表された機能。**iPhoneやブラウザからClaudeにタスクを指示し、デスクトップ上で自動実行させる**ことが可能。

- 外出先からスマートフォンでタスクを送信→帰宅後にデスクトップで完了結果を確認
- Claude CoworkとClaude Code両方で利用可能
- コードやファイルはローカルに留まり、暗号化チャネルを通じてチャットメッセージのみが送受信される

**ユースケース例:**
- 朝のメール自動チェック
- 週次メトリクスの自動取得
- PR作成とテスト実行
- プロジェクト管理のリアルタイム更新

（出典: [Put Claude to work on your computer | Claude](https://claude.com/blog/dispatch-and-computer-use), [Engadget](https://www.engadget.com/ai/claude-code-and-cowork-can-now-use-your-computer-210000126.html)）

### 3. Auto Mode（自動承認モード）— 研究プレビュー

Claude Codeの最大の注目機能。従来はツール実行ごとにユーザーの承認が必要だったが、Auto Modeでは組み込みのセーフガードがアクションを事前レビューし、安全と判断されたものを自動実行する。Teamプランで利用可能で、管理者の承認が必要。Enterprise・APIユーザー向けのサポートも近日対応予定。（出典: [TechCrunch](https://techcrunch.com/2026/03/24/anthropic-hands-claude-code-more-control-but-keeps-it-on-a-leash/), [Help Net Security](https://www.helpnetsecurity.com/2026/03/25/anthropic-claude-code-auto-mode-feature/)）

### 4. Opus 4.6 出力トークン上限引き上げ（v2.1.77, 3月17日）

- デフォルト最大出力トークン: **64k**（従来より大幅増）
- 上限: **128k**（Opus 4.6, Sonnet 4.6共通）
- 長いコード生成や大規模リファクタリングで中断されにくくなった

### 5. PowerShell ツール（v2.1.84, 3月26日）

- Windows向けにPowerShellツールを**オプトインプレビュー**として追加
- WindowsネイティブのCLI操作がより自然にサポートされる

### 6. MCP Elicitation サポート（v2.1.76, 3月14日）

- MCPサーバーからの構造化入力を対話型ダイアログで収集可能に
- `Elicitation` / `ElicitationResult` フックも追加
- MCPツールがユーザーに追加情報を求めるワークフローが実現

### 7. `--bare` フラグ（v2.1.81, 3月20日）

- スクリプト用の `-p` 呼び出しで、フック・LSP・プラグイン同期をスキップする軽量モード
- CI/CDパイプラインやバッチ処理での利用に最適
- `--bare -p` は通常より**約14%高速**にAPI リクエストを送信

### 8. `--channels` パーミッションリレー（v2.1.80-81, 3月19-20日）

- 研究プレビューとして追加
- MCPサーバーがメッセージをプッシュ可能に
- スマートフォンからの承認転送にも対応

### 9. トランスクリプト検索（v2.1.83, 3月25日）

- トランスクリプトモード（`Ctrl+O`）内で `/` キーを押してセッション内検索が可能に
- 長いセッションでの過去のやりとり参照が格段に容易に

### 10. Hook/Agent系の大幅強化

| バージョン | 機能 |
|-----------|------|
| v2.1.76 | `PostCompact` フック追加 |
| v2.1.78 | `StopFailure` フック（APIエラー時）、エージェント frontmatter に `effort`/`maxTurns`/`disallowedTools` |
| v2.1.83 | `CwdChanged`/`FileChanged` フック、エージェントの `initialPrompt` frontmatter |
| v2.1.84 | `TaskCreated` フック、`WorktreeCreate` HTTP対応 |
| v2.1.85 | フックに条件付き `if` フィールド（パーミッションルール構文）、PreToolUseフックが `AskUserQuestion` を自動応答可能に |

### 11. セキュリティ・サンドボックス強化

- **セキュリティ修正**: サンドボックスが依存関係不足時に無警告で無効化されていた問題を修正（v2.1.78）
- `sandbox.failIfUnavailable`: サンドボックス利用不可時にエラー終了する設定追加（v2.1.83）
- `CLAUDE_CODE_SUBPROCESS_ENV_SCRUB=1`: サブプロセスから認証情報を除去（v2.1.83）
- `managed-settings.d/` ドロップインディレクトリでポリシーを分割管理可能に（v2.1.83）

### 12. パフォーマンス改善

- macOS起動時間: 約60ms高速化（並列キーチェーン読み込み）
- `--resume`: 45%高速化、ピークメモリ100-150MB削減
- 起動時メモリ: 約80MB削減（25万ファイル規模リポジトリ）、別途約18MB削減
- スクロール性能: WAM yoga-layoutをTypeScript実装に置換
- コンパクション中のUIスタッター削減
- `@`ファイル補完の応答性改善

### 13. その他の注目機能

| 機能 | バージョン | 説明 |
|------|-----------|------|
| `/effort` コマンド | v2.1.76 | 推論努力レベルをスラッシュコマンドで変更 |
| `-n` / `--name` フラグ | v2.1.76 | セッションに表示名を設定 |
| `--console` フラグ | v2.1.79 | Anthropic Console（API課金）認証 |
| `worktree.sparsePaths` | v2.1.76 | 大規模モノレポでのスパースチェックアウト対応 |
| `/copy N` | v2.1.77 | インデックス指定でのコピー |
| ステータスライン `rate_limits` | v2.1.80 | レート制限情報の表示 |
| Skills/Rules `paths:` YAML glob | v2.1.84 | スキル・ルールの適用パスをYAMLリストで指定 |
| アイドル復帰プロンプト | v2.1.84 | 75分以上非アクティブ時に `/clear` を提案 |
| トークン表示 "1.5m" 形式 | v2.1.84 | 100万以上のトークンカウント表示改善 |
| `/fork` → `/branch` リネーム | v2.1.77 | コマンド名変更（エイリアスは維持） |

### 14. VSCode拡張の改善

- レート制限警告バナー（使用率とリセット時間を表示）
- `/remote-control` 対応（ブラウザ/スマートフォンからの継続操作）
- セッションタブにAI生成タイトル
- スクリーンショット機能が全ビルドで動作（16倍高速化）
- プラン プレビュータブのタイトル改善

---

## リリース一覧

| バージョン | リリース日 | 主要な追加機能 |
|-----------|-----------|---------------|
| v2.1.85 | 3月26日 | MCP環境変数、フック条件分岐、RFC 9728 OAuth |
| v2.1.84 | 3月26日 | PowerShellツール、TaskCreatedフック、アイドル復帰プロンプト |
| v2.1.83 | 3月25日 | トランスクリプト検索、managed-settings.d/、リアクティブフック |
| v2.1.81 | 3月20日 | `--bare`フラグ、`--channels`パーミッションリレー |
| v2.1.80 | 3月19日 | レート制限ステータスライン、`effort` frontmatter、`--channels`プレビュー |
| v2.1.79 | 3月18日 | `--console`認証、起動メモリ削減 |
| v2.1.78 | 3月17日 | StopFailureフック、プラグインデータ永続化、サンドボックスセキュリティ修正 |
| v2.1.77 | 3月17日 | Opus 64k/128kトークン、`allowRead`サンドボックス設定 |
| v2.1.76 | 3月14日 | MCP Elicitation、`--name`フラグ、スパースチェックアウト、PostCompactフック |

---

## 情報源一覧

- [Changelog - Claude Code Docs](https://code.claude.com/docs/en/changelog)
- [Releases · anthropics/claude-code (GitHub)](https://github.com/anthropics/claude-code/releases)
- [Anthropic hands Claude Code more control, but keeps it on a leash | TechCrunch](https://techcrunch.com/2026/03/24/anthropic-hands-claude-code-more-control-but-keeps-it-on-a-leash/)
- [Anthropic trims action approval loop, lets Claude Code make the call - Help Net Security](https://www.helpnetsecurity.com/2026/03/25/anthropic-claude-code-auto-mode-feature/)
- [Claude Code by Anthropic - Release Notes - Releasebot](https://releasebot.io/updates/anthropic/claude-code)
- [Claude Code March 2026 Full Capability Interpretation - Apiyi.com](https://help.apiyi.com/en/claude-code-2026-new-features-loop-computer-use-remote-control-guide-en.html)
- [Put Claude to work on your computer | Claude Blog](https://claude.com/blog/dispatch-and-computer-use)
- [Anthropic says Claude can now use your computer | CNBC](https://www.cnbc.com/2026/03/24/anthropic-claude-ai-agent-use-computer-finish-tasks.html)
- [Claude's Claude AI Can Now Use Your Mac While You're Away | MacRumors](https://www.macrumors.com/2026/03/24/claude-use-mac-remotely-iphone/)
- [Computer use tool - Claude API Docs](https://platform.claude.com/docs/en/agents-and-tools/tool-use/computer-use-tool)
