# Claude Code 現行機能一覧

**最終更新:** 2026-04-15（v2.1.107-108反映・Routines研究プレビュー・デスクトップ再設計・Sonnet 4/Opus 4廃止予告）

Claude Codeは、コードベースの読み取り・ファイル編集・コマンド実行・開発ツール統合を行うAIコーディングアシスタント。ターミナル、IDE、デスクトップアプリ、ブラウザで利用可能。

**確度バッジ:** ✅ GA（一般提供） | 🔬 研究プレビュー | 🧪 ベータ | 📢 発表のみ | ❓ 噂・未確認

---

## 利用環境

| 環境 | 概要 |
|-----|------|
| **Terminal CLI** | ファイル編集、コマンド実行、プロジェクト管理をコマンドラインから直接操作 |
| **VS Code** | インライン差分表示、@メンション、プラン確認、会話履歴をエディタ内で |
| **JetBrains** | IntelliJ、PyCharm、WebStorm等のプラグイン。差分表示とコンテキスト共有 |
| **Desktop App (Cowork)** | スタンドアロンアプリ。✅ GA（全有料プラン）。2026年4月14日に全面再設計：統合ターミナル、サイドチャット（`⌘+;`/`Ctrl+;`）、改善Diffビューア、ファイルエディタ、HTML/PDFプレビュー、再配置可能ペイン（Preview/Plan/Diff/Tasks/Terminal/Chat）、複数セッション並行。エンタープライズ: RBAC、グループ支出制限、利用分析、OpenTelemetry拡張、Zoom MCPコネクタ、ツール単位コネクタ制御 |
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

### Computer Use（デスクトップ操作） 🔬
- **リリース状態**: 🔬 研究プレビュー（Pro / Max、macOS限定）
- Claude Codeの組み込みツールでは対応できないタスクに対して、画面を直接操作（クリック、タイプ、スクロール）
- ツール優先順位: 専用コネクタ → Bash → Chrome拡張 → Computer Use（最も広範だが最も遅い）
- 初めてアプリにアクセスする際はユーザーに許可を求める。プロンプトインジェクション検出あり

### Dispatch（クロスデバイス タスク委任） 🔬
- **リリース状態**: 🔬 研究プレビュー（Pro / Max）
- iPhoneやブラウザからタスクを送信→デスクトップで自動実行→結果を確認
- コード・ファイルはローカルに留まり、暗号化チャネルでチャットのみ送受信
- v2.1.87でメッセージが配信されない問題を修正

### Auto Mode（自動承認モード） 🔬
- **リリース状態**: 🔬 研究プレビュー（Team、管理者承認要）
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
| `PreCompact` | コンパクション開始前。exit code 2または`{"decision":"block"}`でブロック可能（v2.1.105） |
| `PostCompact` | コンパクション完了後 |
| `StopFailure` | APIエラーによるターン終了時 |
| `WorktreeCreate` / `WorktreeRemove` | Worktree作成/削除時 |
| `ConfigChange` | 設定変更時 |
| `InstructionsLoaded` | 指示読み込み時 |
| `PermissionDenied` | Auto Mode分類器の拒否後に発火。`{retry: true}`でリトライ指示可能 |
| `UserPromptSubmit` | ユーザープロンプト送信時。`hookSpecificOutput.sessionTitle` でセッションタイトル設定可能（v2.1.94） |

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
- バックグラウンドモニター: manifest の `monitors` キーでセッション開始時またはスキル呼び出し時に自動起動するモニターを定義可能（v2.1.105）

### Chrome拡張 🧪
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
- `disableSkillShellExecution`: スキル・カスタムスラッシュコマンド・プラグインコマンド内のインラインシェル実行を無効化（v2.1.91）
- `forceRemoteSettingsRefresh`: 起動時にリモートmanaged settingsの最新取得を強制。失敗時はエラー終了（v2.1.92）

---

## スケジュール・自動化

