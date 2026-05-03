# Claude Code 現行機能一覧

**最終更新:** 2026-05-04（**ニュースモード**: 新 CLI リリースなし、v2.1.126 継続最新。**主要な訂正**: 前回 5/3 で「❓ 5/6 Anthropic Developer Event」として噂扱いしていたイベントが、**実は 2026-03-18 に Anthropic 公式ブログで「Code with Claude SF/London/Tokyo」として正式アナウンス済み**だったことが判明 → **❓ 噂 → 📢 公式予告へ昇格**。前回調査では `claude.com/code-with-claude` 配下の公式 events 系ページを見落としていた。**判明した詳細**: ① **Code with Claude SF: 2026-05-06（Wed）8 AM–8 PM PT、9-10 AM Opening Keynote、Claude Code/Platform/Research の 3 トラック**、登壇者 **Ami Vora（CPO）/ Boris Cherny（Head of Claude Code）/ Cat Wu / Angela Jiang / Dianne Penn（Head of Product, Research）**、外部スピーカー Netflix / GitHub / Datadog / Cursor / Vercel、In-person 申込締切済み・Livestream 無料登録継続、**「live demos of new capabilities」公式予告あり**。② 5/7 Code with Claude: Extended SF（インディ開発者・ファウンダー向け companion event）。③ 3 都市開催: London 5/19+5/20、Tokyo 6/10+6/11。**Layer 2 追加公式予告**: ④ **Claude for Nonprofits ウェビナー（5/6 10:00 AM PT、Projects/Skills/Connectors を grant writing デモで実演）**、⑤ **Claude for Financial Services: Putting agents to work ウェビナー（5/7、エージェント実運用フォーカス）**。**結論**: 5/5 Financial Services Briefing → 5/6 Code with Claude SF Keynote + Nonprofits ウェビナー → 5/7 Code with Claude Extended + Financial Services ウェビナーで **Anthropic イベント連発週**、特に **5/6 SF Keynote は新製品・新機能発表のメインステージ**となる蓋然性が高い（Sonnet 4.8 / Claude Jupiter / KAIROS / Computer Use ベータ昇格 / Routines GA 化などの個別具体は依然 ❓ 噂のまま）。**Layer 3**: 5/3〜5/4 で Pentagon-Anthropic 関連・Mythos・$50B 調達ラウンドに新たな公的進展なし）


Claude Codeは、コードベースの読み取り・ファイル編集・コマンド実行・開発ツール統合を行うAIコーディングアシスタント。ターミナル、IDE、デスクトップアプリ、ブラウザで利用可能。

**確度バッジ:** ✅ GA（一般提供） | 🔬 研究プレビュー | 🧪 ベータ | 📢 発表のみ | ❓ 噂・未確認

---

## 利用環境

