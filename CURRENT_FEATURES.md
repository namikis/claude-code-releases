# Claude Code 現行機能一覧

**最終更新:** 2026-04-02（v2.1.90 + ソースコードリーク事件反映）

Claude Codeは、コードベースの読み取り・ファイル編集・コマンド実行・開発ツール統合を行うAIコーディングアシスタント。ターミナル、IDE、デスクトップアプリ、ブラウザで利用可能。

---

## 利用環境

| 環境 | 概要 |
|-----|------|
| **Terminal CLI** | ファイル編集、コマンド実行、プロジェクト管理をコマンドラインから直接操作 |
| **VS Code** | インライン差分表示、@メンション、プラン確認、会話履歴をエディタ内で |
| **JetBrains** | IntelliJ、PyCharm、WebStorm等のプラグイン。差分表示とコンテキスト共有 |
| **Desktop App** | スタンドアロンアプリ。差分の視覚的確認、複数セッション並行、スケジュール実行 |
| **Web** | ブラウザで利用（claude.ai/code）。ローカルセットアップ不要。長時間タスクの実行に最適 |
| **iOS App** | iPhoneからタスク送信・モニタリング |

---

## 主要機能

### コーディング支援
- **機能構築**: 自然言語で説明するとアプローチを計画→複数ファイル間でコード作成→動作検証
- **バグ修正**: エラーメッセージ貼り付けや症状説明→コードベース全体で問題トレース→根本原因特定→修正実装
- **テスト自動作成**: テストされていないコードのテスト作成、テスト実行、失敗の修正
- **リファクタリング**: リントエラー修正、マージコンフリクト解決、依存関係更新

### Git / GitHub / GitLab 連携
- 変更のステージング、コミットメッセージ作成、ブランチ作成、PR作成
- GitHub Actions / GitLab CI/CD でコードレビュー・Issueトリアージを自動化
- **GitHub Code Review**（研究プレビュー、Team/Enterprise）: 複数エージェントが並行でPRを精査。重大度ランク付きインラインコメント。大規模PR（1,000行以上）で84%に平均7.5件の指摘。平均レビュー時間約20分。トークン課金（$15-25/レビュー）

### Computer Use（デスクトップ操作）
- **リリース状態**: 研究プレビュー（Pro / Max、macOS限定）
- Claude Codeの組み込みツールでは対応できないタスクに対して、画面を直接操作（クリック、タイプ、スクロール）
- ツール優先順位: 専用コネクタ → Bash → Chrome拡張 → Computer Use（最も広範だが最も遅い）
- 初めてアプリにアクセスする際はユーザーに許可を求める。プロンプトインジェクション検出あり

### Dispatch（クロスデバイス タスク委任）
- **リリース状態**: 研究プレビュー（Pro / Max）
- iPhoneやブラウザからタスクを送信→デスクトップで自動実行→結果を確認
- コード・ファイルはローカルに留まり、暗号化チャネルでチャットのみ送受信
- v2.1.87でメッセージが配信されない問題を修正

### Auto Mode（自動承認モード）
- **リリース状態**: 研究プレビュー（Team、管理者承認要）
- セーフガードがアクションを事前レビューし、安全と判断されたものを自動実行
- Sonnet 4.6 または Opus 4.6 が必要
- 拒否されたコマンドが通知表示され、`/permissions` → Recentタブで`r`キーによりリトライ可能（v2.1.89）
- 「pushしないで」等の明示的ユーザー境界を尊重（v2.1.90で修正）

### Remote Control
- ローカルセッションをスマートフォンや別デバイスのブラウザから継続操作
- `/remote-control` または `--rc` フラグで有効化

### Voice Mode（音声入力）
- `/voice` で音声ディクテーションを切り替え
- Push-to-talk方式（スペースバー長押し）
- 20言語対応

---

## 拡張機能

### MCP（Model Context Protocol）連携
- AIツール統合のオープンソース標準。数百の外部ツール・データソースに接続可能
- **接続例**: GitHub、Slack、Jira、Sentry、Notion、Asana、PostgreSQL、Google Drive、Figma等
- HTTP / SSE / stdio の3種類のトランスポートをサポート
- OAuth 2.0認証対応（RFC 9728 Protected Resource Metadata ディスカバリー準拠）
- `claude mcp add` でサーバー追加、`/mcp` で管理
- チャネル機能: MCPサーバーがセッションにメッセージをプッシュ可能（Telegram、Discord、webhook対応）