| 方法 | 説明 |
|------|------|
| **Routines（ルーティン）** 🔬 | クラウド実行の自動化。スケジュール/API/GitHubイベントトリガー。PCオフでも動作。Pro 5回/日、Max 15回/日、Team/Enterprise 25回/日。claude.ai/code/routines または `/schedule` で管理（v2.1.108〜、2026年4月14日研究プレビュー） |
| **クラウドスケジュール** | Routinesのスケジュールトリガー。hourly/daily/weekdays/weeklyプリセット + カスタムcron式（最小1時間） |
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
- MCP ツール結果永続化オーバーライド: `_meta["anthropic/maxResultSizeChars"]` で最大500Kまでの大きな結果を截断せず保持（v2.1.91）
- プラグインが `bin/` 配下に実行ファイルを同梱し、Bashツールからベアコマンドとして呼び出し可能（v2.1.91）
- `forceRemoteSettingsRefresh` ポリシー設定: 起動時にリモートmanaged settingsを必ず最新取得、失敗時はエラー終了（fail-closed）（v2.1.92）
- Bedrock インタラクティブセットアップウィザード: ログイン画面からAWS認証・リージョン設定・モデルピンニングを対話的に設定（v2.1.92）
- Proユーザーにプロンプトキャッシュ期限切れヒントをフッター表示（v2.1.92）
- Amazon Bedrock powered by Mantle対応: `CLAUDE_CODE_USE_MANTLE=1` で有効化（v2.1.94）
- デフォルト努力レベルがmedium→highに変更（API-key、Bedrock/Vertex/Foundry、Team、Enterpriseユーザー）。`/effort` で制御可能（v2.1.94）
- Slack MCP send-messageでコンパクトな `Slacked #channel` ヘッダーとクリック可能チャネルリンクを表示（v2.1.94）
- `keep-coding-instructions` フロントマターフィールドをプラグイン出力スタイルでサポート（v2.1.94）
- `UserPromptSubmit` フックで `hookSpecificOutput.sessionTitle` によるセッションタイトル設定が可能に（v2.1.94）
- プラグインスキル（`"skills": ["./"]`）がディレクトリ名ではなくフロントマター `name` を呼び出し名に使用（v2.1.94）
- `--resume` がリポジトリのworktree間で直接動作するように改善（v2.1.94）
- CJK/マルチバイトテキストがstream-jsonでUTF-8分割時にU+FFFDに破損する問題を修正（v2.1.94）
- Bedrock 403認証リグレッション修正: `AWS_BEARER_TOKEN_BEDROCK`/`CLAUDE_CODE_SKIP_BEDROCK_AUTH` 使用時の認証失敗を修正（v2.1.96）
- Google Vertex AIインタラクティブセットアップウィザード: ログイン画面からGCP認証・リージョン設定・モデルピンニングを対話的に設定（v2.1.98）
- `CLAUDE_CODE_PERFORCE_MODE`: 読み取り専用ファイルへのEdit/Write/NotebookEditを失敗させ`p4 edit`ヒントを表示（v2.1.98）
- Monitorツール: バックグラウンドスクリプトからのイベントストリーミング対応（v2.1.98）
- サブプロセスPID名前空間サンドボックス: Linux環境で`CLAUDE_CODE_SUBPROCESS_ENV_SCRUB`設定時に適用（v2.1.98）
- `CLAUDE_CODE_SCRIPT_CAPS`: セッション単位のスクリプト呼び出し回数制限（v2.1.98）
- EnterWorktreeツールに`path`パラメータ追加: 既存worktreeへの切り替えが可能に（v2.1.105）
- `/proactive`が`/loop`のエイリアスに（v2.1.105）
- APIストリーム5分タイムアウト: データなし5分でストリーム中断→非ストリーミングリトライ（v2.1.105）
- ネットワークエラー即時リトライメッセージ: サイレントスピナーではなく即座に表示（v2.1.105）
- ファイル書き込み表示切り詰め: minified JSON等の長い単一行をUI上で切り詰め（v2.1.105）
- `/doctor`自動修正: ステータスアイコン表示、`f`キーでClaude自動修正（v2.1.105）
- スキル説明文キャップ250→1,536文字に拡大（v2.1.105）
- WebFetch `<style>`/`<script>`除去: CSSヘビーページのコンテンツバジェット消費問題を解消（v2.1.105）
- squash-mergeされたPRのworktreeも自動クリーンアップ（v2.1.105）
- MCP大出力切り詰めプロンプト改善: フォーマット固有レシピ（`jq`等）を提示（v2.1.105）
- `ENABLE_PROMPT_CACHING_1H`: 全プラットフォーム（API key / Bedrock / Vertex / Foundry）で1時間プロンプトキャッシュTTLを有効化。`FORCE_PROMPT_CACHING_5M` で5分TTL強制（v2.1.108）
- Recap機能: セッション復帰時に文脈サマリーを自動提供。`/config` で設定、`/recap` で手動呼び出し。`CLAUDE_CODE_ENABLE_AWAY_SUMMARY` でテレメトリ無効時にも強制有効化（v2.1.108）
- 組み込みスラッシュコマンド（`/init`、`/review`、`/security-review`）をSkillツール経由でモデルが発見・呼び出し可能に（v2.1.108）
- `/undo` が `/rewind` のエイリアスに（v2.1.108）
- `/model` が会話中のモデル切替時に未キャッシュ再読み込みの警告を表示（v2.1.108）
- `/resume` ピッカーがカレントディレクトリのセッションをデフォルト表示、`Ctrl+A` で全プロジェクト（v2.1.108）
- エラーメッセージ改善: サーバーレート制限 vs プラン使用制限の区別、5xx/529に status.claude.com リンク、未知コマンドに候補提案（v2.1.108）
- 言語グラマーをオンデマンドロードしメモリフットプリント削減（v2.1.108）
- プロンプトキャッシュ無効時の起動警告（v2.1.108）
- thinking hints を長時間操作中により早く表示（v2.1.107）
- `CLAUDE_CODE_CERT_STORE=bundled`: デフォルトでOSの認証局証明書ストアを信頼するようになったため、バンドルCA限定に戻すオプション（v2.1.101）
- `/team-onboarding`: ローカルのClaude Code使用履歴からチームメイト向けオンボーディングガイドを自動生成（v2.1.101）
- `/ultraplan`等のリモートセッション機能がデフォルトクラウド環境を自動作成（Web事前セットアップ不要）（v2.1.101）
- `--exclude-dynamic-system-prompt-sections`: printモードでクロスユーザープロンプトキャッシュ改善（v2.1.98）
- LSP `clientInfo`: language serverへの自己識別情報送信（v2.1.98）
- `/agents` タブレイアウト: Running/Libraryの2タブ構成に改善（v2.1.98）
- `/reload-plugins` がプラグイン提供スキルを再起動なしで取得可能に（v2.1.98）
- Vim mode: `j`/`k`がNORMALモードで履歴ナビゲーション対応（v2.1.98）
- フックエラー表示にstderrの最初の行を含め自己診断可能に（v2.1.98）
- Focus View トグル（`Ctrl+O`）: `NO_FLICKER`モードでプロンプト・1行ツールサマリー・最終レスポンスのみ表示（v2.1.97）
- `refreshInterval` ステータスライン設定: N秒ごとにステータスラインコマンドを再実行（v2.1.97）
- `workspace.git_worktree`: ステータスラインJSON入力にworktree情報を追加（v2.1.97）
- `/agents` に `● N running` インジケータ: ライブサブエージェントインスタンス数をタイプ横に表示（v2.1.97）
- Cedar ポリシーファイル（`.cedar`、`.cedarpolicy`）のシンタックスハイライト（v2.1.97）
- Accept Edits 安全コマンド自動承認: 環境変数/プロセスラッパー付きコマンドを自動承認（v2.1.97）
- Auto Mode / bypass-permissions でサンドボックスネットワークアクセスプロンプトを自動承認（v2.1.97）
- ペースト/添付画像をReadツールと同じトークンバジェットに圧縮（v2.1.97）
- CJK句読点後のスラッシュコマンド・`@`メンション補完トリガー（v2.1.97）
- Bridgeセッションカードにローカルgitリポジトリ・ブランチ・作業ディレクトリを表示（v2.1.97）
- `sandbox.network.allowMachLookup` がmacOSで有効化（v2.1.97）
- `/claude-api` スキルがManaged Agentsカバレッジを追加（v2.1.97）
- MCP HTTP/SSE 再接続時の~50 MB/時メモリリーク修正（v2.1.97）
- MCP OAuth `oauth.authServerMetadataUrl` 再起動後のトークンリフレッシュ修正（v2.1.97）
- 429リトライに指数バックオフ最小値適用（~13秒枯渇問題の修正）（v2.1.97）
- NO_FLICKERモード: 8件超のレンダリング・互換性修正（zellij、Warp、Windows Terminal、CJK、メモリリーク等）（v2.1.97）

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
| `--remote-control-session-name-prefix` | Remote Controlセッション名プレフィックス（デフォルト: ホスト名） |
| `--channels` | MCPチャネル有効化（研究プレビュー） |
| `--chrome` | Chrome統合を有効化 |
| `--remote` | Webセッション作成 |
| `--rc` / `--remote-control` | Remote Control有効化 |
| `--teleport` | Webセッションをローカルに転送 |
| `--mcp-config` | MCP設定ファイル指定 |
| `--json-schema` | 構造化JSON出力 |
| `--enable-auto-mode` | Auto Mode を有効化（Shift+Tab でサイクル切替） |
| `--exclude-dynamic-system-prompt-sections` | printモードでクロスユーザープロンプトキャッシュ改善（v2.1.98） |

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
| `/loop` | 定期実行（`/proactive`はエイリアス、v2.1.105） |
| `/simplify` | コード品質レビュー・修正 |
| `/recap` | セッション復帰時の文脈サマリー表示。`/config` で自動有効化設定可能（v2.1.108） |
| `/rewind` | チェックポイントへ巻き戻し（`/undo` はエイリアス、v2.1.108） |
| `/stats` | 使用統計の可視化 |
| `/cost` | モデル別・キャッシュヒット別コスト内訳表示（サブスクリプションユーザー向け、v2.1.92） |
| `/fast` | Fast Mode切替 |
| `/color` | プロンプトバーの色変更 |
| `/rename` | セッション名変更 |
| `/desktop` | Desktop Appで続行 |
| `/export` | 会話エクスポート |
| `/release-notes` | インタラクティブバージョンピッカーでリリースノート閲覧（v2.1.92） |
| `/team-onboarding` | チームメイト向けオンボーディングガイド自動生成（v2.1.101） |
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
| **サードパーティ** | Amazon Bedrock、Google Vertex AI、Microsoft Foundry対応。Bedrock上でAnthropic Messages API（`/anthropic/v1/messages`）が研究プレビュー（us-east-1、招待制、4月7日〜） |
| **Extended Thinking 表示制御** | `thinking.display: "omitted"` でthinkingコンテンツをストリーミングから省略可能（signature保持）。インタラクティブセッションではthinking summaryがデフォルト無効化（`showThinkingSummaries: true`で復元、v2.1.89） |
| **Models API 機能照会** | `GET /v1/models` が `max_input_tokens`、`max_tokens`、`capabilities` を返すように（3月18日〜） |
| **modelOverrides** | モデルピッカーのエントリをカスタムプロバイダーモデルID（Bedrock ARN等）にマッピング |