| 環境 | 概要 |
|-----|------|
| **Terminal CLI** | ファイル編集、コマンド実行、プロジェクト管理をコマンドラインから直接操作 |
| **VS Code** | インライン差分表示、@メンション、プラン確認、会話履歴をエディタ内で |
| **JetBrains** | IntelliJ、PyCharm、WebStorm等のプラグイン。差分表示とコンテキスト共有 |
| **Desktop App (Cowork)** | スタンドアロンアプリ。✅ GA（全有料プラン）。2026年4月14日に全面再設計：統合ターミナル、サイドチャット（`⌘+;`/`Ctrl+;`）、改善Diffビューア、ファイルエディタ、HTML/PDFプレビュー、再配置可能ペイン（Preview/Plan/Diff/Tasks/Terminal/Chat）、複数セッション並行。エンタープライズ: RBAC、グループ支出制限、利用分析、OpenTelemetry拡張、Zoom MCPコネクタ、ツール単位コネクタ制御。**Amazon Bedrock 経由配信** ✅ GA（2026-04-21〜、Anthropic シート課金不要、AWS 従量課金、IAM/VPC/CloudTrail/CloudWatch、Bedrock はプロンプト・ファイル・レスポンス非保持。Anthropic-hosted の Chat/Computer Use/Skills Marketplace は除外） |
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
- **リリース状態**: 🔬 研究プレビュー（Max/Team、管理者承認要）
- セーフガードがアクションを事前レビューし、安全と判断されたものを自動実行
- Sonnet 4.6 または Opus 4.6/4.7 が必要
- **Maxサブスクライバー対応（v2.1.111〜）**: Opus 4.7使用時のみ利用可能
- **`--enable-auto-mode`フラグ不要化（v2.1.111〜）**
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
| **MCP Tool Hook**（`type: "mcp_tool"`） | Hook 定義で `type: "mcp_tool"` を指定すると MCP サーバーのツールを直接実行可能。シェル/HTTP/LLM プロンプトに加わる 4 つめの hook タイプ（v2.1.118） |

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
- `CLAUDE_CODE_NO_FLICKER=1`: alt-screenレンダリング+仮想化スクロールバックでフリッカーフリー表示（v2.1.89）。v2.1.110以降は `/tui fullscreen` でセッション中に切り替え可能
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
- **ネイティブClaude Codeバイナリ**: CLIがバンドルJavaScriptの代わりにプラットフォーム別optional dependencyとしてのネイティブバイナリを spawn。Bun/JavaScriptCoreベース、起動時間とNode.js依存の排除が狙い（v2.1.113）
- `sandbox.network.deniedDomains` 設定: 広い `allowedDomains` ワイルドカードより優先される個別ドメインブロックリスト（v2.1.113）
- Fullscreen mode で Shift+↑/↓ が可視領域外への選択拡張時にスクロール（v2.1.113）
- マルチライン入力で `Ctrl+A` / `Ctrl+E` が論理行の先頭/末尾へ移動（readline 互換、v2.1.113）
- Windows: `Ctrl+Backspace` で直前の単語を削除（v2.1.113）
- OSC 8 対応ターミナルで折り返された長いURLがクリック可能に（レスポンス・bash出力の両方、v2.1.113）
- `/loop`: Esc で保留中の wakeup をキャンセル、wakeup 表示を "Claude resuming /loop wakeup" に統一（v2.1.113）
- `/ultrareview`: チェック並列化で起動高速化、起動ダイアログに diffstat、アニメーション（v2.1.113）
- `/extra-usage` が Remote Control（モバイル/Web）クライアントから利用可能に（v2.1.113）
- Remote Control クライアントで `@`-file オートコンプリート候補をクエリ可能（v2.1.113）
- mid-stream でストールしたサブエージェントが10分後に明確なエラーで失敗（無音ハング回避、v2.1.113）
- **MCP `alwaysLoad` server config オプション**: `true` で当該サーバーの全ツールを tool-search 遅延ロードからスキップして常時利用可能（v2.1.121）
- **`claude plugin prune` コマンド**: orphaned auto-installed プラグイン依存を削除。`plugin uninstall --prune` で連鎖削除（v2.1.121）
- **`/skills` type-to-filter 検索ボックス**: 長い skill リストでスクロールせずタイプして絞り込み（v2.1.121）
- **PostToolUse hooks の `updatedToolOutput` が全ツール対応**: 従来 MCP ツールのみ可能だったツール出力 replace を全ツールに拡張（`hookSpecificOutput.updatedToolOutput`、v2.1.121）
- **オーバーフローダイアログのスクロール**: 端末を超えるダイアログを矢印キー / PgUp/PgDn / Home/End / マウスホイールで操作（フルスクリーン・非フルスクリーン両モード、v2.1.121）
- **`--dangerously-skip-permissions` の保護対象拡大**: `.claude/skills/`、`.claude/agents/`、`.claude/commands/` への書き込みは確認プロンプトを表示（v2.1.121）
- **`/terminal-setup` で iTerm2 clipboard アクセス**: "Applications in terminal may access clipboard" を有効化、`/copy` が iTerm2（tmux 内含む）で動作（v2.1.121）
- **MCP server 起動エラー自動リトライ**: 一時的エラーで disconnect のままだったサーバーを最大 3 回まで自動リトライ（v2.1.121）
- **Vertex AI X.509 証明書ベース Workload Identity Federation（mTLS ADC）対応**（v2.1.121）
- **OpenTelemetry LLM request span 拡張**: `stop_reason`、`gen_ai.response.finish_reasons`、`user_system_prompt`（`OTEL_LOG_USER_PROMPTS` ゲート付き）を追加（v2.1.121）
- **SDK `mcp_authenticate` の `redirectUri` 対応**: カスタムスキーム完了 / claude.ai connectors の OAuth フロー対応（v2.1.121）
- **\[VSCode\] 音声入力が `accessibility.voice.speechLanguage` を尊重**: Claude Code 言語未設定時のフォールバック（v2.1.121）
- **\[VSCode\] `/context` がネイティブトークン使用量ダイアログを開く**（v2.1.121）
- **メモリリーク 3 件 fix**: 多数画像処理時の RSS 数 GB 級増大、`/usage` の最大 ~2GB リーク（大規模トランスクリプト履歴）、長時間ツールが progress イベント未発行時のリーク（v2.1.121）
- **Bash ツール起動ディレクトリ削除/移動の永続失敗を修正**: mid-session で消えた起動ディレクトリで Bash が永続的に使用不能になる問題を解消（v2.1.121）
- **`--resume` の堅牢化**: 外部ビルドの起動クラッシュ修正、unclean shutdown による壊れた transcript line をスキップして大規模セッションでも復元可能（v2.1.121）
- **`ANTHROPIC_BEDROCK_SERVICE_TIER` 環境変数**: Bedrock サービス層を `default`/`flex`/`priority` から選択。`X-Amzn-Bedrock-Service-Tier` ヘッダーとして送信。`priority` で低レイテンシ保証、`flex` でコスト最適化（v2.1.122）
- **`/resume` の PR URL 検索**: GitHub / GitHub Enterprise / GitLab / Bitbucket の PR URL を貼り付けると、その PR を作成したセッションを発見（v2.1.122）
- **`/mcp` で claude.ai connectors 重複表示**: 同一 URL の手動追加サーバーで隠されている claude.ai コネクタも表示し、重複削除のヒントを提供（v2.1.122）
- **OpenTelemetry 数値属性正規化**: `api_request`/`api_error` の数値属性が string ではなく number として送出（v2.1.122）
- **`claude_code.at_mention` OpenTelemetry イベント**: `@`-mention 解決を観測可能に（v2.1.122）
- **画像リサイズ 2,576px→2,000px max 修正**: newer モデル（Opus 4.7 等）で誤って 2,576px に拡大されていた画像を正しく 2,000px max に修正（v2.1.122）
- **`/branch` フォーク失敗修正**: "tool_use ids were found without tool_result blocks" エラーで失敗していた問題を修正（v2.1.122）
- **Vertex AI / Bedrock session-title 生成 `invalid_request_error` 修正**（v2.1.122）
- **Voice mode の Caps Lock キーバインド警告**: Caps Lock の特殊性により正しく動作しないため、エラー表示で誤認を防止（v2.1.122）
- **`claude project purge [path]` 新コマンド**: プロジェクトの全 Claude Code 状態（トランスクリプト・スケジュールタスク・ファイル変更履歴・config エントリ）を一括削除。`--dry-run` / `-y`(`--yes`) / `-i`(`--interactive`) / `--all` フラグ対応（v2.1.126）
- **`/model` ピッカーがゲートウェイ対応**: `ANTHROPIC_BASE_URL` が Anthropic 互換ゲートウェイ（LiteLLM / OpenRouter / 内製プロキシ等）を指すとき、ゲートウェイの `/v1/models` エンドポイントから動的にモデル一覧取得。固定リスト + `ANTHROPIC_DEFAULT_*_MODEL_NAME` オーバーライドより柔軟（v2.1.126）
- **`--dangerously-skip-permissions` の保護パス書き込みプロンプトをバイパス**: `.claude/`/`.git/`/`.vscode/`/シェル設定ファイル（`.bashrc` 等）への書き込み確認プロンプトもバイパス対象に拡張。**ただし危険な削除コマンド（`rm`/`rmdir` の `/` や `$HOME` 対象）は引き続きプロンプト維持**（v2.1.126）
- **`claude auth login` の WSL2/SSH/コンテナ対応**: ブラウザコールバックが localhost に到達できない環境で、ターミナルに OAuth コードを直接貼り付けて認証完了（v2.1.126）
- **`claude_code.skill_activated` OpenTelemetry イベント拡張**: ユーザー入力スラッシュコマンドでも発火、`invocation_trigger` 属性追加（`"user-slash"` / `"claude-proactive"` / `"nested-skill"`）（v2.1.126）
- **Auto Mode UI: スピナー赤化**: パーミッションチェック遅延時にスピナーが赤色に変化、ツール実行中に見える誤認を防止（v2.1.126）
- **PowerShell 7 検出強化**（Windows）: Microsoft Store / MSI（PATH 未設定）/ .NET Global Tool 経由インストールも検出。PowerShell ツール有効時は **PowerShell をプライマリシェル**として扱う（Bash デフォルトから変更）（v2.1.126）
- **2,000px 超画像ペーストの自動ダウンスケール**: 過大画像によるセッション破損を解消、履歴中の過大画像も自動削除して再試行（v2.1.126）
- **ホスト管理デプロイメントのアナリティクス自動無効化を廃止**: `CLAUDE_CODE_PROVIDER_MANAGED_BY_HOST` 環境下で Bedrock/Vertex/Foundry のアナリティクス自動無効化が廃止、明示的 opt-out が必要に（v2.1.126）
- **Mac スリープ解除時の "Stream idle timeout" 修正**、バックグラウンド/リモートセッションの長時間モデル思考休止中の誤 timeout 修正（v2.1.126）
- **Windows no-flicker モードでの日本語/韓国語/中国語文字化け修正**、`Ctrl+L` のプロンプト入力削除動作を画面再描画のみに統一（readline 互換）、Cursor/VS Code 1.92-1.104 統合ターミナルの過速トラックパッドスクロール修正（v2.1.126）
- **Windows クリップボード EDR/SIEM テレメトリ漏洩修正**: コピー内容が EDR/SIEM のプロセスコマンドラインで公開されていた問題を修正、>22KB クリップボード未到達修正、PowerShell ツールの `--%` 誤判定（`git diff -- file` 等）修正（v2.1.126）
- **Agent SDK 不正形式ツール名 hang 修正**: モデルが並列ツール呼び出しで不正形式ツール名を発行した際にハングする問題を修正（v2.1.126）
- **Vim visual モード / visual-line モード**: `v` でキャラクタ選択、`V` で行選択。operators（`d`/`y`/`c` 等）と視覚フィードバック対応（v2.1.118）
- **`/cost`・`/stats` を `/usage` に統合**: 単一 `/usage` コマンドのタブ UI に集約。`/cost`・`/stats` はタイピングショートカットとして残存し対応タブをオープン（v2.1.118）
- **カスタムテーマ**: `/theme` から名前付きカスタムテーマ作成・切替、`~/.claude/themes/` の JSON を直接編集。**プラグインが `themes/` ディレクトリ配下でテーマ配布可能**（v2.1.118）
- **`/color` が claude.ai/code にアクセントカラー同期**: Remote Control 接続時、セッションアクセント色が claude.ai/code に同期（v2.1.118）
- **`DISABLE_UPDATES` 環境変数**: 手動 `claude update` 含む全アップデートパスを完全遮断。`DISABLE_AUTOUPDATER`（自動更新のみ）より厳格（v2.1.118）
- **WSL 側の Windows managed settings 継承**: `wslInheritsWindowsSettings` ポリシーキーで、WSL が Windows 側 managed settings を継承（企業 IT 運用向け、v2.1.118）
- **Auto mode `"$defaults"` プレースホルダ**: `autoMode.allow`/`soft_deny`/`environment` に `"$defaults"` を含めるとビルトインルールを置き換えず併存（v2.1.118）
- **`claude plugin tag`**: プラグイン用 release git tag 作成、バージョン検証付き（v2.1.118）
- **`--continue`/`--resume` が `/add-dir` セッションを発見**: カレントディレクトリを `/add-dir` で追加したセッションも再開候補に（v2.1.118）
- **`/fork` の効率化**: 親会話全体をディスクに書き込むのではなく、ポインタを書いて読み込み時に hydrate（v2.1.118）
- `/model` ピッカーが `ANTHROPIC_DEFAULT_*_MODEL_NAME`/`_DESCRIPTION` override を honor（カスタム `ANTHROPIC_BASE_URL` gateway 時、v2.1.118）
- **ネイティブビルドで `bfs` / `ugrep` 埋め込み**: macOS/Linux のネイティブバイナリに fast find (`bfs`)・fast grep (`ugrep`) を内蔵し、`Glob`/`Grep` 専用ツールを Bash 経由の高速実行に置換。専用ツール round-trip を省略（v2.1.117、Windows/npm 版は従来通り）
- **複数 MCP サーバー並列接続**: ローカル MCP サーバーと claude.ai MCP サーバーの並列接続がデフォルトに。起動高速化（v2.1.117）
- **Windows: `where.exe` 検索をプロセスあたりキャッシュ** でサブプロセス起動高速化（v2.1.117）
- **Forked subagents を外部ビルドで有効化**: `CLAUDE_CODE_FORK_SUBAGENT=1` で non-native ビルドでも fork 型サブエージェントが利用可能（v2.1.117）
- **Agent frontmatter `mcpServers`** が `--agent` でメインスレッド実行時も読み込まれるように（v2.1.117）
- **`/model` 選択永続化改善**: プロジェクトピンを跨いで再起動後も選択維持、起動ヘッダーに active モデルの出自表示（v2.1.117）
- **`/resume` で stale 大規模セッションの summarize**: 再読み込み前に要約するか問い合わせ（v2.1.117）
- **Advisor Tool**: experimental ラベル、learn-more リンク、startup notification 追加。"Advisor tool result content could not be processed" エラーでセッションが毎プロンプト失敗する問題を修正（v2.1.117）
- **`cleanupPeriodDays` 対象拡大**: `~/.claude/tasks/`、`shell-snapshots/`、`backups/` も retention sweep 対象に（v2.1.117）
- **OpenTelemetry 拡張**: `user_prompt` に `command_name`/`command_source`、`cost.usage`/`token.usage`/`api_request`/`api_error` に `effort` 属性追加。カスタム/MCP コマンド名は `OTEL_LOG_TOOL_DETAILS=1` 未設定時は redact（v2.1.117）
- **Pro/Max デフォルト effort: Opus 4.6/Sonnet 4.6 で `medium` → `high`**（v2.1.117、v2.1.94 で API key/Bedrock/Vertex/Foundry/Team/Enterprise には適用済み、今回 Pro/Max subscription ユーザーに拡張）
- **Opus 4.7 `/context` 計算修正**: 200K 固定計算になっていた問題を 1M ネイティブに合わせて修正。インフレされた % 表示・早期 autocompact を解消（v2.1.117）
- **Plain-CLI OAuth 反応的リフレッシュ**: access token mid-session 期限切れで "Please run /login" 連発する問題を、401 時の reactive refresh で解決（v2.1.117）
- **MCP OAuth 修正群**（v2.1.118）: `headersHelper` 設定時の Authenticate/Re-authenticate 操作復活、`expires_in` なしトークンでの毎時再認証解消、step-up authorization の `insufficient_scope` 403 で silent refresh ではなく re-consent プロンプト、cross-process lock 競合修正、**macOS キーチェーンレース条件**（並行 refresh でリフレッシュ済みトークンが上書き）修正
- **Plugin 依存 auto-resolve**: `plugin install` で既インストールプラグインの missing 依存を install、エラーが "not installed" + install hint を表示、`claude plugin marketplace add` が missing 依存を auto-resolve（v2.1.117）
- **`blockedMarketplaces`/`strictKnownMarketplaces` enforcement**: plugin install/update/refresh/autoupdate 全てでポリシー適用（v2.1.117）
- `/resume` の大規模セッション処理が最大67%高速化（40MB+ セッション）。dead-fork エントリが多いセッションも効率的に処理（v2.1.116）
- MCP 起動の高速化: 複数 stdio サーバー環境で `resources/templates/list` を初回 `@`-mention まで遅延実行（v2.1.116）
- フルスクリーンスクロール改善: VS Code / Cursor / Windsurf ターミナルでスムーズ化、`/terminal-setup` がエディタのスクロール感度を自動設定（v2.1.116）
- Thinking spinner のインライン進捗表示: 「still thinking」「thinking more」「almost done thinking」がスピナー内に統合（v2.1.116）
- `/config` 検索が値もマッチ（例: 「vim」で Editor mode 設定が見つかる）（v2.1.116）
- `/doctor` が応答中でも開けるように（現ターン完了を待たない、v2.1.116）
- `/reload-plugins` および バックグラウンド自動更新が、追加済みマーケットプレイスから**プラグインの欠落依存を自動インストール**（v2.1.116）
- Bash ツール: `gh` コマンドが GitHub API レート制限に達した際にヒント表示、エージェントがバックオフ可能に（v2.1.116）
- Usage tab（Settings）: 5時間・週次使用量を即座に表示、使用状況エンドポイントのレート制限時も失敗しない（v2.1.116）
- Agent frontmatter `hooks:` が `--agent` でメインスレッドエージェント実行時にも発火（v2.1.116）
- スラッシュコマンドメニュー: フィルタ結果0件時に「No commands match」を表示（メニュー消失回避、v2.1.116）
- セキュリティ: sandbox auto-allow が `rm`/`rmdir` の `/`・`$HOME`・クリティカルディレクトリ対象時に dangerous-path safety check をバイパスしないように（v2.1.116）
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
- Extended Thinkingインジケータにローテーションプログレスヒント追加（v2.1.109）
- `/tui`コマンドと`tui`設定: `/tui fullscreen`でセッション中にフリッカーフリーレンダリングに切り替え可能（v2.1.110）
- `xhigh`努力レベル: Opus 4.7向け新しい努力レベル（`high`と`max`の間）。`/effort`、`--effort`、モデルピッカーから選択可能。他モデルでは`high`にフォールバック（v2.1.111）
- `/effort`インタラクティブスライダー: 引数なしで呼び出すと矢印キー操作のスライダーを表示、Enterで確定（v2.1.111）
- "Auto (match terminal)"テーマ: ターミナルのダーク/ライトモードに追従（v2.1.111）
- Claude Codeデフォルト努力レベルが`xhigh`に変更（全プラン、Opus 4.7使用時）（v2.1.111）
- Windows PowerShellツール段階展開: `CLAUDE_CODE_USE_POWERSHELL_TOOL`でopt-in/opt-out。Linux/macOSでも`CLAUDE_CODE_USE_POWERSHELL_TOOL=1`で有効化可能（要`pwsh`）（v2.1.111）
- globパターン付き読み取り専用Bashコマンド（`ls *.ts`等）および`cd <project-dir> &&`で始まるコマンドが権限プロンプトをトリガーしないように（v2.1.111）
- CLIサブコマンドタイポ候補提示: `claude udpate` → "Did you mean `claude update`?"（v2.1.111）
- プランファイル名をプロンプトベースの命名に変更（例: `fix-auth-race-snug-otter.md`）（v2.1.111）
- `/setup-vertex`・`/setup-bedrock`改善: 実際の`settings.json`パス表示、既存ピンからのモデル候補シード、「with 1M context」オプション追加（v2.1.111）
- `/skills`メニュー: 推定トークンカウントによるソート（`t`キー）（v2.1.111）
- `Ctrl+U`: 入力バッファ全体をクリア（以前は行頭まで）。`Ctrl+Y`で復元（v2.1.111）
- `Ctrl+L`: プロンプト入力クリアに加え、全画面再描画を強制（v2.1.111）
- トランスクリプトビューフッターに`[`（スクロールバックダンプ）・`v`（エディタで開く）ショートカット表示（v2.1.111）
- ヘッドレス`--output-format stream-json`がinitイベントに`plugin_errors`を含める（v2.1.111）
- `OTEL_LOG_RAW_API_BODIES`環境変数: OpenTelemetryログイベントとしてフルAPIリクエスト/レスポンスボディを出力（v2.1.111）
- `Ctrl+O`がノーマル↔バーボストランスクリプトのトグルに変更、`/focus`が独立コマンドに分離（v2.1.110）
- `autoScrollEnabled`設定: フルスクリーンモードで自動スクロール無効化（v2.1.110）
- プッシュ通知ツール: Remote Control + 「Push when Claude decides」設定時にモバイルへプッシュ通知送信（v2.1.110）
- 外部エディタ（`Ctrl+G`）にClaude最終応答をコメント付きコンテキストとして表示するオプション（v2.1.110）
- `--resume`/`--continue`が期限切れでないスケジュールタスクを復活（v2.1.110）
- `/plugin` Installedタブ: お気に入り・注意必要アイテムを上部表示（v2.1.110）
- `/doctor`: 複数設定スコープで定義されたMCPサーバーへの警告追加（v2.1.110）
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
| `/tui` | TUIモード切替。`/tui fullscreen` でフリッカーフリーレンダリング（v2.1.110） |
| `/focus` | Focus View独立トグル（`Ctrl+O`から分離、v2.1.110） |
| `/ultrareview` | クラウドで並列マルチエージェント分析による包括的コードレビュー。引数なしでカレントブランチ、`/ultrareview <PR#>`で指定PRをレビュー（v2.1.111） |
| `/less-permission-prompts` | トランスクリプトをスキャンし、よく使う読み取り専用Bash・MCPツール呼び出しを`.claude/settings.json` allowlistとして提案するスキル（v2.1.111） |
| `/theme` | テーマ切替。「Auto (match terminal)」でターミナルのダーク/ライトモードに追従（v2.1.111）。**v2.1.118 でカスタムテーマ作成・切替対応**、`~/.claude/themes/` JSON 直接編集、プラグインが `themes/` で配布可能 |
| `/usage` | **使用統計・コスト統合ビュー（タブ UI）**（`/cost`・`/stats` を統合、v2.1.118） |
| `/stats` | `/usage` の統計タブを開くショートカット（v2.1.118 以降） |
| `/cost` | `/usage` のコスト内訳タブを開くショートカット（サブスクリプションユーザー向け、v2.1.92 / v2.1.118 で `/usage` に統合） |
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
| **デフォルトモデル** | Claude Opus 4.7（2026年4月16日GA〜）。**2026-04-23 より Enterprise pay-as-you-go および Anthropic API（第一者）のデフォルトモデルも Opus 4.6 → Opus 4.7 に切り替え**。API エイリアス `opus` が Opus 4.7 を解決、`sonnet` は Sonnet 4.6 のまま |
| **出力トークン上限** | デフォルト64k、上限128k（Opus/Sonnet 4.6、Opus 4.7）。Message Batches APIでは300k（`output-300k-2026-03-24`ベータヘッダー要） |
| **コンテキスト** | 1Mトークン（Opus 4.6/4.7/Sonnet 4.6はGA、ベータヘッダー不要。メディア上限600画像/PDFページ）。**Sonnet 4.5/4の1Mベータ（`context-1m-2025-08-07`）は2026年4月30日に retirement 発効**（両モデルで silent fallback で 200K、200K 超リクエストはエラー、移行先は Sonnet 4.6 / Opus 4.6） |
| **Fast Mode** | Opus 4.6で高速出力。`/fast` でトグル |
| **努力レベル** | `low` / `medium` / `high` / `xhigh` / `max`（`xhigh`はOpus 4.7のみ、他モデルでは`high`フォールバック。v2.1.111〜） |
| **Claude Codeデフォルト努力レベル** | `xhigh`（全プラン、Opus 4.7使用時）。コーディング・エージェント用途では`high`〜`xhigh`推奨 |
| **ビジョン** | Opus 4.7は長辺2,576pxまでの高解像度画像をサポート |
| **サードパーティ** | Amazon Bedrock、Google Vertex AI、Microsoft Foundry対応（Opus 4.7は全プラットフォームで同時GA）。Bedrock上でAnthropic Messages API（`/anthropic/v1/messages`）が4月16日より全AWS顧客にセルフサーブ開放（27リージョン）。**Snowflake Cortex AI**（Public Preview、US/EU、Opus 4.7同日展開）、**GitHub Copilot**（GA、Opus 4.7同日展開）で利用可能。**Amazon Bedrock で Opus 4.7 GA（2026-04-20）**: US East (N. Virginia) / Asia Pacific (Tokyo) / Europe (Ireland/Stockholm) の4リージョン、10,000 RPM/アカウント/リージョン、1Mコンテキスト、高解像度画像、adaptive thinking、next-gen inference engine。ただし**Claude Code on Bedrock のエイリアス解決は依然 `opus` → Opus 4.6、`sonnet` → Sonnet 4.5**。Opus 4.7 利用には full model name または `ANTHROPIC_DEFAULT_OPUS_MODEL` 環境変数の明示指定が必要。既知の不具合 [#49238](https://github.com/anthropics/claude-code/issues/49238)（Bedrock 経由での呼び出し失敗）が継続調査中 |
| **Extended Thinking 表示制御** | `thinking.display: "omitted"` でthinkingコンテンツをストリーミングから省略可能（signature保持）。インタラクティブセッションではthinking summaryがデフォルト無効化（`showThinkingSummaries: true`で復元、v2.1.89） |
| **Models API 機能照会** | `GET /v1/models` が `max_input_tokens`、`max_tokens`、`capabilities` を返すように（3月18日〜） |
| **modelOverrides** | モデルピッカーのエントリをカスタムプロバイダーモデルID（Bedrock ARN等）にマッピング |
| **Opus 4.7 → Opus 4.6 ブレーキングチェンジ** | APIブレーキングチェンジあり。更新されたトークナイザー。移行時は[マイグレーションガイド](https://platform.claude.com/docs/en/about-claude/models/migration-guide#migrating-to-claude-opus-4-7)参照 |

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


## Claude for Creative Work — クリエイティブツール 9 コネクタ ✅
- **リリース状態**: ✅ GA（**全 Claude プランで即時利用可能**、2026-04-28〜）
- **発表日**: 2026年4月28日（[Anthropic 公式 Newsroom](https://www.anthropic.com/news/claude-for-creative-work)）
- **概要**: Claude を主要なクリエイティブアプリケーション内で動作させる **9 つのコネクタ**を一斉公開。プロのデザイナー・3D アーティスト・音楽プロデューサー・建築家・VJ など多様なクリエイティブワークフローを Claude 経由で操作可能に
- **9 つのコネクタ**:

| コネクタ | 機能概要 |
|---------|---------|
| **Adobe for Creativity** | Photoshop / Premiere / Express など Creative Cloud 50+ ツールへのアクセス、画像・動画・デザインの編集 |
| **Affinity by Canva** | バッチ画像調整、レイヤーリネーム、ファイルエクスポート等の繰り返し作業を自動化 |
| **Autodesk Fusion** | 3D モデルを自然言語の対話で作成・修正（サブスクリプション要） |
| **Blender** | Python API への自然言語インタフェース、シーン解析、カスタムスクリプト生成、公式ドキュメントへの grounding |
| **Ableton** | Live / Push の公式ドキュメントに grounded された応答 |
| **Splice** | Claude 会話内から royalty-free サンプルカタログを検索 |
| **SketchUp** | 自然言語の空間説明から 3D モデリングのスタート地点を生成、アプリ内で精緻化 |
| **Resolume Arena & Resolume Wire** | VJ / ライブビジュアルアーティスト向け、ライブパフォーマンス中のリアルタイム制御 |

- **Blender Foundation Corporate Patron**: Anthropic は Blender Development Fund の Corporate Patron 階層（**年間最低 €240,000**）に同日加入。Blender Python API のメンテ・拡張支援が用途。**Blender 経由のコネクタ実装は MCP ベースで他 LLM からも利用可能**（Blender のオープンソース・他 LLM 非排除原則を尊重）
- **Claude Code への影響**: クリエイティブ系コーディングワークフロー（Blender Python スクリプト、Photoshop UXP プラグイン、SketchUp Ruby スクリプト等）で Claude Code から該当ツールを呼び出すパスが整備された。MCP サーバー実装は他 LLM CLI（OpenClaw 等）でも転用可能
- **情報源**: [Anthropic 公式](https://www.anthropic.com/news/claude-for-creative-work) / [Blender 公式プレスリリース](https://www.blender.org/press/anthropic-joins-the-blender-development-fund-as-corporate-patron/) / [9to5Mac](https://9to5mac.com/2026/04/28/anthropic-releases-9-new-claude-connectors-for-creative-tools-including-blender-and-adobe/) / [MacRumors](https://www.macrumors.com/2026/04/28/claude-creative-tool-connectors/)

## Agent Teams 🔬
- **リリース状態**: 🔬 実験的機能（`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` フラグで有効化、デフォルト無効）
- 複数の独立セッションが並行動作・相互通信
- **lead / teammate モデル**: リードエージェントがタスク調整、サブタスク割当、結果マージ。teammate はリードのパーミッション設定を継承（`--dangerously-skip-permissions` もリードに追従）。spawn後は個別にteammate modeを変更可能
- **パーミッションバブルアップ**: teammate のツール許可要求はリードの UI にバブルアップして承認される。頻出操作は `permissions.allow` に事前登録しておくと摩擦が減る
- **実行モード**: tmux / in-process
- **既知の修正**: v2.1.114（2026-04-18）で teammate がツール許可をリクエストした際の permission dialog クラッシュ修正
- **情報源**: [公式ドキュメント](https://code.claude.com/docs/en/agent-teams)

## Agent SDK
- Claude Codeのツール・機能を活用したカスタムエージェントを構築
- オーケストレーション・ツールアクセス・権限を完全制御

## Claude Opus 4.7 ✅
- **リリース状態**: ✅ GA（Claude API、Amazon Bedrock、Google Vertex AI、Microsoft Foundry、Snowflake Cortex AI（Public Preview）、GitHub Copilot）
- **リリース日**: 2026年4月16日（6プラットフォーム同時展開）
- **API デフォルトモデル切替**: 2026年4月23日より Enterprise pay-as-you-go および Anthropic API（第一者）のデフォルトモデルが Opus 4.6 → Opus 4.7 へ自動移行。API エイリアス `opus` が Opus 4.7 を解決するように
- **価格**: 入力 $5 / Mトークン、出力 $25 / Mトークン（Opus 4.6と同じ）
- **ベンチマーク**: SWE-bench Verified 87.6%（Opus 4.6: 80.8%）、SWE-bench Pro 64.3%（GPT-5.4: 57.7%、Gemini 3.1 Pro: 54.2%を上回る）、CursorBench 70%、GPQA Diamond 94.2%
- **主要アップグレード**:
  - ソフトウェアエンジニアリング性能向上（人間監督を要していた複雑タスクで計測可能な改善）
  - ビジョン: 長辺2,576pxまでの高解像度画像対応
  - 指示追従・長期エージェントワーク信頼性向上
  - 新しい`xhigh`努力レベル、タスク予算機能
  - 更新されたトークナイザー（Opus 4.6からAPIブレーキングチェンジあり）
- **Claude Code統合**: v2.1.111で対応、全プランでデフォルト`xhigh`努力レベル
- **Auto mode**: Maxサブスクライバーで利用可能（Opus 4.7使用時）
- **情報源**: [Anthropic公式](https://www.anthropic.com/news/claude-opus-4-7) / [マイグレーションガイド](https://platform.claude.com/docs/en/about-claude/models/migration-guide#migrating-to-claude-opus-4-7) / [ベンチマーク解説 - Vellum AI](https://www.vellum.ai/blog/claude-opus-4-7-benchmarks-explained)

## Claude Design 🔬
- **リリース状態**: 🔬 研究プレビュー（2026年4月17日〜、段階ロールアウト）
- **発表日**: 2026年4月17日（**Anthropic Labs** — 2026年1月新設の実験プロダクト・インキュベーション部門の第一弾プロダクト）
- **対象プラン**: **Claude Pro / Max / Team / Enterprise**（無料プラン対象外）
- **動作モデル**: Claude Opus 4.7（Anthropicの「最も高性能なビジョンモデル」として位置付け）
- **サーフェス**: `claude.ai/design`
- **利用枠**: 既存プラン枠を使用、**かつ通常の Claude chat / Claude Code 枠とは独立した週次 allowance**。超過後は extra usage を有効化して継続利用可能。早期ユーザー報告では「2セッションでProの週次枠の58%を消費」する例もあり、頻繁に使うならMax推奨
- **Enterprise での既定**: **デフォルト オフ**。管理者が Organization settings で明示有効化
- **概要**: 自然言語プロンプトから **HTML/CSS でライブレンダリングされたプロトタイプ・スライド・ランディングページ・ダッシュボード・1-pager・ソーシャルアセット**等を生成し、会話・インラインコメント・直接編集・調整スライダーで反復改善する会話型ビジュアル制作ツール
- **入力形式**: テキストプロンプト / 画像 / DOCX・PPTX・XLSX / GitHubリポジトリ接続 / ローカルディレクトリ接続（`Import`ボタン） / Figmaファイル
- **デザインシステム自動抽出**: 接続コードベースからコンポーネント構造・スタイリング/テーマ（カラー、スペーシング、タイポグラフィ）・ファイル構成を解析し、新規生成物に**チームのデザインシステムを自動適用**（v0/Lovableに対する独自性）
- **編集機能**: 会話による反復、要素ピン留めインラインコメント、テキスト直接編集、属性連続値スライダー
- **エクスポート/共有**: ZIP / PDF / PPTX / **Canva**（パートナーシップによる正規連携）/ スタンドアロンHTML / **Claude Code Hand off**（Local / Web）／ 組織内共有リンク（閲覧専用・コメント・編集アクセス）
- **Claude Code Hand off**（最大の差別化要素）: `Export`→`Hand off to Claude Code`で **デザインファイル + 全チャットログ（設計意図保持）+ READMEと貼り付け用プロンプト** を含むハンドオフバンドル生成。ローカルClaude CodeまたはClaude Code Webへ引き継ぎ。リンク済みリポがあれば「プロトタイプ」と「出荷可能コード」のギャップを大幅圧縮
- **対象ユーザー**: デザインツール非使用のファウンダー・プロダクトマネージャー・マーケター・営業（デザイナー専用ツールではない）
- **位置付け**: Canva / Figma の「代替ではなく補完」（公式説明）。Canvaは正式統合パートナー、Mike Krieger（Anthropic CPO）はローンチに先立ちFigma取締役を辞任
- **競合との差別化**: v0（純React/Next.js出力）/Lovable（フルデプロイ）/Bolt（フルスタック）に対し、**プロンプト→プロトタイプ→Claude Code経由で任意スタックへハンドオフ**できる「中間」ポジション
- **既知の制限**: シングルユーザー体験（リアルタイムコラボなし）、フレーム単位レビュー&承認なし、ベクターイラスト非対応、ネイティブReact/Tailwindコードエクスポート非対応（Hand off経由）、インラインコメント消失/コンパクトビュー保存エラー/大規模リポでのラグ等の既知バグ。大規模リポは特定ディレクトリ接続推奨（`node_modules`除外）
- **市場インパクト**: 4月14日のThe Informationリーク時点でFigma・Adobe・Wix等のデザイン関連株が下落。ローンチ翌週Figma株7%下落報道。Anthropicがモデル提供者からアプリケーションプラットフォーマーへ移行する象徴
- **関連既存プロダクト**: Claude Cowork内の「Design」プラグイン（Anthropic Verified、別製品）— デザインクリティーク、UXライティング、アクセシビリティ監査（WCAG 2.1 AA）、リサーチ統合、開発ハンドオフ。Claude Designは「ジェネレーター型」、Designプラグインは「レビュアー型」
- **情報源**: [深掘り調査](investigations/2026-04-28_claude-design.md) / [Introducing Claude Design by Anthropic Labs](https://www.anthropic.com/news/claude-design-anthropic-labs) / [Get started with Claude Design (Help Center)](https://support.claude.com/en/articles/14604416-get-started-with-claude-design) / [Using Claude Design for prototypes and UX (公式チュートリアル)](https://claude.com/resources/tutorials/using-claude-design-for-prototypes-and-ux) / [TechCrunch](https://techcrunch.com/2026/04/17/anthropic-launches-claude-design-a-new-product-for-creating-quick-visuals/) / [VentureBeat](https://venturebeat.com/technology/anthropic-just-launched-claude-design-an-ai-tool-that-turns-prompts-into-prototypes-and-challenges-figma) / [The New Stack](https://thenewstack.io/anthropic-claude-design-launch/) / [Design プラグイン](https://claude.com/plugins/design)


## Claude Security 🧪
- **リリース状態**: 🧪 公開ベータ（2026-04-30〜）
- **対象プラン**: **Claude Enterprise**（Claude Team / Max は "coming soon"）
- **動作モデル**: **Claude Opus 4.7**
- **サーフェス**: claude.ai サイドバー or **claude.ai/security**
- **対応リポジトリ**: **GitHub ホスト**（GitLab / Bitbucket / self-hosted は未対応）
- **概要**: AI 駆動のコードベース脆弱性スキャン製品。**旧 "Claude Code Security" 研究プレビュー**（2026-02〜数百組織で運用）が公開ベータへ昇格・改称。**Claude Code から派生した最初の独立製品**で、Claude Code on Web との統合がコア
- **解析アプローチ**: パターンマッチではなく **reasoning 型** — セキュリティ研究者と同様にコンポーネント間の相互作用を理解、データフロー追跡、コード意図の reasoning。既存 SAST ツールが見逃した「decades-undetected」脆弱性を多数検出（先代 Opus 4.6 ベースで OSS production code 500+ vulnerabilities）
- **各 Finding の情報**: Confidence rating / Severity（High/Medium/Low、エクスプロイト容易性ベース）/ Likely impact / Reproduction path / Affected files & line numbers / Recommended patch
- **Multi-stage validation pipeline**: adversarial verification を経て初めて analyst に提示 → 誤検知大幅削減
- **公開ベータ機能**: Scheduled scans（週次など）、Documented dismissal（理由記録・監査証跡）、CSV/Markdown export、Slack/Jira webhook、Triage tracking、サブディレクトリ単位スコープ（モノレポ対応）、ブランチ指定スキャン
- **Claude Code 統合（重要）**: Finding を起点に **Claude Code on Web セッションを同じリポジトリコンテキストで起動**して直接パッチ開発可能。「セキュリティチームと開発チーム間の何日もの ping-pong を 1 セッションで完結」を主張
- **Cyber Safeguards 連携**: Opus 4.7 内蔵 cyber safeguards により高リスク用途は自動ブロック → Cyber Verification Program で正当な防御目的研究の継続利用パスあり
- **Tech Partners（Opus 4.7 を自社製品に組み込み）**: CrowdStrike（Falcon Platform / Project QuiltWorks）、Microsoft Security、Palo Alto Networks、SentinelOne、TrendAI、Wiz
- **Services Partners（顧客導入支援）**: Accenture、BCG、Deloitte、Infosys、PwC
- **顧客引用**: "Claude Security surfaced novel, high-quality findings...that helped us identify and address potential security issues" — Snowflake staff engineer
- **Mythos との関係**: Mythos Preview は Project Glasswing で限定配布継続、Claude Security は Opus 4.7 駆動で広く Enterprise に提供（"supervised vulnerability discovery without Mythos access"）
- **情報源**: [Claude Security 公式ページ](https://claude.com/product/claude-security) / [Claude.com Blog - public beta](https://claude.com/blog/claude-security-public-beta) / [SiliconANGLE](https://siliconangle.com/2026/04/30/anthropic-announces-claude-security-public-beta-find-fix-software-vulnerabilities/) / [The New Stack](https://thenewstack.io/anthropics-claude-security-beta/) / [SecurityWeek](https://www.securityweek.com/anthropic-unveils-claude-security-to-counter-ai-powered-exploit-surge/) / [Implicator](https://www.implicator.ai/anthropic-opens-claude-security-beta-as-mythos-access-fight-deepens/) / [調査レポート](reports/2026-05-01_claude-security-public-beta-and-50b-funding.md)

## Cyber Verification Program 📢
- **リリース状態**: 📢 受付開始（2026-04-30〜）
- **概要**: **Claude Opus 4.7 内蔵の cyber safeguards** に正当な防御目的のセキュリティ研究がブロックされる組織向けの **vetting（資格認定）プログラム**。通過後は restricted version での継続利用が可能
- **対象**: セキュリティリサーチャー、ペネトレーションテスト実施者、レッドチーミング、CTF チーム、脆弱性研究機関
- **第一陣参加組織**: TrendAI（4/30 PRNewswire 発表）。CrowdStrike / Wiz など他 Technology Partners も同枠での運用と推察
- **背景**: Opus 4.7 GA（2026-04-16）以降、cyber safeguards が "prohibited or high-risk cybersecurity uses" を自動検出・ブロックする仕様。Claude Security 公開ベータと同時に正式発表
- **情報源**: [TrendAI™ and Anthropic Advance AI-Powered Vulnerability Detection (2026-04-30)](https://www.prnewswire.com/news-releases/trendai-and-anthropic-advance-ai-powered-vulnerability-detection-and-risk-mitigation-with-claude-opus-4-7--302759231.html) / [CrowdStrike - Claude Opus 4.7 Across Falcon Platform](https://www.crowdstrike.com/en-us/press-releases/crowdstrike-puts-claude-opus-4-7-to-work-across-falcon-platform-project-quiltworks/) / [Palo Alto Networks - AI-Driven Defense](https://www.paloaltonetworks.com/blog/2026/04/ai-driven-defense-anthropics-claude-opus/)

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

### v2.1.116（2026年4月20日）
- **sandbox auto-allow が dangerous-path safety check をバイパスする問題を修正**: `rm`/`rmdir` が `/`、`$HOME`、その他クリティカルなシステムディレクトリを対象とする場合、サンドボックス auto-allow でも危険パス保護を強制適用

### v2.1.113（2026年4月17日）
- **`Bash` `dangerouslyDisableSandbox` サンドボックスバイパス**: パーミッションプロンプトなしにサンドボックス外で任意コマンド実行していた問題を修正
- **Bashツールのコメント先頭複数行コマンド UIスプーフィング**: 1行目がコメントの複数行コマンドがトランスクリプトで一部しか表示されず、コマンド偽装が可能だった問題を修正（全文表示に）
- **macOS `/private/{etc,var,tmp,home}` を危険削除ターゲット扱い**: `Bash(rm:*)` allow ルール下でも明示ブロック
- **Bash deny ルールの exec ラッパー対応**: `env`、`sudo`、`watch`、`ionice`、`setsid` 等でラップされたコマンドもマッチ
- **`Bash(find:*)` allow ルールで `find -exec` / `-delete` が自動承認されないように**: 破壊的find オプションの auto-approve 回避
- **`sandbox.network.deniedDomains`** 設定追加: 広い `allowedDomains` より優先される個別ドメインブロック

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

### Claude.ai/API/Code大規模障害（2026年4月15日）✅ 解決済み
- 10:53 AM ETに障害確認。11:03 AM ETに一時修正後、11:40 AM ETに再発。1:42 PM ETに完全解決（約3時間）
- Claude.ai、Claude API、Claude Codeの全サービスに影響。ログイン障害、チャット中断、使用制限表示不具合
- 15,000件超のユーザー報告。既存ログインセッションは継続可能だが、新規ログインは不可
- Anthropicはユーザー需要の急増を原因として説明（3月〜4月にかけて繰り返す障害パターン）
- **情報源**: [CNBC](https://www.cnbc.com/2026/04/15/anthropic-outage-elevated-errors-claude-chatbot-code-api.html) / [TechRadar](https://www.techradar.com/news/live/claude-anthropic-down-outage-april-15-2026)

### Claude.ai/API/Code Major Outage（2026年4月28日）✅ 解決済み
- **発生**: 17:34 UTC（10:34 PT / 13:34 ET）／ **解決**: 18:52 UTC（11:52 PT / 14:52 ET）／ **継続時間**: 約 **78 分**
- **重要度**: 🔴 Major Outage（status.claude.com 上で正式分類）
- **影響範囲**: Claude.ai / Anthropic API / **Claude Code（ログイン経路）**
- **症状**: Claude.ai ログイン認証エラー、API elevated error rate、Claude Code ログイン経路でも失敗
- **規模**: Downdetector に **12,000 件超**のユーザー報告
- **同日の関連インシデント**:
  - **Claude Sonnet 4.5 elevated errors**（13:22–13:39 UTC、17 分、Partial Outage）
  - **Claude Haiku 4.5 elevated errors**（11:53–12:44 UTC、51 分、Partial Outage）
  - **Claude Code Code Review intermittently failing**（解決時刻 06:00 UTC、Partial Outage） — Code Review セッションが断続的に開始しない
- **位置づけ**: 4 月の Anthropic Major クラス障害は **4/15（約 3 時間）→ 4/20 → 4/25（Opus 4.7 連続障害）→ 4/28** で **4 件目**。CoreWeave 提携・Google/Broadcom TPU 拡張などキャパシティ強化を進めているが、Claude Code/Cowork 採用拡大（NEC 30,000 人、Freshfields 5,700 人など大規模デプロイ続出）に追いついていない可能性
- **情報源**: [Tom's Guide Live](https://www.tomsguide.com/ai/live/claude-april-28-2026) / [Rolling Out](https://rollingout.com/2026/04/28/anthropic-claude-outage-users-locked-out/) / [GV Wire](https://gvwire.com/2026/04/28/claude-ai-goes-down-for-thousands-of-users-tuesday-downdetector-shows/) / [Claude Status](https://status.claude.com/)

### Claude.ai/API Major Outage（2026年4月30日）✅ 解決済み
- **発生**: 13:10 UTC（06:10 PT、12:48 PT 開始ともされる）「**claude.ai and API unavailable**」investigating ステータス
- **同時障害**: 14:01 UTC「**Claude Haiku 4.5 elevated errors**」investigating 開始
- **重要度**: 🔴 Major Outage クラス（claude.ai + API 完全 unavailable）
- **Claude Code 影響**: ログイン経路（Anthropic OAuth）依存のため認証障害発生想定
- **位置づけ**: 4 月の Major クラス障害は **4/15（約 3 時間）→ 4/20 → 4/25（Opus 4.7 連続障害）→ 4/28（約 78 分）→ 4/30** で **5 件目**。Partial / Elevated 含めると 4 月で 12 件超
- **背景**: CoreWeave 提携・Google/Broadcom TPU 拡張・$50B 調達でキャパシティ強化を進めるが、Freshfields（5,700 人）・NEC（30,000 人）・Goldman Sachs など大規模エンタープライズデプロイの加速に追いついていない構造的供給逼迫が継続
- **情報源**: [Claude Status](https://status.claude.com/) / [DesignTAXI - Is Claude Down? April 29, 2026](https://community.designtaxi.com/topic/27733-is-claude-anthropic-ai-down-april-29-2026)

### Claudeパフォーマンス低下問題・ユーザー反発（2026年2月後半〜4月報道）
- Anthropicがデフォルトの努力レベルをmediumに引き下げ（トークン節約目的）、ユーザーへの透明な通知なし
- Stella Laurenzo（AMD AI部門SD）が6,852セッション分析で67%パフォーマンス低下を文書化。Microsoft研究者も同様の批判
- Boris Cherny（Claude Code責任者）がTeam/Enterpriseのデフォルトをhighに変更テスト中と認める。v2.1.94でmedium→highに対応済み
- IPO（$30B超ARR）を控え、透明性ブランドへの影響が懸念される
- **情報源**: [Fortune](https://fortune.com/2026/04/14/anthropic-claude-performance-decline-user-complaints-backlash-lack-of-transparency-accusations-compute-crunch/) / [VentureBeat](https://venturebeat.com/technology/is-anthropic-nerfing-claude-users-increasingly-report-performance) / [The Register](https://www.theregister.com/2026/04/13/claude_outage_quality_complaints/)

### Freshfields × Anthropic 複数年 AI 提携（2026-04-23）
- **国際法律事務所 Freshfields** が Anthropic と複数年協業・共同開発・全社導入合意を公式発表
- **規模**: **33 拠点・全プラクティスグループ・ビジネスサービスに Claude を firmwide デプロイ**、すでに **5,700 人の従業員** に提供開始済み、提供開始後 6 週間で Claude 利用量約 **500% 増**
- **共同開発プログラム**: AI 法務ワークフロー・agentic ワークフローの共同設計、**次世代モデル・ツールへの early access** を Freshfields が取得
- **Cowork 展開予定**: セキュリティ・コンプライアンス・トレーニングフレームワーク整合後に Cowork（Anthropic の agentic AI プラットフォーム）への拡大を計画
- **市場インパクト**: RELX（LexisNexis 親会社）**株価が下落**。Harvey × OpenAI / Thomson Reuters CoCounsel / LexisNexis Protégé の既存法律 AI 競合からの移行を示唆
- **情報源**: [Businesswire 公式プレス](https://www.businesswire.com/news/home/20260423837690/en/Freshfields-and-Anthropic-Team-Up-to-Co-Build-AI-Legal-Workflows-Deploying-Claude-Across-the-Firm-Globally) / [Law.com](https://www.law.com/legaltechnews/2026/04/23/freshfields-announces-anthropic-deal-deploys-claude-firmwide/) / [The Lawyer - Landmark AI Deal](https://www.thelawyer.com/freshfields-strikes-landmark-ai-deal-with-anthropic/) / [Investing.com - RELX 株価下落報道](https://www.investing.com/news/stock-market-news/relx-stock-falls-as-anthropic-partners-with-freshfields-on-legal-ai-93CH-4632084)

### Anthropic $50B 調達ラウンド協議中・評価額 $850-900B（2026-04-29 Bloomberg/TechCrunch スクープ）
- **報道日**: 2026-04-29（Bloomberg / TechCrunch 同日独立スクープ）
- **ラウンド規模**: **$40-50B**（推定）
- **ポストマネー評価額**: **$850-900B**（前回 2026-02 ラウンド $380B から **約 2.4 倍**）
- **取締役会決定予定**: **2026 年 5 月**
- **候補 IPO 時期**: **2026 年 10 月**。**IPO 主幹事候補**: Goldman Sachs / JPMorgan / Morgan Stanley が早期協議中
- **ARR**: $30B+（一部ソースは $40B 近辺、2025 年末の $9B から大幅増）。**エンタープライズ売上比率約 80%**
- **OpenAI 比較**: OpenAI の 2026-02 ポストマネー $852B を **Anthropic が抜く可能性**
- **投資家動向**: 1 機関投資家が $5B コミット予定で CFO Krishna Rao への面会待ち。Anthropic は公式コメント拒否
- **成長ドライバー**: ① Claude Code / Cowork、② Mythos 関連需要（連邦機関 + Project Glasswing 12 創設パートナー + 40+ 重要インフラ組織）、③ Sonnet 4.6 / Opus 4.7 アダプション、④ Freshfields・NEC・Goldman Sachs・Snowflake など大型エンタープライズ採用
- **Claude Code への含意**: 評価額急騰は Claude Code・Cowork の収益貢献度を裏付け。10 月 IPO 候補の公表により 4/13 TradingKey 報道（IPO 噂、$380B 目標）が大幅上方修正。4/22 The Register 報道「Pro 試験的 Claude Code 削除」「Pro Opus 4.7 セッション 3 倍化」が背景の Pro/Max プラン構成見直し圧力につながる可能性
- **情報源**: [Bloomberg - Over $900 Billion Valuation (2026-04-29)](https://www.bloomberg.com/news/articles/2026-04-29/anthropic-considering-funding-offers-at-over-900-billion-value) / [TechCrunch - $50B Round at $900B (2026-04-29)](https://techcrunch.com/2026/04/29/sources-anthropic-could-raise-a-new-50b-round-at-a-valuation-of-900b/) / [TheNextWeb](https://thenextweb.com/news/anthropic-900-billion-valuation-funding-round) / [The AI Insider](https://theaiinsider.tech/2026/04/30/anthropic-nears-50b-raise-at-up-to-900b-valuation-ahead-of-potential-ipo/) / [TechFundingNews](https://techfundingnews.com/anthropic-50b-round-900b-valuation-ipo-report/)

### Claude Code on Pro 試験的削除事件（2026-04-21〜22 発生、48 時間以内に撤回）
- **経緯**: 2026-04-21 に無告知で Anthropic の pricing ページから Pro プラン（$20/月）の Claude Code 項目が削除、Help Center 記事タイトルと landing も更新。2026-04-22 に head of growth が「新規 prosumer signup の約 2% に対する小規模 A/B テスト」「既存 Pro/Max subscribers は影響なし」とコメントし、**pricing・docs の表記変更を revert**
- **原因**: Opus 4.7 以降、**Pro ユーザーのセッションが Opus 4.6 比で最大 3 倍長時間化**しバックグラウンドで自動ワークフローが何時間も回るケースが頻発、現行 Pro プラン上限が想定外の負荷に
- **実装ミス**: 2% A/B テストのつもりが **Web 全面更新**してしまい「グローバル変更」に見えた。Simon Willison など開発者コミュニティから混乱と信頼性への疑念が指摘
- **現状**: 恒久削除は未定。既存ユーザーは影響なし。Claude Code 単独プランや段階プラン（Claude Code Max 相当）の可能性が業界内で議論開始
- **情報源**: [The Register - Anthropic tests reaction to yanking Claude Code from Pro (2026-04-22)](https://www.theregister.com/2026/04/22/anthropic_removes_claude_code_pro/) / [The New Stack](https://thenewstack.io/anthropic-claude-code-limits/) / [Simon Willison - Is Claude Code going to cost $100/month? Probably not (2026-04-22)](https://simonwillison.net/2026/Apr/22/claude-code-confusion/) / [Heise Online](https://www.heise.de/en/news/Anthropic-is-temporarily-removing-Claude-Code-from-the-Pro-tariff-11268189.html)

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
- **2026年4月17日**: Dario Amodei CEOがホワイトハウス首席補佐官Susie Wiles、財務長官Scott Bessentと面会。紛争解消に向けた交渉が本格化
- **2026年4月17日**: ホワイトハウスが国防総省の反対を押し切り、米連邦機関（CISA、財務省、インテリジェンスコミュニティ）にMythosアクセス認可（Bloomberg/Axios報道）
- **2026年4月19日（Axiosスクープ）**: **NSA（国家安全保障局）がMythosを実利用中**と判明。主にNSA自身の環境に対する脆弱性スキャン用途。**Pentagon配下の情報機関がブラックリスト対象企業と取引する構造的矛盾**が明確化
- **2026年4月18日（RedState報道）**: 商務省 **AI標準化イノベーションセンター**、**エネルギー省**、**財務省金融システム保護部門**、**CISA** も Mythos を評価・利用中。行政府内で事実上の "de facto 解禁" 進行
- **2026年4月19日（Trending Topics）**: **英国MI5（情報局保安部）が UK AI Safety Institute 経由でMythosアクセスを取得**
- **2026年4月21日（Axiosスクープ）**: **CISA は実際には Mythos へのアクセスを保有していない** と判明。Anthropic は Mythos を一般公開せず 40 社超の企業・組織に限定配布中だが、CISA はこのリストに含まれない。Trump 政権下で CISA の能力・予算が縮小されてきた文脈。**4/17 Bloomberg の「OMB が CISA 等への Mythos 認可プロトコル整備」報道を実態面で訂正**。重要インフラ防衛機関が AI 駆動サイバー攻撃対策ツールを持てない状況が浮上
- **2026年4月21日（CNBC インタビュー）**: **Trump が国防総省との Anthropic 合意は "possible" と発言**、「shaping up している」として 2 月の連邦機関利用停止指令から態度軟化。4/18 に Amodei が Susie Wiles 首席補佐官・Scott Bessent 財務長官と面会した直後。TheNextWeb 追加報道: White House OMB（連邦 CIO Gregory Barbaccia）が **連邦機関への Mythos controlled version アクセスプロトコルを整備中**。焦点は「完全自律兵器・国内大規模監視への利用制限」vs Pentagon の「あらゆる合法目的でのアンフェッタードアクセス」要求
- **2026年4月30日（Bloomberg / WSJ スクープ）**: **White House が Anthropic の Mythos 拡大計画（50 → 120 社、+70 社）を阻止** — 国家安全保障 + コンピュート可用性懸念。連邦機関方向への利用拡大（NSA / 商務省 AI 標準化センター / エネルギー省 / 財務省金融システム保護部門）は継続するが、民間（Project Glasswing 参加企業の追加）拡大のみ阻止という二重姿勢。同時期に **non-authorized users が private online forum で Mythos アクセスを取得した breach** も判明（resultsense 5/1）→ controlled-access モデルの限界露呈。**情報源**: [Bloomberg (4/30)](https://www.bloomberg.com/news/articles/2026-04-30/white-house-opposes-anthropic-plan-for-mythos-access-wsj-says) / [Sherwood](https://sherwood.news/tech/white-house-nixes-anthropic-plan-to-expand-mythos-access-to-more-companies/) / [Gateway Pundit](https://www.thegatewaypundit.com/2026/05/trump-administration-fights-anthropics-plan-expand-mythos-ai/) / [Blockonomi](https://blockonomi.com/trump-administration-halts-anthropics-mythos-ai-expansion-plans-over-security-fears/) / [TheNextWeb](https://thenextweb.com/news/white-house-opposes-anthropic-mythos-expansion)
- **2026年4月30日（Senate Armed Services Committee 公聴会）**: **Defense Secretary Pete Hegseth が Anthropic CEO Dario Amodei を「ideological lunatic」と呼称** — Senator Jacky Rosen (D-NV) からの追及（Anthropic セキュリティラベル指定について）への応答。Hegseth 発言: **"Anthropic is run by an ideological lunatic who shouldn't have a sole decision-making over what we do"**（直前 Iran 戦争・FY2027 予算 $1.45T を中心に証言）。AI による致死的標的決定はさせていないと主張、Anthropic の mass surveillance / 完全自律兵器拒否ポリシーを批判。**5/1 Pentagon 7社+Oracle 契約発表の前日**に発言、White House の和解交渉路線（4/29 Axios「Trump officials draft plan to bring Anthropic back」、4/28「White House drafts guidance to bypass Anthropic's risk flag」）と矛盾 → Pentagon-White House の温度差を再強調。**Pentagon Defense Secretary が AI ベンダー CEO を公聴会で公然と名指し批判するのは極めて稀**。Anthropic は公式コメントなし（CNBC への引用拒否継続）。**情報源**: [Bloomberg (4/30)](https://www.bloomberg.com/news/articles/2026-04-30/hegseth-calls-amodei-a-lunatic-and-defends-pentagon-use-of-ai) / [Axios (5/1)](https://www.axios.com/2026/05/01/washington-new-anthropic-problem) / [BGov](https://news.bgov.com/bloomberg-government-news/hegseth-calls-amodei-a-lunatic-and-defends-pentagon-use-of-ai) / [YouTube](https://www.youtube.com/watch?v=Zp3wcnKGCMo) / [Let's Data Science (Rosen-Hegseth)](https://letsdatascience.com/news/rosen-confronts-hegseth-over-anthropic-security-label-1befedaf)
- **2026年5月1日**: **Pentagon が classified network 内 AI 契約を 7 社（Google / OpenAI / Nvidia / Microsoft / AWS / SpaceX-xAI / Reflection）+ Oracle で計 8 社と締結、Anthropic は除外継続**。**DoD CTO Emil Michael が CNBC インタビューで「Anthropic はサプライチェーンリスクのまま、Mythos は別件として評価」と明言** — Trump の 4/21 "deal possible" 発言の 10 日後にも関わらず除外決定 → ホワイトハウスと Pentagon の温度差が顕在化。背景: 2025-07 $200M 契約に「自律兵器・大規模国内監視への利用禁止」条項あり、2025 末〜2026 初頭の再交渉で同条項撤廃要求 → Anthropic が譲歩拒否 → 2026-02 サプライチェーンリスク指定 → 2026-03 Defense Secretary Pete Hegseth「いかなる contractor / supplier / partner も Anthropic と取引禁止」通達 → 連邦判事の差止め命令で通達効力停止中、控訴審係争中。**Mythos の "別枠評価" は NSA / 商務省 / エネルギー省での実利用と整合し、Mythos 個別解禁トラックの形成中**を裏付ける。Anthropic は CNBC への引用拒否（公式声明なし）。**情報源**: [DefenseNews (2026-05-01)](https://www.defensenews.com/news/pentagon-congress/2026/05/01/pentagon-freezes-out-anthropic-as-it-signs-deals-with-ai-rivals/) / [CNBC (2026-05-01)](https://www.cnbc.com/2026/05/01/pentagon-anthropic-blacklist-mythos-michael.html) / [SiliconANGLE (2026-05-01)](https://siliconangle.com/2026/05/01/pentagon-inks-ai-procurement-deals-seven-companies-leaves-anthropic/) / [DefenseScoop](https://defensescoop.com/2026/05/01/dod-expands-classified-ai-work-with-8-companies-excluding-anthropic/) / [CNN Business](https://www.cnn.com/2026/05/01/tech/pentagon-ai-anthropic)
- **Claude Code / Claude製品への直接的な影響は現時点ではなし**。控訴審の結果および Trump 発言の具体化次第で米政府機関・防衛関連企業の利用に影響の可能性。ただし短期的には**連邦機関のAnthropicツール利用は拡大方向、かつ和解交渉が進行中**
- **情報源**: [Axios - CISA doesn't have access to Mythos (2026-04-21)](https://www.axios.com/2026/04/21/cisa-anthropic-mythos-ai-security) / [CNBC - Trump says deal is 'possible' (2026-04-21)](https://www.cnbc.com/2026/04/21/trump-anthropic-department-defense-deal.html) / [TheNextWeb - Trump says Pentagon deal is 'possible'](https://thenextweb.com/news/trump-anthropic-pentagon-deal-possible-mythos) / [Axios - NSA using Mythos despite blacklist (2026-04-19)](https://www.axios.com/2026/04/19/nsa-anthropic-mythos-pentagon) / [Axios - White House peace talks (2026-04-17)](https://www.axios.com/2026/04/17/anthropic-trump-administration-mythos) / [RedState - Federal Agencies Are Using It Anyway (2026-04-18)](https://redstate.com/ben-smith/2026/04/18/pentagon-blacklisted-anthropic-federal-agencies-are-using-it-anyway-n2201421) / [Trending Topics - NSA Already Uses Mythos (2026-04-19)](https://www.trendingtopics.eu/nsa-already-uses-anthropics-most-powerful-ai-model-myhtos-despite-pentagon-ban/)

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

### The Briefing: Financial Services（5/5 livestreamed event） 📢
- **確度**: 📢 公式アナウンス済み（Anthropic events ページに掲載）
- **日時**: 2026-05-05（Tuesday）11:00 AM – 12:30 PM EST
- **会場**: Virtual（livestreamed from New York City）
- **対象**: CIO / CTO / COO / Chief Data Officer / Innovation heads at financial institutions
- **内容**: Anthropic C-suite executives + 主要金融機関リーダー登壇。「Anthropic's vision for AI in finance」、デプロイ実例、**新製品機能発表とライブデモ**
- **登録**: クローズ済み、livestream のみ公開
- **情報源**: [Anthropic Events](https://www.anthropic.com/events/the-briefing-financial-services-virtual-event)
- **文脈**: 2025-11 Anthropic Financial Services Plugins、2026-04-10 FRB Powell + 財務長官 Bessent + 米主要銀行 CEO の Mythos AI サイバー脅威協議、4/13 Wall Street Banks Mythos トライアル、4/29 $50B/$900B 調達ラウンド（Goldman Sachs / JPMorgan / Morgan Stanley が IPO 主幹事候補）の流れ。**Anthropic の金融セクター戦略明示の場**として注目度高い、IPO ロードショーの一環の可能性
- **最終確認日**: 2026-05-03

### Code with Claude SF（5/6 main, 5/7 Extended） 📢
- **確度**: 📢 公式アナウンス済み（[Anthropic 公式ブログ 2026-03-18](https://claude.com/blog/code-with-claude-san-francisco-london-tokyo) で正式告知、`claude.com/code-with-claude` にランディングページあり）。**前回 5/3 レポートでは「❓ 5/6 Anthropic Developer Event」として噂扱いしていたが、claude.com 配下の公式 events 系ページを確認していなかった調査ミスを訂正、📢 へ昇格**
- **日時**: **2026-05-06（Wed）8:00 AM–8:00 PM PT**（Main Day、SF）／**2026-05-07（Thu）Code with Claude: Extended SF**（インディ開発者・スタートアップファウンダー向け companion event）
- **形式**: In-person + Livestream 配信併用、**いずれも参加無料**。In-person はランダム選抜、申込は **2026 年 4 月初旬で締切済み**。Livestream は引き続き登録可能（[`claude.com/code-with-claude/register-livestream`](https://claude.com/code-with-claude/register-livestream)）
- **3 都市開催**: SF（5/6 main + 5/7 Extended）/ London（5/19 main + 5/20 Extended）/ Tokyo（6/10 main + 6/11 Extended）
- **タイムテーブル（SF, PT）**: 9:00–10:00 AM **Opening Keynote**（Anthropic Leadership 登壇） / 10:30 AM–12:30 PM Morning Sessions（3 トラック並走）/ 12:30 PM–6:15 PM Afternoon Workshops & Talks / 5:45 PM–8:00 PM Evening Reception
- **3 トラック**: ① **Research**（モデル能力・将来ロードマップ）/ ② **Claude Platform**（production-grade agents 構築）/ ③ **Claude Code**（long-horizon・multi-repo・並列エージェント・運用インフラ）
- **主要登壇者（Anthropic）**: **Ami Vora**（CPO）/ **Boris Cherny**（Head of Claude Code）/ **Cat Wu**（Product Lead, Claude Code）/ **Angela Jiang**（Product Lead, Claude Platform）/ **Dianne Penn**（Head of Product, Research）。**外部スピーカー所属**: Netflix / GitHub / Datadog / Cursor / Vercel
- **新機能発表予告**: 公式ブログ・ランディングページ双方で**「live demos of the latest capabilities」「demos of new capabilities and conversations with the teams behind Claude」と明記**。新製品機能のライブデモが公式予告されている → **Sonnet 4.8 / Claude Jupiter / KAIROS / Computer Use ベータ昇格 / Routines GA 化** などのリーク・予測候補のうちいずれか or 複数が発表される蓋然性が高い（個別具体は ❓ 噂のまま）
- **情報源**: [Code with Claude（公式）](https://claude.com/code-with-claude) / [San Francisco 詳細](https://claude.com/code-with-claude/san-francisco) / [公式ブログ 3/18](https://claude.com/blog/code-with-claude-san-francisco-london-tokyo) / [Tokyo](https://claude.com/code-with-claude/tokyo) / [EventBrowse](https://eventbrowse.com/event/anthropic-code-with-claude-sf-2026/) / [TestingCatalog (X)](https://x.com/testingcatalog/status/2034426076663828529)
- **最終確認日**: 2026-05-04

### Claude for Nonprofits ウェビナー（5/6） 📢
- **確度**: 📢 公式アナウンス済み（Anthropic 公式 webinars ページ）
- **日時**: 2026-05-06（Wed）10:00 AM PT
- **内容**: タイトル「Moving Your Workflow Beyond Chat」。**Projects / Skills / Connectors を非開発者向けに実演**、grant writing を Chat → Project → Skill → Connector の順で同じ入力に通し、各段階で何が変わるかを解説。calendar 招待・24h 前リマインダー・48h 後録画リンク提供
- **対象**: 非営利セクター利用者
- **情報源**: [Claude for Nonprofits Webinar（公式）](https://www.anthropic.com/webinars/claude-for-nonprofits-moving-your-workflow-beyond-chat) / [Anthropic Events](https://www.anthropic.com/events)
- **最終確認日**: 2026-05-04

### Claude for Financial Services: Putting agents to work（5/7 ウェビナー） 📢
- **確度**: 📢 公式アナウンス済み（Anthropic 公式 events ページに掲載）
- **日時**: 2026-05-07（Thu）
- **位置づけ**: **5/5 The Briefing: Financial Services（C-suite 向け）の翌々日**、より実装よりのウェビナー形式で「金融機関でエージェントを実運用する」フォーカス。Briefing → Code with Claude SF → 本ウェビナーで金融セクター向け 3 連続コミュニケーション
- **情報源**: [Anthropic Events](https://www.anthropic.com/events)
- **最終確認日**: 2026-05-04

### Anthropic IPO計画（2026 年 10 月候補） ❓
- **確度**: ❓ 噂・未確認（**Bloomberg / TechCrunch ファイナンススクープ**で具体性大幅向上、ただし正式発表前）
- **情報源**: [Bloomberg (2026-04-29)](https://www.bloomberg.com/news/articles/2026-04-29/anthropic-considering-funding-offers-at-over-900-billion-value) / [TechCrunch (2026-04-29)](https://techcrunch.com/2026/04/29/sources-anthropic-could-raise-a-new-50b-round-at-a-valuation-of-900b/) / [TradingKey](https://www.tradingkey.com/analysis/stocks/us-stocks/261773210-ai-anthropic-claude-mythos-ipo-tradingkey)
- **概要**: 2026 年 10 月 IPO 候補。**直前ラウンド評価額が 2 月の $380B から $850-900B レンジへ大幅上方修正**（4/29 スクープ、5 月取締役会で決定見込み）。**主幹事候補**: Goldman Sachs / JPMorgan / Morgan Stanley が早期協議中。ARR $30B+（一部 $40B）、エンタープライズ 80%、Mythos 関連需要 + Claude Code / Cowork が主要成長ドライバー。OpenAI（$852B）を抜く可能性
- **最終確認日**: 2026-05-01

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

## 廃止予定・重要な変更スケジュール

| モデル/機能 | 発効日 | 移行先・備考 |
|------------|--------|--------|
| Claude Haiku 3 (`claude-3-haiku-20240307`) | **2026-04-19 発効済み** | Claude Haiku 4.5（API 呼び出しはエラー応答） |
| **API デフォルトモデル切替** | **2026-04-23** | **Enterprise pay-as-you-go・Anthropic API の `opus` エイリアスが Opus 4.6 → Opus 4.7 を指すように。モデルピンニング未設定の本番APIは事前検証必須**（[マイグレーションガイド](https://platform.claude.com/docs/en/about-claude/models/migration-guide#migrating-to-claude-opus-4-7)） |
| Sonnet 4.5/4 の1Mコンテキストベータ (`context-1m-2025-08-07`) | **2026-04-30 発効済み** | Sonnet 4.6 / Opus 4.6（1M GA、ベータヘッダー不要・サーチャージなし）。両モデルで silent fallback で 200K、200K 超リクエストはエラー |
| Claude Sonnet 4 (`claude-sonnet-4-20250514`) | 2026-06-15 | Claude Sonnet 4.6（4月14日廃止予告） |
| Claude Opus 4 (`claude-opus-4-20250514`) | 2026-06-15 | Claude Opus 4.6（4月14日廃止予告） |

---

## 更新履歴

- 2026-05-04: **ニュースモード調査**（新 CLI リリースなし、v2.1.126 継続最新）。**主要な訂正**: 前回 5/3 レポートで「❓ 5/6 Anthropic Developer Event（メディア予測のみ）」として「噂」扱いしていたイベントが、**実は 2026-03-18 に Anthropic 公式ブログで「Code with Claude SF/London/Tokyo」として正式アナウンス済み**だったことが判明。前回調査では `anthropic.com/events` のみ確認し `claude.com/code-with-claude` 配下の公式 events 系ページを見落としたのが原因 → **❓ 噂 → 📢 公式予告へステータス変更**。判明した詳細: ① **Code with Claude SF: 5/6（Wed）8 AM–8 PM PT、9-10 AM Opening Keynote、Claude Code/Platform/Research の 3 トラック**、登壇者 Ami Vora（CPO）/ Boris Cherny（Head of Claude Code）/ Cat Wu / Angela Jiang / Dianne Penn（Head of Product, Research）、外部スピーカー Netflix / GitHub / Datadog / Cursor / Vercel、In-person 申込締切済み・Livestream 無料登録継続、**「live demos of new capabilities」公式予告あり**。② **5/7 Code with Claude: Extended SF**（インディ開発者・スタートアップファウンダー向け）。③ 3 都市開催: London 5/19 main + 5/20 Extended、Tokyo 6/10 main + 6/11 Extended。**Layer 2 追加公式予告**: ④ **Claude for Nonprofits ウェビナー**（5/6 10:00 AM PT、Projects/Skills/Connectors を grant writing デモで実演）、⑤ **Claude for Financial Services: Putting agents to work ウェビナー**（5/7、エージェント実運用フォーカス、5/5 Briefing と合わせて金融セクター 3 連続コミュニケーション）。**結論: 5/5〜5/7 は Anthropic イベント連発週、特に 5/6 SF Keynote は新製品・新機能発表のメインステージとなる蓋然性が高い**（Sonnet 4.8 / Claude Jupiter / KAIROS / Computer Use ベータ昇格 / Routines GA 化などの個別具体は依然 ❓ 噂のまま、5/6 で動きがあれば次回更新）。**Layer 3 続報**: 5/3〜5/4 で Pentagon-Anthropic 関連・Mythos・$50B 調達ラウンドに新たな公的進展なし。CURRENT_FEATURES.md: 予定・未確認情報セクションで「Anthropic Developer Event（5/6 予測）❓」を「Code with Claude SF（5/6 main, 5/7 Extended）📢」へ昇格・置換、「Claude for Nonprofits ウェビナー（5/6）📢」「Claude for Financial Services: Putting agents to work（5/7 ウェビナー）📢」を新規追加（[調査レポート](reports/2026-05-04_code-with-claude-sf-officially-confirmed.md)）
- 2026-05-03: **ニュースモード調査**（新 CLI リリースなし、v2.1.126 継続最新）。Anthropic Newsroom / Platform Release Notes / Help Center も 5/1〜5/3 新規エントリなし。**Layer 3 重要続報（4/30〜5/2 報道、前回 5/2 レポート未捕捉）**: ① **Hegseth「ideological lunatic」発言**（4/30 Senate Armed Services Committee 公聴会） — Defense Secretary Pete Hegseth が Senator Jacky Rosen (D-NV) からの追及への応答で Anthropic CEO Dario Amodei を「ideological lunatic」と呼称、5/1 Pentagon 7社+Oracle 契約発表の前日、White House の和解交渉路線（4/29 Axios「Trump officials draft plan to bring Anthropic back」、4/28 Axios「White House drafts guidance to bypass Anthropic's risk flag」）と矛盾 → Pentagon-White House の温度差を再強調。② **White House による Mythos 拡大計画ブロック**（4/30 WSJ スクープ）— Anthropic の Mythos 拡大計画（50→120 社、+70 社）を阻止、国家安全保障 + コンピュート可用性懸念。連邦機関方向への利用拡大（NSA / 商務省 AI 標準化センター / エネルギー省 / 財務省金融システム保護部門）は継続、民間拡大のみ阻止という二重姿勢。同時期に non-authorized users が private online forum で Mythos アクセスを取得した breach も判明（resultsense 5/1）。**Layer 2 公式予告**: ③ **The Briefing: Financial Services 5/5 開催予告** — 11:00 AM – 12:30 PM EST、NYC livestream、CIO/CTO/COO/Chief Data Officer 対象、Anthropic C-suite 登壇、新製品機能発表とライブデモ予定。Application closed、livestream は anthropic.com/events で公開。**Layer 3 噂**: ④ メディア（NxCode/Fordel Pulse/AI Nexus Daily/Mfierce）が **5/6 Anthropic Developer Event** を予測、Sonnet 4.8 / Claude Jupiter 正式発表期待、根拠は 3/31 Claude Code ソースリーク内 `sonnet-4-8`/"Undercover Mode"/"Claude Jupiter v1" 言及 + Opus→Sonnet 1〜4 週間遅れパターン、**ただし公式 events ページに記載なし**。⑤ resultsense 5/1 サマリーで UK AI Safety Institute が GPT-5.5 をオフェンシブ・サイバー能力 Mythos 同等と評価との記述（一次ソース未確認）。CURRENT_FEATURES.md: DoD ブラックリストセクションに 4/30 Hegseth 発言・4/30 Mythos 拡大計画ブロックを追記、予定・未確認情報セクションに 5/5 Financial Services Briefing 📢 と 5/6 Developer Event ❓ を新規追加（[調査レポート](reports/2026-05-03_hegseth-lunatic-and-mythos-expansion-block.md)）
- 2026-05-02: **フルモード調査**。前回 5/1 ニュースモードで取りこぼした **v2.1.126（5/1 02:05 UTC リリース、約50項目の改善）** を反映。**Layer 1 CLI**: ① **`claude project purge [path]` 新コマンド** — プロジェクトの全 Claude Code 状態（トランスクリプト・スケジュールタスク・ファイル変更履歴・config エントリ）を一括削除、`--dry-run`/`-y`/`-i`/`--all` フラグ対応。② **`/model` ピッカーがゲートウェイ対応** — `ANTHROPIC_BASE_URL` 互換ゲートウェイの `/v1/models` から動的取得。③ **`--dangerously-skip-permissions` の挙動拡張** — `.claude/`/`.git/`/`.vscode/`/シェル設定への書き込みプロンプトもバイパス、危険削除は依然プロンプト維持。④ **`claude auth login` の WSL2/SSH/コンテナ対応** — OAuth コードのターミナル貼り付けサポート。⑤ **`claude_code.skill_activated` OpenTelemetry イベント拡張** — ユーザー入力スラッシュコマンドでも発火、`invocation_trigger` 属性 `"user-slash"`/`"claude-proactive"`/`"nested-skill"`。⑥ **PowerShell 7 検出強化**（Microsoft Store/MSI/.NET Global Tool）+ PowerShell プライマリシェル化。⑦ Auto Mode のスピナー赤化、画像 2,000px 超ペーストの自動ダウンスケール、ホスト管理デプロイメントのアナリティクス自動無効化廃止。**セキュリティ修正**: ⑧ `allowManagedDomainsOnly`/`allowManagedReadPathsOnly` の管理設定優先度回帰修正（`sandbox` ブロック不在時に高優先度 source で無視されていた）。**46+ バグ修正**: Mac スリープ後 "Stream idle timeout"、Windows no-flicker での日中韓文字化け、Ctrl+L、Cursor/VSCode 1.92-1.104 トラックパッド、Agent SDK 不正形式ツール名 hang、PowerShell `--%` 誤判定、Windows クリップボード EDR/SIEM テレメトリ漏洩、>22KB クリップボード未到達、API リトライ "0s" 停止、OAuth IPv6/プロキシ/競合状態など。**注**: v2.1.124/v2.1.125 は GitHub Releases に存在せず（404）スキップされた可能性。**Layer 3 重大スクープ（5/1）**: ⑨ **Pentagon が 7 社（Google/OpenAI/Nvidia/Microsoft/AWS/SpaceX-xAI/Reflection）+ Oracle で計 8 社と classified network 内 AI 契約締結、Anthropic 除外継続**。DoD CTO Emil Michael「Anthropic はサプライチェーンリスクのまま、Mythos は別件として評価」と CNBC で明言 — Trump 4/21 "deal possible" 発言の 10 日後にも関わらず除外決定 → ホワイトハウスと Pentagon の温度差顕在化。Mythos の "別枠評価" は NSA/商務省/エネルギー省での実利用と整合し、Mythos 個別解禁トラック形成中を裏付け。Anthropic は CNBC への引用拒否（公式声明なし）（[調査レポート](reports/2026-05-02_v2.1.126-and-pentagon-ai-deals.md)）
- 2026-05-01: **ニュースモード調査**（新 CLI リリースなし、v2.1.123 継続最新）。**Layer 2 公式（4/30）**: ① **Claude Security 公開ベータ開始** — 旧 "Claude Code Security" 研究プレビュー（2026-02〜数百組織で運用）が **Claude Enterprise** 向け公開ベータへ昇格。Opus 4.7 駆動、`claude.ai/security`、GitHub ホストリポジトリ対応、reasoning 型解析（パターンマッチではなくデータフロー追跡）、Confidence/Severity/Impact/Reproduction、multi-stage validation pipeline、scheduled scans、CSV/Markdown export、Slack/Jira webhook、**Claude Code on Web セッションへ直接遷移してパッチ開発**。Tech partners: CrowdStrike / Microsoft Security / Palo Alto Networks / SentinelOne / TrendAI / Wiz。Services partners: Accenture / BCG / Deloitte / Infosys / PwC。Team/Max は "coming soon"。② **Cyber Verification Program** — Opus 4.7 cyber safeguards に正当な防御目的研究がブロックされる組織向け vetting プログラム、TrendAI が第一陣参加。**Layer 3（4/29 Bloomberg/TechCrunch スクープ）**: ③ **Anthropic が $50B 規模の調達ラウンドを協議中、評価額 $850-900B** — 2 月の $380B から **約 2.4 倍**、ARR $30B+（一部 $40B）、エンタープライズ 80%、5 月取締役会決定見込み、10 月 IPO 候補、Goldman Sachs / JPMorgan / Morgan Stanley が IPO 主幹事候補。**Layer 2 障害（4/30）**: ④ Major クラス障害（13:10 UTC〜、claude.ai + API unavailable + Haiku 4.5 elevated errors） — 4 月 Major 障害は 4/15・4/20・4/25・4/28 に続く 5 件目。Anthropic Newsroom は 4/28「Claude for Creative Work」が最新エントリで、Claude Security 発表は claude.com/blog プロダクトページ経由のみ Newsroom 未掲載（[調査レポート](reports/2026-05-01_claude-security-public-beta-and-50b-funding.md)）
- 2026-04-30: **フルモード調査**。**Layer 1 CLI**: ① **v2.1.123（4/29 03:29 UTC）** — `CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1` 設定下で OAuth が 401 → retry → 401 を繰り返す retry loop fix 1 件のみのホットフィックス。v2.1.121-122 で導入された claude.ai connector OAuth フロー強化（`mcp_authenticate` の `redirectUri` 対応 / Microsoft 365 MCP OAuth 修正）の副作用と推察。**4/28-29 で v2.1.121 → v2.1.122 → v2.1.123 と約 27 時間で 3 リリース連続展開**。**Layer 2（4/30 発効）**: ② **Sonnet 4.5 / Sonnet 4 の 1M context window beta retirement 発効**（`context-1m-2025-08-07` ヘッダー無効化、両モデルで silent fallback で 200K、200K 超リクエストはエラー、移行先は Sonnet 4.6 / Opus 4.6 — 1M GA・標準価格・サーチャージなし）。**Layer 3（4/29 FT スクープ）**: ③ **Goldman Sachs が Hong Kong 拠点バンカーの Anthropic Claude アクセスを遮断** — Anthropic との契約厳格解釈の結果、Hong Kong は Anthropic 公式の API/Claude.ai 利用可能リージョンリスト未掲載が背景。Gemini・ChatGPT は引き続き利用可能で Anthropic 製品固有の制限。米中 AI tension コンテキスト、Hong Kong 拠点 Claude Code 運用組織は Anthropic 利用規約上の準拠リスク再評価が必要。**Layer 2 障害（4/29）**: ④ Haiku 4.5 elevated errors（05:37-06:58 PT、81 分）、⑤ Opus 4.7 elevated errors（16:25-16:33 PT、8 分）— 4 月 Major クラス障害は 4/15・4/20・4/25・4/28 の 4 件、Partial/Elevated 含めると 10 件超。Anthropic Newsroom / Help Center / Platform Release Notes は 4/29-30 新規エントリなし（[調査レポート](reports/2026-04-30_v2.1.123-and-goldman-hong-kong.md)）
- 2026-04-29: **フルモード調査**（前回 4/28 ニュースモードで Layer 1 をスキップしたため、4/28 の 2 連続 CLI リリースを今回反映）。**Layer 1 CLI**: ① **v2.1.121（4/28 00:31 UTC）** — MCP `alwaysLoad` server config（tool-search 遅延ロードをスキップ）、`claude plugin prune`（orphaned 依存削除、`uninstall --prune` カスケード）、`/skills` type-to-filter 検索、PostToolUse hooks の `updatedToolOutput` が全ツール対応、フルスクリーンスクロール固定改善、オーバーフローダイアログのスクロール、`--dangerously-skip-permissions` の `.claude/skills/`/`.claude/agents/`/`.claude/commands/` 保護、メモリリーク 3 件 fix（多数画像/`/usage`/長時間ツール）、`/terminal-setup` で iTerm2 clipboard、claude.ai connectors 重複排除、Vertex X.509 mTLS、SDK `mcp_authenticate` の `redirectUri`、OpenTelemetry に `stop_reason`/`gen_ai.response.finish_reasons`/`user_system_prompt`、`CLAUDE_CODE_FORK_SUBAGENT=1` 外部ビルド対応、Microsoft 365 MCP OAuth 修正、Bash ツール起動ディレクトリ削除問題修正、`--resume` 堅牢化、tmux/GNOME/Konsole scrollback 重複修正、VSCode 音声/ネイティブ `/context`、LSP diagnostic 展開など 39 項目。② **v2.1.122（4/28 22:05 UTC）** — `ANTHROPIC_BEDROCK_SERVICE_TIER` 環境変数（`default`/`flex`/`priority`）、`/resume` の PR URL 検索（GitHub/GHE/GitLab/Bitbucket）、`/mcp` で claude.ai connectors 重複表示、OpenTelemetry 数値属性正規化＋`claude_code.at_mention` イベント、画像リサイズ 2,576px→2,000px max 修正、`/branch` フォーク失敗修正、Vertex/Bedrock session-title 生成 `invalid_request_error` 修正、Voice mode の Caps Lock キー警告。**Layer 2 公式（4/28）**: ③ **Claude for Creative Work** ✅ — **9 つの新コネクタ**（Adobe Creative Cloud / Blender / Ableton / Splice / Affinity by Canva / Autodesk Fusion / SketchUp / Resolume Arena & Wire）を全 Claude プランで即時 GA。**Anthropic が Blender Development Fund Corporate Patron 加入**（年間最低 €240,000、Blender Python API メンテ・拡張支援、MCP コネクタ実装は他 LLM からも利用可能）。④ **Claude.ai/API/Code Major Outage**（4/28 17:34–18:52 UTC、約 78 分、Downdetector 12,000 件超）— Claude Code ログイン経路にも影響、4 月 Major クラス障害は 4/15・4/20・4/25 に続く 4 件目。同日 Sonnet 4.5（17 分）・Haiku 4.5（51 分）も別個に Partial Outage、Code Review が断続失敗。Anthropic Newsroom 4/27 Sydney オフィス・Theo Hourmouzis ANZ GM、4/28 Claude for Creative Work が最新エントリ（[調査レポート](reports/2026-04-29_v2.1.121-122-and-claude-creative-work.md)）
- 2026-04-28: **ニュースモード調査**。**Layer 1 CLI**: v2.1.119 が継続最新、新リリースなし。**Layer 2 公式**: ① **Claude Cowork on Amazon Bedrock GA**（4/21 AWS Machine Learning Blog 公開、4/27 AWS Weekly Roundup でハイライト紹介）— Cowork デスクトップアプリ + **Claude Code Desktop** を AWS Bedrock 経由で実行可能、Anthropic シート課金不要、AWS 従量課金のみ、データはユーザー AWS アカウント内（Bedrock 非保持）、IAM/Bedrock API キー認証、VPC エンドポイント、CloudTrail 監査、OpenTelemetry → CloudWatch、Anthropic-hosted の Chat/Computer Use/Skills Marketplace は除外。② **Anthropic Sydney オフィス正式オープン & Theo Hourmouzis ANZ GM 任命**（4/27、APAC 4 拠点目）。**Layer 3**: ③ **arXiv プレプリント「Dive into Claude Code」**（VILA-Lab、2604.14228、4/14 公開、4/27 IntelligentLiving 等で注目）— Claude Code コードベースの **1.6% のみが AI 決定ロジック / 98.4% が決定論的インフラ**、シンプルな while ループコア、**7 モードパーミッションシステム + ML 分類器**、**5 層 compaction パイプライン**、**4 拡張機構（MCP/Plugins/Skills/Hooks）**、worktree 分離 subagent delegation、append-oriented session storage を体系化。13 設計原則・5 ドライバーをマッピング、OpenClaw との対比。④ **コミュニティ: pentest-ai-agents**（4/27、0xSteph）— 28 専門 subagents で Claude Code を攻撃側セキュリティ研究アシスタント化する OSS。⑤ Claude.ai 軽微インシデント（4/27 14:13 UTC、約 1 分、billing 関連、Claude Code 影響なし）。利用環境テーブル「Desktop App (Cowork)」に Bedrock 経由配信 ✅ GA を追記（[調査レポート](reports/2026-04-28_cowork-on-bedrock-and-arxiv-paper.md)）
- 2026-04-28: **Claude Design 深掘り調査**。Claude Design セクションを大幅拡充 — Anthropic Labs（2026年1月新設の実験プロダクト・インキュベーション部門）の第一弾、入力形式（テキスト/画像/DOCX/PPTX/XLSX/GitHub/ローカルディレクトリ/Figma）、デザインシステム自動抽出（コンポーネント/スタイリング/ファイル構成解析）、編集機能（インラインコメント/直接編集/調整スライダー）、エクスポート形式（ZIP/PDF/PPTX/Canva/HTML/Claude Code Hand off）、**Claude Code Hand off** の詳細（デザインファイル+全チャットログ+README+貼り付けプロンプトをバンドル化、Local/Web 選択可）、競合差別化（v0/Lovable/Bolt との中間ポジション）、既知の制限（リアルタイムコラボなし/ベクター非対応/ネイティブReactエクスポートなし/トークン消費が重い）、Canva 正式統合パートナー、Mike Krieger の Figma 取締役辞任、市場インパクト（Figma 株 7% 下落報道）等を追加（[深掘り調査](investigations/2026-04-28_claude-design.md)）
- 2026-04-26: **ニュースモード調査**。**v2.1.120 事実上ロールバック判明**: 4/24 22:11 UTC に npm 公開された v2.1.120 が `claude --resume`/`--continue` 起動時クラッシュ（macOS で `g9H is not a function`、Linux Bun ネイティブで `UKH is not a function`、`onSessionRestored` フックが undefined を返すパターン）、`sandbox.enabled=false` でも `sandbox required but unavailable` を返す回帰（macOS）、auto-update が `manifest.json` 404 で失敗、ターミナルリサイズで UI 重複、`/mcp` メニュー WSL2 で凍結、CLAUDE.md 部分無視、`sandbox.excludedCommands` 不整合、macOS 26.4 worktree hang 等 **8 件超の重大回帰**。4/25 01:45–02:35 UTC のステータスインシデントとして記録、自動アップデートで影響ユーザーを v2.1.119 にダウングレード（`claude install 2.1.119` 手動コマンドも提供）。GitHub Releases・CHANGELOG.md には未掲載で正式リリースとしては扱われない。**Opus 4.7 連続障害**（4/25 に 3 件、最長 08:43–11:58 UTC 約 3h15m）、**claude.ai 障害**（4/25 18:42–19:02 UTC 約 20 分）。**v2.1.119 由来の `claude-opus-4-7` サイレント 1M モデル切替問題**も判明（v2.1.118 では正常、v2.1.119 から内部的に `[1m]` バリアントへルーティング、`CLAUDE_CODE_DISABLE_1M_CONTEXT=1` で回避）。前回 4/25 レポート（v2.1.120 リリースを認識せず）の訂正・補足を兼ねる（[調査レポート](reports/2026-04-26_v2.1.120-rollback-and-opus-incidents.md)）
- 2026-04-25: **ニュースモード調査**（CLI: v2.1.119 が最新、新リリースなしと整理。後続調査で v2.1.120 が当時実は出ていたことが判明）。**Layer 2 公式（4/24）**: ① **Rate Limits API GA**（管理者向け新 Admin API、組織・ワークスペースのレート制限照会、`sk-ant-admin` キー必要）、② **Anthropic × NEC 戦略提携**（Anthropic 初の日本ベース Global Partner、約 30,000 人の NEC グループ社員に Claude 提供、Cowork 全社展開、金融/製造業/地方自治体/サイバーセキュリティの業界特化 AI 共同開発）、③ **2026 米中間選挙セーフガード更新**（Opus 4.7 適切回答率 100%、Sonnet 4.6 99.8%、TurboVote バナー連携）、④ **Project Deal 公開**（SF 本社で Claude 双方代理人マーケットプレイス実験、69 エージェントが 186 件の取引を仲介、総額 $4,000+）。**Layer 3（4/24）**: GitHub Copilot Individual プラン縮小（Pro 新規受付停止、Opus モデル削除）（[調査レポート](reports/2026-04-25_rate-limits-api-and-nec-partnership.md)）
- 2026-04-24: **v2.1.117（4/22）と v2.1.118（4/23）連続リリース**を反映。v2.1.118: **vim visual/visual-line モード**、**`/cost`+`/stats` → `/usage` 統合**、**カスタムテーマ作成・プラグイン配布**、**Hook から MCP tools 直接呼び出し（`type: "mcp_tool"` 新 hook イベントタイプ）**、**`DISABLE_UPDATES` 環境変数**、WSL 側 Windows managed settings 継承、Auto mode `"$defaults"` プレースホルダ、`claude plugin tag`、`/color` の claude.ai/code 同期。v2.1.117: **ネイティブビルドで `bfs`/`ugrep` 埋め込み**（Glob/Grep 置換）、複数 MCP 並列接続、**Pro/Max Opus 4.6/Sonnet 4.6 デフォルト effort `medium`→`high`**、**Opus 4.7 `/context` 計算 200K→1M 修正**、Advisor Tool experimental ラベル、OpenTelemetry に `effort`/`command_name`/`command_source` 属性、Plain-CLI OAuth reactive refresh、Forked subagents 外部ビルド有効化（`CLAUDE_CODE_FORK_SUBAGENT=1`）。**2026-04-23 Freshfields × Anthropic 複数年提携**: 33 拠点 5,700 人に Claude 全社導入、Cowork 展開予定、RELX 株価下落。**2026-04-21〜22 Claude Code on Pro 試験削除事件**: 2% A/B テストが Web 全面更新ミスで拡大、48 時間以内に revert、既存ユーザー影響なし。Hook イベントテーブル、スラッシュコマンドテーブル、主要機能リスト、ビジネスセクションに追記（[調査レポート](reports/2026-04-24_v2.1.117-118-vim-visual-and-freshfields.md)）
- 2026-04-22: **ニュースモード調査**（新CLIリリースなし、v2.1.116継続、Layer 2 公式発表もなし）。**2026-04-21 Axiosスクープ**「CISA doesn't have access to Anthropic's Mythos」を反映 — 国家のトップサイバー防衛機関 CISA が Mythos アクセスを保有していないと判明、Anthropic は 40 社超の組織に限定配布中だが CISA は含まれず。4/17 Bloomberg の「OMB が CISA への Mythos 認可プロトコル整備」報道を実態面で訂正。**2026-04-21 CNBC インタビュー**: Trump が国防総省 Anthropic 合意を "possible" と発言、「shaping up」として 2 月の連邦機関利用停止指令から態度軟化。TheNextWeb が White House OMB（連邦 CIO Gregory Barbaccia）による連邦機関向け Mythos controlled version アクセスプロトコル整備を追加報道。DoDブラックリスト情勢セクションに追記（[調査レポート](reports/2026-04-22_cisa-access-and-trump-deal-possible.md)）
- 2026-04-21: **v2.1.116反映**（`/resume` 67%高速化、MCP `resources/templates/list` 遅延ロード、フルスクリーンスクロール改善、Thinking spinner インライン進捗、`/config` 値検索、`/doctor` 非ブロッキング、`/reload-plugins` プラグイン欠落依存自動インストール、Bash `gh` レート制限ヒント、Usage tab 即時表示、Agent frontmatter `hooks:` の `--agent` 対応、sandbox auto-allow の `rm`/`rmdir` 危険パス保護強化、Kitty keyboard protocol 多数修正、Ctrl+Z hang、VS Code scrolling、cache control TTL API 400、scrollback 複製、`/branch` 50MB 制限、`/resume` 空会話、`/plugin` 重複表示、worktree 後の `/update`/`/tui` 非動作）。**Claude Opus 4.7 on Amazon Bedrock GA**（2026-04-20、4リージョン（US East N.Virginia / Asia Pacific Tokyo / Europe Ireland/Stockholm）、10,000 RPM/アカウント/リージョン、1Mコンテキスト、高解像度画像、adaptive thinking、next-gen inference engine）— ただし Claude Code on Bedrock の `opus` エイリアスは依然 Opus 4.6 解決（4.7 利用には `ANTHROPIC_DEFAULT_OPUS_MODEL` or full model name 必須）、既知の不具合 #49238 継続中。**Project Glasswing/Mythos 周辺報道継続**: CSA が CISO 向け「flood of vulnerabilities」ガイド更新（4/16）、Foreign Policy「Cyber Calculus」論説、Barracuda Networks の防御策、CounterPunch 批判論説（[調査レポート](reports/2026-04-21_v2.1.116-and-opus-4.7-bedrock.md)）
- 2026-04-20: **ニュースモード調査**（CLIリリースなし、Layer 2 公式発表もなし）。**2026-04-19 Axiosスクープ**「NSA using Anthropic's Mythos despite Defense Department blacklist」を反映 — Pentagonの傘下情報機関であるNSAがブラックリスト対象のAnthropic Mythosを**実利用中**（インフラ脆弱性スキャン）。Pentagon対Anthropic法的係争が続くなか、行政府内で事実上の "de facto 解禁" 進行。**RedState（4/18）が具体機関を特定**: 商務省AI標準化イノベーションセンター、エネルギー省、財務省金融システム保護部門、CISAがMythos評価中。**Trending Topics（4/19）**: 英国MI5がUK AISI経由でMythosアクセス取得。DoDブラックリストセクションに追記（[調査レポート](reports/2026-04-20_nsa-mythos-scoop-and-federal-usage.md)）
- 2026-04-19: **v2.1.114反映**（Agent Teams のチームメイトがツール許可リクエストをした際の permission dialog クラッシュ修正）。**Claude Design の利用条件が確定**: Pro/Max/Team/Enterprise 対象、**Enterprise はデフォルトオフ（管理者が Organization settings で有効化）**、既存プラン枠を使用しつつ **Claude chat/Claude Code とは独立した週次クォータ**、超過後は extra usage で継続可能（公式ヘルプ記事）。**Agent Teams セクション拡充**: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` 実験フラグ、lead/teammate パーミッション継承、バブルアップ承認モデル、v2.1.114 での修正を記載。**Claude Haiku 3（`claude-3-haiku-20240307`）API リタイア本日発効**（4月19日）、以降エラー応答、Haiku 4.5 への移行必須（[調査レポート](reports/2026-04-19_v2.1.114-and-claude-design-plans.md)）
- 2026-04-18（追加）: **v2.1.113反映**。**ネイティブClaude Codeバイナリ移行**（CLIがバンドルJSの代わりにプラットフォーム別optional depのネイティブバイナリを spawn、Bun/JSCベース）、**`sandbox.network.deniedDomains`** 設定、**セキュリティハードニング多数**（macOS `/private/{etc,var,tmp,home}` を危険削除ターゲット扱い、Bash deny ルールの `env`/`sudo`/`watch`/`ionice`/`setsid` exec ラッパー対応、`Bash(find:*)` allow ルールで `-exec`/`-delete` の自動承認廃止）、**`Bash` `dangerouslyDisableSandbox` サンドボックスバイパス修正**、Fullscreen Shift+↑/↓ スクロール、Ctrl+A/Ctrl+E readline、Windows Ctrl+Backspace、OSC 8 折り返しURL、`/loop` Esc キャンセル、`/ultrareview` 並列化・diffstat・アニメーション、`/extra-usage` / `@`補完 の Remote Control 対応、サブエージェント10分タイムアウト、多数のバグ修正。**2026-04-23予告: API デフォルトモデルが Opus 4.6 → Opus 4.7 へ切替**（Enterprise pay-as-you-go および Anthropic API、`opus` エイリアス解決先変更）。Opus 4.7 が **Snowflake Cortex AI**（Public Preview）と **GitHub Copilot**（GA）で同日展開判明（[調査レポート](reports/2026-04-18_v2.1.113-native-binary-and-default-model-shift.md)）
- 2026-04-18: v2.1.111-112反映。**Claude Opus 4.7 GAリリース**（SWE-bench Verified 87.6%、2,576pxビジョン、同価格）、Claude Codeデフォルト努力レベルを`xhigh`に変更、`/ultrareview`コマンド（並列マルチエージェントコードレビュー）、`/less-permission-prompts`スキル、インタラクティブ`/effort`スライダー、Auto (match terminal)テーマ、Auto modeがMaxサブスクライバー対応、Windows PowerShellツール段階展開、globパターンBash自動許可、`Ctrl+U`/`Ctrl+L`強化、多数のバグ修正。**Claude Design発表**（4月17日、Anthropic Labs — デザイン・プロトタイプ・スライド生成）。**ホワイトハウス・Anthropic会談**（4月17日、Dario Amodei × Susie Wiles — Pentagon紛争解消交渉）。ホワイトハウスが米連邦機関にMythosアクセス認可（[調査レポート](reports/2026-04-18_v2.1.111-112-opus-4.7-and-claude-design.md)）
- 2026-04-16: v2.1.109-110反映。`/tui`コマンド（フルスクリーンフリッカーフリーレンダリング切り替え）、プッシュ通知ツール、`autoScrollEnabled`設定、`Ctrl+O`/`/focus`分離、Extended Thinkingローテーションヒント、`--resume`/`--continue`スケジュールタスク復活、`/plugin`・`/doctor`改善、MCP接続切断ハング修正。**Claude.ai/API/Code大規模障害**（4月15日、約3時間、15,000件超報告）。**パフォーマンス低下問題・ユーザー反発**（Fortune、VentureBeat等が報道、AMD・Microsoft研究者が批判）（[調査レポート](reports/2026-04-16_v2.1.109-110-tui-fullscreen-and-outage.md)）
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