### Skills（スキル）
- `SKILL.md` ファイルに指示を記述してClaude Codeの機能を拡張
- `/skill-name` で直接呼び出し、またはClaude Codeが関連タスクで自動使用
- バンドルスキル: `/batch`（大規模並列変更）、`/claude-api`（APIリファレンス）、`/debug`、`/loop`（定期実行）、`/simplify`（コード品質改善）
- フロントマターで `context: fork`（サブエージェント実行）、`allowed-tools`（ツール制限）等を設定可能
- `` !`command` `` 構文で動的コンテキスト注入

### Sub-agents（サブエージェント）
- 独立したコンテキストウィンドウで動作する専門AIアシスタント
- 組み込み: **Explore**（読み取り専用、Haiku）、**Plan**（計画モード）、**General-purpose**（汎用）
- カスタムサブエージェントを `.claude/agents/*.md` に定義可能
- フロントマター: `tools`, `model`, `permissionMode`, `maxTurns`, `skills`, `mcpServers`, `hooks`, `memory`, `isolation`（worktree分離）
- `@agent-name` でメンション指定、`--agent` でセッション全体をエージェントとして実行
- フォアグラウンド/バックグラウンド実行対応

### Hooks（フック）
- Claude Codeのライフサイクル内でシェルコマンド、HTTPエンドポイント、LLMプロンプトを自動実行
- **イベント一覧**:

| イベント | 発火タイミング |
|---------|-------------|
| `SessionStart` | セッション開始時 |
| `SessionEnd` | セッション終了時 |
| `PreToolUse` | ツール使用前 |
| `PostToolUse` | ツール使用後 |
| `Stop` | エージェント停止時 |
| `SubagentStart` / `SubagentStop` | サブエージェントの開始/終了 |
| `Elicitation` / `ElicitationResult` | MCP Elicitation発生時 |
| `CwdChanged` | カレントディレクトリ変更時 |
| `FileChanged` | ファイル変更検出時 |
| `TaskCreated` | タスク作成時 |
| `PostCompact` | コンパクション完了後 |
| `StopFailure` | APIエラーによるターン終了時 |
| `WorktreeCreate` / `WorktreeRemove` | Worktree作成/削除時 |
| `ConfigChange` | 設定変更時 |
| `InstructionsLoaded` | 指示読み込み時 |
| `PermissionDenied` | Auto Mode分類器の拒否後に発火。`{retry: true}`でリトライ指示可能 |

- `settings.json` またはサブエージェント/スキルのフロントマターで定義
- `if` フィールドで条件付き実行が可能（パーミッションルール構文、例: `Bash(git *)`）
- PreToolUse フックが `AskUserQuestion` に対して `updatedInput` で自動応答可能（ヘッドレス統合向け）
- PreToolUse フックが `"defer"` 決定を返すと、ヘッドレスセッションがツール呼び出し時に一時停止し、`-p --resume`で再評価可能（v2.1.89）
- フック出力が50K文字を超える場合、ディスクに保存しファイルパス+プレビューをコンテキストに注入（v2.1.89）
- `CLAUDE_CODE_MCP_SERVER_NAME` / `CLAUDE_CODE_MCP_SERVER_URL` 環境変数でヘッダーヘルパーにサーバー情報を提供

### Plugins（プラグイン）
- スキル、エージェント、MCPサーバーをパッケージ化して配布
- `claude plugin install` でマーケットプレイスからインストール
- プラグイン提供のMCPサーバー・エージェント・スキルが自動的に利用可能に

### Chrome拡張（ベータ）
- `--chrome` フラグでブラウザ自動化・Webテスト・ライブデバッグが可能

---

## メモリ・設定

### CLAUDE.md（プロジェクト指示）
- プロジェクトルートに配置するMarkdownファイル。セッション開始時に自動読み込み
- コーディング標準、アーキテクチャ決定、ライブラリ設定、チェックリスト等を記述
- `/init` でインタラクティブにセットアップ

### Auto Memory（自動メモリ）
- ビルドコマンド、デバッグの洞察等をセッション間で自動保存・共有
- `~/.claude/projects/` 配下にメモリファイルとして永続化

### Settings
- `settings.json`（プロジェクト/ユーザー/ローカル）で設定管理
- 権限（`permissions.allow` / `permissions.deny`）、環境変数、フック等を定義
- `managed-settings.d/` でポリシーフラグメントのドロップイン管理

---

## スケジュール・自動化

| 方法 | 説明 |
|------|------|
| **クラウドスケジュール** | Anthropic管理インフラで実行。PCオフでも動作。`/schedule` で作成 |
| **デスクトップスケジュール** | ローカルマシンで実行。ローカルファイル・ツールに直接アクセス |
| **`/loop`** | CLIセッション内でプロンプトを定期実行。デプロイ監視やPRポーリングに |
| **GitHub Actions** | PRレビュー・Issueトリアージを自動化 |
| **GitLab CI/CD** | GitLabパイプラインでの自動化 |