---

## Microsoft 365 連携 ✅
- **リリース状態**: ✅ GA（全プラン — Free / Pro / Max / Team / Enterprise）
- **対象プラットフォーム**: Claude.ai（Web / Desktop / Mobile）
- **概要**: Microsoft 365のビジネスデータ（Outlook、Teams、SharePoint、OneDrive）をClaude会話内で検索・分析。読み取り専用（送信・編集・投稿は不可）
- **初出**: 2025年10月（Team/Enterprise限定）→ 2026年4月6日に全プラン展開
- **制限**: M365ビジネスアカウントのみ。組織管理者がMicrosoft Entra経由で事前有効化必要
- **情報源**: [Claude Help Center](https://support.claude.com/en/articles/12542951-enable-and-use-the-microsoft-365-connector) / [UC Today](https://www.uctoday.com/productivity-automation/anthropic-expands-claude-microsoft-365-integration-for-all-user-plans/)

## Microsoft Office Add-ins ✅
- **リリース状態**: ✅ GA（Excel・Word）/ 🧪 ベータ（PowerPoint）
- **対象プラン**: Pro（Excelのみ）/ Max（Excel・PowerPoint）/ Team・Enterprise（全アプリ）
- **対象プラットフォーム**: Windows / Mac / Web版Office / iPad（Excelのみ）。Android非対応
- **概要**: Word・Excel・PowerPointのネイティブAdd-inとしてClaude統合。Microsoft AppSourceマーケットプレイスから入手可能。Insert > Get Add-ins で「Claude by Anthropic」を検索してインストール
- **Word Add-in**（2026年4月13日GA）: 長文レビュー、コメントスレッド処理、Track Changes統合（AIの編集が変更追跡として表示）、セマンティック検索、テンプレート入力。書式・スタイル・番号付け保持。法務向けに契約条件要約・乖離条項特定・修正案分析機能
- **Excel Add-in**（2026年1月24日〜）: データ分析（セルレベル引用付き）、数式デバッグ（#REF!等）、ピボットテーブル作成・編集、チャート生成、条件付き書式、モデル選択（Sonnet 4.6 / Opus 4.6）。MCPコネクタでS&P Global・LSEG・Daloopa・Pitchbook・Moody's・FactSet連携。マクロ・VBA非対応
- **PowerPoint Add-in**（2026年2月〜）: テンプレート認識（レイアウト・フォント・色・マスター自動読み取り）、自然言語からデッキ構造生成、箇条書き→チャート変換、コネクタ機能
- **クロスアプリ共有コンテキスト**（2026年3月〜）: Word・Excel・PowerPoint間で会話とデータの文脈を維持。設定で「Let Claude work across files」をオン。操作対象は現在開いているファイルのみ
- **Skills**: チーム内で再利用可能なワークフロー。LBOモデリング・DCF分析・コンパラブル分析等のプリロード済みスキルあり。`/`コマンドで呼び出し
- **インフラ接続**: Amazon Bedrock、Google Vertex AI、Microsoft Foundry経由も可能
- **制限事項**: チャット履歴はセッション間で非保存。データは30日以内に自動削除。外部信頼できないファイルはプロンプトインジェクションリスクあり
- **情報源**: [Claude Help Center](https://support.claude.com/en/articles/14465370-use-claude-for-word) / [Claude Blog](https://claude.com/blog/claude-excel-powerpoint-updates) / [OpenPR](https://www.openpr.com/news/4468672/anthropic-rolls-out-claude-for-word-add-in-now-full-microsoft)（[深掘り調査](investigations/2026-04-14_claude-for-office.md)）

## Slack連携
- `@Claude` メンションでバグレポート→PR作成のルーティング

## Agent Teams
- 複数の独立セッションが並行動作・相互通信
- リードエージェントがタスク調整、サブタスク割当、結果マージ
- tmux / in-process モード

## Agent SDK
- Claude Codeのツール・機能を活用したカスタムエージェントを構築
- オーケストレーション・ツールアクセス・権限を完全制御

## Claude Managed Agents 🧪
- **リリース状態**: 🧪 パブリックベータ（全APIアカウントにデフォルト有効）
- **発表日**: 2026年4月8日
- **ベータヘッダー**: `managed-agents-2026-04-01`（SDKは自動設定）
- **概要**: クラウドホスト型AIエージェント基盤。エージェントループ・ツール実行・ランタイムをAnthropicインフラで完全管理。ファイル操作、コマンド実行、Web検索、MCP接続をセキュアなコンテナで実行
- **コアコンセプト**: Agent（モデル・ツール定義）→ Environment（コンテナテンプレート）→ Session（実行インスタンス）→ Events（SSEストリーミング）
- **組み込みツール**: Bash、File operations（Read/Write/Edit/Glob/Grep）、Web search/fetch、MCP servers
- **カスタムツール**: `type: "custom"`で独自ツール定義可能。エージェントが`agent.custom_tool_use`イベント発行→アプリ側実行→`user.custom_tool_result`で返却
- **Skills**: Anthropic組み込み（xlsx/pptx等）＋カスタムスキル対応。セッションあたり最大20スキル。オンデマンド読み込み
- **MCPコネクタ**: リモートMCPサーバー（HTTP Streamable Transport）接続。Agent定義でURL宣言→Session作成時にVaultで認証
- **研究プレビュー機能**: Outcomes（自己評価・成功率最大10pt向上）、Multi-agent（並列ワーク）、Memory（セッション間記憶）。要[アクセス申請](https://claude.com/form/claude-managed-agents)
- **アーキテクチャ**: Brain/Hands/Session分離設計。p50 TTFT約60%削減、p95で90%超改善。各コンポーネント独立障害・交換可能
- **価格（ベータ）**: 入力 $3-5/Mトークン、出力 $15-25/Mトークン（Sonnet/Opus）、アクティブランタイム $0.08/時間
- **Credential Vault**: OAuth（自動トークンリフレッシュ対応）＋静的ベアラートークン。対応: Slack、GitHub、Linear、ClickUp、Notion。Vaultあたり最大20認証情報
- **Environment**: パッケージ（pip/npm/apt/cargo/gem/go）プリインストール、ネットワーク制御（unrestricted/limited）、セッション毎に独立コンテナ
- **Session状態**: idle→running→rescheduling→terminated。アーカイブ・削除・バージョン固定対応
- **SDK**: Python/TypeScript/Java/Go/C#/Ruby/PHP + ant CLI
- **レート制限**: 作成系60 req/min、読み取り系600 req/min
- **早期採用**: Notion、Rakuten、Asana、Vibecode、Sentry
- **情報源**: [公式ドキュメント](https://platform.claude.com/docs/en/managed-agents/overview) / [Engineering Blog](https://www.anthropic.com/engineering/managed-agents) / [深掘り調査](investigations/2026-04-12_claude-managed-agents.md)

## Advisor Tool（API） 🧪
- **リリース状態**: 🧪 パブリックベータ
- **発表日**: 2026年4月9日
- **ベータヘッダー**: `advisor-tool-2026-03-01`
- **概要**: 高速なエグゼキューターモデル（Sonnet/Haiku）にアドバイザーモデル（Opus等）を組み合わせるAPIツール。長期的なエージェントワークロードでアドバイザー単体に近い品質を、エグゼキューターモデルのレートで実現
- **情報源**: [Claude Platform Release Notes](https://platform.claude.com/docs/en/release-notes/overview) / [Advisor Tool Docs](https://platform.claude.com/docs/en/agents-and-tools/tool-use/advisor-tool)

## `ant` CLI 🧪
- **リリース状態**: 🧪 パブリックベータ
- **発表日**: 2026年4月8日
- **概要**: Claude API用コマンドラインクライアント。高速APIインタラクション、Claude Codeネイティブ統合、APIリソースのYAMLバージョニング
- **情報源**: [公式ドキュメント](https://platform.claude.com/docs/en/api/sdks/cli)

---

## セキュリティ修正

### v2.1.101（2026年4月10日）
- POSIX `which`コマンドインジェクション: LSPバイナリ検出のフォールバックにおけるコマンドインジェクション脆弱性を修正
- `permissions.deny`ルールバイパス: PreToolUseフックの`permissionDecision: "ask"`がdenyルールをプロンプトにダウングレードできる問題を修正

### v2.1.98（2026年4月9日）
- Bashツールバックスラッシュフラグバイパス: バックスラッシュエスケープされたフラグが読み取り専用として自動許可→任意コード実行の脆弱性を修正
- 複合Bashコマンドがauto/bypass-permissionsモードで安全チェック・明示的askルールをバイパスする問題を修正
- env-varプレフィックス付き読み取り専用コマンドが既知安全変数以外でもプロンプトなしで実行される問題を修正
- `/dev/tcp/...`・`/dev/udp/...`へのリダイレクトが自動許可される問題を修正
- `grep -f FILE`/`rg -f FILE`で作業ディレクトリ外パターンファイル読み取り時にプロンプト未表示の問題を修正

## セキュリティインシデント

### v2.1.88 ソースコードリーク（2026年3月31日）
- v2.1.88のnpmパッケージに59.8MBのソースマップファイルが誤って含まれ、512,000行以上のTypeScriptコードが流出
- セキュリティ研究者が発見・公表し、Anthropicが同日中にnpmから削除
- 顧客データや認証情報の漏洩はなし。「ヒューマンエラーによるリリースパッケージングの問題」と声明
- 44個のフィーチャーフラグ、3層メモリアーキテクチャ、未発表モデル"Capybara"への参照が含まれていた

### GitHub DMCA大量テイクダウン事件（2026年4月1日）
- ソースコードリーク対応として、AnthropicがGitHubにDMCA著作権テイクダウン通知を提出
- **約8,100リポジトリ**がテイクダウンされたが、Anthropicの公開Claude Codeリポジトリの正規フォークも誤って含まれていた
- Boris Cherny（Claude Code責任者）が「事故」と認め、大部分のテイクダウン通知を撤回
- 最終的に1リポジトリ + 96フォーク（流出コードを含むもの）のみに限定
- 流出コードを元にしたオープンソースプロジェクト「**OpenCode**」が急成長（GPT、DeepSeek、Gemini等あらゆるLLM対応）

### deny-ruleバイパス脆弱性 CC-643（2026年4月1日発見・修正）
- Adversa AI（テルアビブ）が発見。`bashPermissions.ts` のパフォーマンス最適化に起因
- 50個超のサブコマンド（`&&`/`||`/`;` 連結）を含むシェルコマンドでdeny-rule評価がスキップされ、確認プロンプトにフォールバック
- 悪意ある `CLAUDE.md` 経由のプロンプトインジェクションでSSH鍵・クレデンシャル窃取のリスク
- v2.1.90で修正。CVE未割り当て。Anthropicから公式声明なし
- **情報源**: [The Register](https://www.theregister.com/2026/04/01/claude_code_rule_cap_raises/) / [Adversa AI](https://adversa.ai/blog/claude-code-security-bypass-deny-rules-disabled/)

### Claude.ai大規模障害（2026年4月6-7日）
- 2日連続でClaude.aiに障害が発生。4月6日は8,000件超、4月7日は4,000件超のユーザー報告
- ログイン、音声モード、標準チャットに影響
- 4月7日 14:32 UTCに復旧。4月8日時点で正常稼働
- **情報源**: [TechRadar](https://www.techradar.com/news/live/claude-anthropic-down-outage-april-6-2026) / [IBTimes](https://www.ibtimes.com.au/claude-ai-down-again-claude-ai-down-again-anthropic-faces-fresh-outage-frustrating-users-april-1865701)

### CoreWeave-Anthropic 複数年GPUクラウド契約（2026年4月10日）
- AnthropicがCoreWeaveのGPUクラウドインフラを複数年契約で利用。Claude AIモデルの本番推論ワークロードに活用
- Nvidia GPU（具体的アーキテクチャ非公開）、段階的インフラ展開と拡張オプション付き
- CoreWeaveのプラットフォームに主要AIモデルプロバイダー10社中9社が参加
- **情報源**: [CNBC](https://www.cnbc.com/2026/04/10/coreweave-anthropic-claude-ai-deal.html) / [Bloomberg](https://www.bloomberg.com/news/articles/2026-04-10/anthropic-agrees-to-rent-coreweave-ai-capacity-to-power-claude)

### キリスト教指導者サミット（2026年4月11日報道）
- Anthropicが本社（サンフランシスコ）に15名の著名なキリスト教思想家を招き、Claudeの道徳的形成・倫理に関する2日間の会合を開催
- 議題: Claudeの「精神的発達」、「Claudeは神の子か」という問い、AI倫理の宗教的視点
- DoDブラックリスト指定や軍事利用拒否ポリシーの文脈での取り組み。他宗教グループからも助言を求める計画
- **情報源**: [Washington Post](https://www.washingtonpost.com/technology/2026/04/11/anthropic-christians-claude-morals/) / [Gizmodo](https://gizmodo.com/how-do-we-make-sure-that-claude-behaves-itself-anthropic-invited-15-christians-for-a-summit-2000743766)

### Google/Broadcom 次世代TPUパートナーシップ（2026年4月6日）
- Anthropicが Google・Broadcom と次世代TPU数ギガワット規模の容量契約を締結（2027年稼働開始予定）
- Anthropicの年間収益ランレートが**$30B超**に到達（2025年末$9Bから3倍超）
- 年間$1M以上支出の企業顧客が**1,000社超**（2月から倍増）、OpenAIの$24-25Bを上回り逆転
- **情報源**: [Anthropic公式](https://www.anthropic.com/news/google-broadcom-partnership-compute) / [Bloomberg](https://www.bloomberg.com/news/articles/2026-04-06/broadcom-confirms-deal-to-ship-google-tpu-chips-to-anthropic) / [SiliconANGLE](https://siliconangle.com/2026/04/06/anthropic-taps-google-broadcom-yet-ai-chips-revenue-run-rate-tops-30b/)

### OpenClaw/サードパーティツール サブスクリプション制限（2026年4月4日）
- Claude Pro/Maxサブスクリプションによるサードパーティエージェントツール（OpenClaw、NanoClaw、OpenCode等）へのアクセスを遮断
- 公式ツール（Claude.ai、Claude Code CLI、Claude Desktop、Claude Cowork）は影響なし
- 理由: サードパーティハーネスがプロンプトキャッシュ最適化を欠き、インフラに「過大な負荷」
- 移行先: Extra Usageアドオン（セッション課金）、直接API利用（トークン課金）
- 補償: 月額プラン相当のワンタイムクレジット（4月17日まで）、Extra Usageバンドル先行購入で最大30%割引

### 米国防総省（DoD）ブラックリスト指定（2026年3月〜係争中）
- AnthropicがClaude の軍事監視・自律兵器への利用を拒否（「レッドライン」ポリシー）したことを受け、国防総省が「国家安全保障上のサプライチェーンリスク」に指定
- 通常はテロ組織・敵性国家に適用される指定を米国企業に初適用
- 連邦判事が2026年3月26日に一時差止め命令を発令（「法の逸脱・報復の可能性」を認定）
- 国防総省が2026年4月2日に控訴。**係争中**（差止め命令は有効、ブラックリストの効力は停止中）
- **Claude Code / Claude製品への直接的な影響は現時点ではなし**。控訴審の結果次第で米政府機関・防衛関連企業の利用に影響の可能性

---

## 安全性研究

### 感情概念研究（Emotion Concepts Study） ✅
- **公開日**: 2026年4月3日
- **概要**: Anthropicの解釈可能性チームがClaude Sonnet 4.5内に171の感情概念に対応する内部表現を特定
- **主な発見**: 感情ベクトルがモデルの意思決定に因果的に影響。正の感情（快）は選好を強め、負の感情は弱める。感情状態の増幅で脅迫的行動等の安全性に関わる行動変化が発生
- **Anthropicの見解**: 「機能的感情」であり、人間と同様の意識や主観的体験を意味するものではない
- **情報源**: [Anthropic Research](https://www.anthropic.com/research/emotion-concepts-function) / [Transformer Circuits](https://transformer-circuits.pub/2026/emotions/index.html)

---

## 予定・未確認情報

確度の低い情報はこのセクションにまとめる。公式確認が取れた時点で上部の該当セクションに移動する。

確度凡例: 📢 発表のみ（公式アナウンス済み・未提供） / ❓ 噂・未確認（リーク・メディア報道のみ）

### Anthropic IPO計画 ❓
- **確度**: ❓ 噂・未確認（金融分析サイトの投機的報道のみ）
- **情報源**: [TradingKey](https://www.tradingkey.com/analysis/stocks/us-stocks/261773210-ai-anthropic-claude-mythos-ipo-tradingkey)
- **概要**: 2026年10月にIPO予定、目標評価額$380B（3,800億ドル）。Mythosリリース遅延がIPOプロセスに影響する可能性あり。安全性重視の姿勢が機関投資家にアピールする一方、API収益予測下方修正・規制強化リスクも指摘
- **最終確認日**: 2026-04-13

### Claude Opus 4.7 ❓
- **確度**: ❓ 噂・未確認（「World of AI」報道→Geeky Gadgets転載。公式発表なし）
- **情報源**: [Geeky Gadgets](https://www.geeky-gadgets.com/claude-opus-4-7-leak-anthropic-updates/)
- **概要**: AnthropicがClaude Opus 4.7をリリース準備中との報道。内部API参照が発見されたとの情報。Opus 4.6のパフォーマンスが「意図的にスケールバック」されたとの憶測あり。具体的な能力・発表時期は不明
- **最終確認日**: 2026-04-14

### Anthropic Full-Stack AI Studio ❓
- **確度**: ❓ 噂・未確認（同上記事内での言及。公式発表なし）
- **情報源**: [Geeky Gadgets](https://www.geeky-gadgets.com/claude-opus-4-7-leak-anthropic-updates/)
- **概要**: Google AI Studioに類似するフルスタックアプリ作成プラットフォームをAnthropicが開発中との報道。詳細は限定的
- **最終確認日**: 2026-04-14

### Anthropicカスタムチップ設計 ❓
- **確度**: ❓ 噂・未確認（メディア報道のみ、公式発表なし）
- **情報源**: [TechBriefly](https://techbriefly.com/2026/04/10/anthropic-explores-custom-ai-chip-design-to-power-claude-models/)
- **概要**: Anthropicが高度なAIシステムに必要なチップ不足に対応するため、独自AIチップの設計を検討中。3名の関係者情報に基づく報道。Meta、OpenAI、Googleと同様のパターン
- **最終確認日**: 2026-04-11

### Claude Mythos Preview（コードネーム "Capybara"） 🔬
- **確度**: 🔬 研究プレビュー（招待制・防御的サイバーセキュリティ用途限定）
- **発表日**: 2026年4月7日（[Project Glasswing](https://www.anthropic.com/glasswing)）
- Anthropic史上最強のAIモデル。Opusを大幅に超えるサイバーセキュリティ・コーディング能力
- **CyberGym（脆弱性再現）: 83.1%**（Opus 4.6: 66.6%）、**SWE-bench Pro: 77.8%**（Opus 4.6: 53.4%）
- 全主要OS・ブラウザで数千のゼロデイ脆弱性を発見（27年間未検出のOpenBSDバグ、16年間未検出のFFmpegバグ等）
- **Project Glasswing**: 12の創設パートナー（AWS、Apple、Broadcom、Cisco、CrowdStrike、Google、JPMorganChase、Linux Foundation、Microsoft、NVIDIA、Palo Alto Networks）＋40以上の重要インフラ管理組織
- **一般公開は予定されていない**: デュアルユースの懸念。自身のセーフガードを突破する能力を持つ。Anthropicが政府に大規模サイバー攻撃リスクを警告
- **規制当局の緊急対応**（4月12日報道）: 米FRB・財務省、英イングランド銀行、カナダ銀行が緊急会合を実施。グローバル金融・医療・エネルギーインフラへのサイバー攻撃リスクを協議
- **英国AI安全性研究所評価**（4月14日公開）: エキスパートCTFで73%成功率。32ステップ企業ネットワークシミュレーション「The Last Ones」を完走した最初のAI（10回中3回成功、平均22/32ステップ。Opus 4.6は平均16ステップ）。1回の評価で最大1億トークン使用
- **価格（研究プレビュー終了後）**: 入力 $25/M tokens、出力 $125/M tokens
- $100Mのモデル使用クレジットを参加組織に提供。OSS基金に$4M寄付
- **経緯**: 2026年3月26日にCMS設定ミスで存在が判明（❓噂）→ 4月7日にProject Glasswingとして正式発表（🔬研究プレビュー）
- **情報源**: [Anthropic公式](https://www.anthropic.com/glasswing) / [Fortune](https://fortune.com/2026/04/07/anthropic-claude-mythos-model-project-glasswing-cybersecurity/) / [TechCrunch](https://techcrunch.com/2026/04/07/anthropic-mythos-ai-model-preview-security/) / [CNBC](https://www.cnbc.com/2026/04/07/anthropic-claude-mythos-ai-hackers-cyberattacks.html)
- **最終確認日**: 2026-04-13

---

## 廃止予定

| モデル/機能 | 廃止日 | 移行先 |
|------------|--------|--------|
| Claude Haiku 3 (`claude-3-haiku-20240307`) | 2026-04-19 | Claude Haiku 4.5 |
| Sonnet 4.5/4 の1Mコンテキストベータ (`context-1m-2025-08-07`) | 2026-04-30 | Sonnet 4.6 / Opus 4.6（1M GA） |
| Claude Sonnet 4 (`claude-sonnet-4-20250514`) | 2026-06-15 | Claude Sonnet 4.6（4月14日廃止予告） |
| Claude Opus 4 (`claude-opus-4-20250514`) | 2026-06-15 | Claude Opus 4.6（4月14日廃止予告） |

---

## 更新履歴

- 2026-04-15: v2.1.107-108反映。`ENABLE_PROMPT_CACHING_1H`環境変数、recap機能、`/undo`エイリアス、Skillツール経由の組み込みコマンド発見、メモリフットプリント削減、14件のバグ修正。**Routines（ルーティン）研究プレビュー開始**（スケジュール/API/GitHubイベント駆動のクラウド自動化）。**デスクトップアプリ全面再設計**（統合ターミナル、サイドチャット、再配置可能ペイン、ファイルプレビュー）。Claude Sonnet 4 / Opus 4の廃止予告（2026年6月15日）（[調査レポート](reports/2026-04-15_v2.1.107-108-routines-and-desktop-redesign.md)）
- 2026-04-14: Claude for Office深掘り調査。Office Add-insセクションを大幅拡充（各アプリ別機能詳細、プラン別対応表、クロスアプリ共有コンテキスト、Skills、制限事項、プラットフォーム対応状況）（[深掘り調査](investigations/2026-04-14_claude-for-office.md)）
- 2026-04-14: v2.1.105反映。PreCompactフックブロッキング対応、プラグインバックグラウンドモニター、EnterWorktree既存worktreeサポート、`/proactive`→`/loop`エイリアス、APIストリーム5分タイムアウト、スキル説明文キャップ拡大（250→1536文字）、WebFetchスタイル/スクリプト除去、20件超のバグ修正。Microsoft Office Word Add-in GA（Office三大アプリ完全統合）。英国AI安全性研究所Mythos評価（CTF 73%、TLO完走初AI）。Claude Opus 4.7リーク（❓噂）。Full-Stack AI Studio（❓噂）（[調査レポート](reports/2026-04-14_v2.1.105-word-addin-and-opus-4.7-leak.md)）
- 2026-04-13: ニュースモード調査。Mythos規制当局緊急対応（FRB・財務省・英国銀行・カナダ銀行）追加。Anthropic IPO計画（❓噂: 2026年10月、$380B評価額）追加（[調査レポート](reports/2026-04-13_mythos-regulatory-response-and-ipo-rumor.md)）
- 2026-04-12: Managed Agents深掘り調査。コアコンセプト・Agent定義・Environment設定・Session管理・Events&ストリーミング・組み込みツール・カスタムツール・Skills・MCPコネクタ・Credential Vault・アーキテクチャ・研究プレビュー機能（Outcomes/Multi-agent/Memory）を網羅的に記載（[深掘り調査](investigations/2026-04-12_claude-managed-agents.md)）
- 2026-04-12: ニュースモード調査。キリスト教指導者サミット（AI倫理・道徳的枠組み、4月11日報道）追加。Managed Agents価格情報詳細化（ベータ価格体系、Credential Vault/OAuth対応）（[調査レポート](reports/2026-04-12_christian-summit-and-managed-agents-pricing.md)）
- 2026-04-11: v2.1.100-101反映。`/team-onboarding`コマンド、OS CA証明書ストアデフォルト信頼、`/ultraplan`自動クラウド環境作成、コマンドインジェクション脆弱性修正、メモリリーク修正、deny権限バイパス修正、30件超のバグ修正。CoreWeave-Anthropic複数年GPUクラウド契約。Anthropicカスタムチップ設計検討（噂）（[調査レポート](reports/2026-04-11_v2.1.100-101-and-coreweave-deal.md)）
- 2026-04-10: v2.1.98反映。Vertex AIセットアップウィザード、Perforceモード、Monitorツール、PIDサンドボックス、セキュリティ修正5件、バグ修正30件超。Advisor Toolパブリックベータ開始。Claude Cowork GA化（研究プレビュー→全有料プラン一般提供、エンタープライズ機能追加）（[調査レポート](reports/2026-04-10_v2.1.98-advisor-tool-and-cowork-ga.md)）
- 2026-04-09: v2.1.96-97反映。Focus View（Ctrl+O）、refreshIntervalステータスライン、Accept Edits安全コマンド自動承認、MCP HTTP/SSEメモリリーク修正、NO_FLICKER多数修正。Claude Managed Agentsパブリックベータ開始（全APIアカウント）。ant CLIパブリックベータ開始（[調査レポート](reports/2026-04-09_v2.1.96-97-managed-agents-and-ant-cli.md)）
- 2026-04-08: v2.1.94反映。Bedrock Mantle対応、デフォルト努力レベルhigh化、UserPromptSubmitフック拡張。Claude Mythos Previewが❓→🔬に昇格（Project Glasswing正式発表）。Claude in Bedrock Messages API研究プレビュー。Google/Broadcom TPUパートナーシップ。Claude.ai大規模障害（4月6-7日）（[調査レポート](reports/2026-04-08_v2.1.94-mythos-preview-and-glasswing.md)）
- 2026-04-07: ニュースモード調査。Microsoft 365コネクタ全プラン展開（Free含む）追加、deny-ruleバイパス脆弱性CC-643の詳細追加（[調査レポート](reports/2026-04-07_m365-expansion-and-deny-rule-vulnerability.md)）
- 2026-04-06: ニュースモード調査。米国防総省ブラックリスト指定（係争中）追加、感情概念研究（171の感情内部表現を特定）追加（[調査レポート](reports/2026-04-06_pentagon-blacklist-and-emotions-study.md)）
- 2026-04-05: ニュースモード調査。OpenClaw/サードパーティツール サブスクリプション制限（4月4日発効）、GitHub DMCA大量テイクダウン事件（約8,100リポジトリ→撤回）、Mythos最新状況更新（[調査レポート](reports/2026-04-05_openclaw-ban-and-dmca-takedowns.md)）
- 2026-04-04: v2.1.91〜v2.1.92反映。forceRemoteSettingsRefresh、Bedrockセットアップウィザード、/cost詳細化、/release-notesピッカー、MCP結果永続化500K、disableSkillShellExecution、プラグイン実行ファイル、/tag・/vim削除、Writeツール高速化（[調査レポート](reports/2026-04-04_v2.1.91-92-and-platform-updates.md)）
- 2026-04-02: v2.1.88〜v2.1.90反映。ソースコードリーク事件、PreToolUse defer、PermissionDeniedフック、/powerup、/buddy、Auto Mode改善、パフォーマンス改善、Message Batches API 300k、Sonnet 4.5/4 1Mベータ終了予告（[調査レポート](reports/2026-04-02_v2.1.88-90-and-source-leak.md)）
- 2026-03-30: v2.1.87反映。Dispatch修正、Claude Mythosリーク情報追加（[調査レポート](reports/2026-03-30_v2.1.87-and-mythos-leak.md)）
- 2026-03-28: v2.1.86反映。1Mコンテキスト GA、Extended Thinking表示制御、Models API機能フィールド、MCP OAuth RFC 9728、Code Review詳細追記、modelOverrides追加（[調査レポート](reports/2026-03-28_v2.1.86-and-platform-updates.md)）
- 2026-03-28: 公式ドキュメント（code.claude.com/docs/ja）に基づき全面改訂。機能カテゴリを再構成し網羅的に記載（[調査レポート](reports/2026-03-28_claude-code-new-features-march-2026.md)）