---

## CLI パイプ・スクリプト

```bash
# ログ分析
tail -200 app.log | claude -p "Slack me if you see any anomalies"

# CI で翻訳自動化
claude -p "translate new strings into French and raise a PR for review"

# セキュリティレビュー
git diff main --name-only | claude -p "review these changed files for security issues"

# 構造化出力（JSON Schema）
claude -p --json-schema '{"type":"object",...}' "query"
```

- `--bare` フラグ: フック/LSP/プラグインをスキップする軽量モード（約14%高速）
- `--output-format`: `text` / `json` / `stream-json`
- `--max-turns`, `--max-budget-usd`: 制限付き実行
- `CLAUDE_CODE_NO_FLICKER=1`: alt-screenレンダリング+仮想化スクロールバックでフリッカーフリー表示（v2.1.89）
- `MCP_CONNECTION_NONBLOCKING=true`: `-p`モードでMCP接続待ちをスキップ（v2.1.89）
- `CLAUDE_CODE_PLUGIN_KEEP_MARKETPLACE_ON_FAILURE`: `git pull`失敗時にマーケットプレイスキャッシュを保持（v2.1.90）

---

## 主要なCLIフラグ

| フラグ | 説明 |
|-------|------|
| `-p` / `--print` | 非インタラクティブモード（スクリプト向け） |
| `-c` / `--continue` | 最新の会話を続行 |
| `-r` / `--resume` | セッションID/名前で再開 |
| `-n` / `--name` | セッション表示名を設定 |
| `-w` / `--worktree` | 分離されたgit worktreeで実行 |
| `--model` | モデル指定（`sonnet`, `opus`, 完全なモデルID） |
| `--effort` | 努力レベル（`low` / `medium` / `high` / `max`） |
| `--agent` | 指定エージェントとしてセッション実行 |
| `--bare` | 最小限モード（高速起動） |
| `--channels` | MCPチャネル有効化（研究プレビュー） |
| `--chrome` | Chrome統合を有効化 |
| `--remote` | Webセッション作成 |
| `--rc` / `--remote-control` | Remote Control有効化 |
| `--teleport` | Webセッションをローカルに転送 |
| `--mcp-config` | MCP設定ファイル指定 |
| `--json-schema` | 構造化JSON出力 |
| `--enable-auto-mode` | Auto Mode を有効化（Shift+Tab でサイクル切替） |

---

## 主要なスラッシュコマンド

| コマンド | 説明 |
|---------|------|
| `/clear` | 会話履歴クリア |
| `/compact` | 会話コンパクト化 |
| `/config` | 設定画面 |
| `/context` | コンテキスト使用状況の可視化 |
| `/diff` | インタラクティブdiffビューア |
| `/effort` | 努力レベル変更 |
| `/model` | モデル変更 |
| `/plan` | Plan Mode |
| `/voice` | 音声入力トグル |
| `/mcp` | MCP管理 |
| `/agents` | エージェント管理 |
| `/skills` | スキル一覧 |
| `/plugin` | プラグイン管理 |
| `/branch` | 会話ブランチ（旧`/fork`） |
| `/copy N` | N番目の応答をコピー |
| `/remote-control` | Remote Control有効化 |
| `/schedule` | スケジュールタスク管理 |
| `/batch` | 大規模並列変更 |
| `/loop` | 定期実行 |
| `/simplify` | コード品質レビュー・修正 |
| `/rewind` | チェックポイントへ巻き戻し |
| `/stats` | 使用統計の可視化 |
| `/fast` | Fast Mode切替 |
| `/color` | プロンプトバーの色変更 |
| `/rename` | セッション名変更 |
| `/desktop` | Desktop Appで続行 |
| `/export` | 会話エクスポート |
| `/powerup` | アニメーションデモ付きインタラクティブレッスン（v2.1.90） |
| `/buddy` | ターミナルペット。18種族のクリーチャーを孵化（April Fools 2026、v2.1.89） |

---

## セキュリティ・権限

### Permission Modes
| モード | 説明 |
|-------|------|
| `default` | プロンプト付き標準権限チェック |
| `plan` | 読み取り専用探索モード |
| `acceptEdits` | ファイル編集を自動承認 |
| `dontAsk` | 権限プロンプトを自動拒否 |
| `bypassPermissions` | 全権限チェックスキップ（注意） |
| `auto` | セーフガード付き自動承認（研究プレビュー） |

### Sandboxing
- macOS: Apple Seatbelt。Linux: Docker/bubblewrap
- `sandbox.failIfUnavailable`: サンドボックス利用不可時にエラー終了
- `CLAUDE_CODE_SUBPROCESS_ENV_SCRUB=1`: サブプロセスから認証情報を除去

### Zero Data Retention
- ZDR対応。データは API レスポンス返却後に保持されない

---

## モデル設定

| 項目 | 詳細 |
|------|------|
| **デフォルトモデル** | Claude Opus 4.6 |
| **出力トークン上限** | デフォルト64k、上限128k（Opus/Sonnet 4.6）。Message Batches APIでは300k（`output-300k-2026-03-24`ベータヘッダー要） |
| **コンテキスト** | 1Mトークン（Opus 4.6/Sonnet 4.6はGA、ベータヘッダー不要。メディア上限600画像/PDFページ）。Sonnet 4.5/4の1Mベータは2026年4月30日で終了予定 |
| **Fast Mode** | 同じOpus 4.6モデルで高速出力。`/fast` でトグル |
| **努力レベル** | `low` / `medium` / `high` / `max`（Opus 4.6のみ） |
| **サードパーティ** | Amazon Bedrock、Google Vertex AI、Microsoft Foundry対応 |
| **Extended Thinking 表示制御** | `thinking.display: "omitted"` でthinkingコンテンツをストリーミングから省略可能（signature保持）。インタラクティブセッションではthinking summaryがデフォルト無効化（`showThinkingSummaries: true`で復元、v2.1.89） |
| **Models API 機能照会** | `GET /v1/models` が `max_input_tokens`、`max_tokens`、`capabilities` を返すように（3月18日〜） |
| **modelOverrides** | モデルピッカーのエントリをカスタムプロバイダーモデルID（Bedrock ARN等）にマッピング |

---

## Slack連携
- `@Claude` メンションでバグレポート→PR作成のルーティング

## Agent Teams
- 複数の独立セッションが並行動作・相互通信
- リードエージェントがタスク調整、サブタスク割当、結果マージ
- tmux / in-process モード

## Agent SDK
- Claude Codeのツール・機能を活用したカスタムエージェントを構築
- オーケストレーション・ツールアクセス・権限を完全制御

---

## セキュリティインシデント

### v2.1.88 ソースコードリーク（2026年3月31日）
- v2.1.88のnpmパッケージに59.8MBのソースマップファイルが誤って含まれ、512,000行以上のTypeScriptコードが流出
- セキュリティ研究者が発見・公表し、Anthropicが同日中にnpmから削除
- 顧客データや認証情報の漏洩はなし。「ヒューマンエラーによるリリースパッケージングの問題」と声明
- 44個のフィーチャーフラグ、3層メモリアーキテクチャ、未発表モデル"Capybara"への参照が含まれていた

---

## 次世代モデル情報

### Claude Mythos（コードネーム "Capybara"）
- **リリース状態**: 発表のみ（トレーニング完了、限定パイロット中）
- Opusを超える新しい最上位モデルティア
- コーディング、学術的推論、サイバーセキュリティでOpus 4.6を「大幅に」上回るスコア
- サイバー防御組織への限定早期アクセスを先行計画。正式リリース日は未発表
- Opusより高価な新プレミアムティアになる見込み
- **発覚**: 2026年3月26日、CMS設定ミスによるデータリークで存在が判明。Anthropicが確認

---

## 廃止予定

| モデル/機能 | 廃止日 | 移行先 |
|------------|--------|--------|
| Claude Haiku 3 (`claude-3-haiku-20240307`) | 2026-04-19 | Claude Haiku 4.5 |
| Sonnet 4.5/4 の1Mコンテキストベータ (`context-1m-2025-08-07`) | 2026-04-30 | Sonnet 4.6 / Opus 4.6（1M GA） |

---

## 更新履歴

- 2026-04-02: v2.1.88〜v2.1.90反映。ソースコードリーク事件、PreToolUse defer、PermissionDeniedフック、/powerup、/buddy、Auto Mode改善、パフォーマンス改善、Message Batches API 300k、Sonnet 4.5/4 1Mベータ終了予告（[調査レポート](reports/2026-04-02_v2.1.88-90-and-source-leak.md)）
- 2026-03-30: v2.1.87反映。Dispatch修正、Claude Mythosリーク情報追加（[調査レポート](reports/2026-03-30_v2.1.87-and-mythos-leak.md)）
- 2026-03-28: v2.1.86反映。1Mコンテキスト GA、Extended Thinking表示制御、Models API機能フィールド、MCP OAuth RFC 9728、Code Review詳細追記、modelOverrides追加（[調査レポート](reports/2026-03-28_v2.1.86-and-platform-updates.md)）
- 2026-03-28: 公式ドキュメント（code.claude.com/docs/ja）に基づき全面改訂。機能カテゴリを再構成し網羅的に記載（[調査レポート](reports/2026-03-28_claude-code-new-features-march-2026.md)）
