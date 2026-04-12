# Deep Dive: Claude Managed Agents

**調査日:** 2026-04-12
**関連する日次レポート:** [2026-04-09 v2.1.96-97・Managed Agents・ant CLI](../reports/2026-04-09_v2.1.96-97-managed-agents-and-ant-cli.md) / [2026-04-12 Managed Agents価格詳細](../reports/2026-04-12_christian-summit-and-managed-agents-pricing.md)

## 概要

Claude Managed Agentsは、Anthropicが提供するクラウドホスト型AIエージェント基盤。Messages APIとは異なり、エージェントループ・ツール実行・ランタイムをAnthropicのインフラで完全管理する。開発者はエージェントの定義（モデル・プロンプト・ツール）に集中でき、サンドボックス構築・状態管理・認証処理といったインフラ層を自前で構築する必要がない。2026年4月8日にパブリックベータとして発表され、全APIアカウントにデフォルト有効化されている。

## 背景知識・技術解説

### そもそも何か

Claude Managed Agentsは「マネージドエージェントランタイム」——AIエージェントを本番環境で動かすためのフルマネージドインフラストラクチャサービスである。従来のMessages APIが「モデルに1回リクエストを送り、1回レスポンスを受け取る」同期的なやり取りだったのに対し、Managed Agentsは「タスクを渡すと、エージェントが自律的にツールを使いながら作業を進め、完了したら結果を返す」非同期・長時間実行型のワークロードを実現する。

具体的には以下をAnthropicのクラウドインフラが提供する：
- **セキュアなコンテナ環境**: エージェントが安全にコード実行・ファイル操作を行うサンドボックス
- **エージェントループ**: ツール呼び出し→結果取得→次の判断、というループの自動管理
- **プロンプトキャッシング・コンパクション**: 長時間セッションでのコンテキストウィンドウ最適化
- **認証情報管理（Vault）**: サードパーティサービスへのOAuth認証を安全に管理
- **イベントストリーミング**: SSEによるリアルタイムの進捗通知

| | Messages API | Claude Managed Agents |
|---|---|---|
| **概要** | モデルへの直接プロンプティング | マネージドインフラ上のエージェントハーネス |
| **適する用途** | カスタムエージェントループ、細かい制御 | 長時間タスク、非同期ワークロード |
| **インフラ** | 自前で構築 | Anthropicが提供 |

### なぜ重要か

AIエージェントを本番環境にデプロイするには、モデルそのものの性能以外に膨大なインフラ作業が必要だった。Anthropicの公式ブログによると、「プロダクション品質のエージェントを出荷するには、ユーザー向けの価値を届ける前に何ヶ月ものインフラ構築が必要」だった。Managed Agentsはこのギャップを埋め、「日単位ではなく月単位」の開発サイクルを実現する。

業界的には、OpenAIのAssistants API、GoogleのAgent Builder（Vertex AI Agent Engine）、AWS BedrockのAgentsと並ぶ、クラウドプロバイダーによるマネージドエージェントサービスの一つに位置付けられる。Anthropicの差別化ポイントは：
- Claude Codeで実証済みのハーネス技術をAPIとして提供
- Brain/Hands/Session分離による高いスケーラビリティと障害耐性
- Credential Vault/MCPコネクタによるサードパーティ統合の容易さ

### これまでの経緯

Managed Agents登場以前、Claude APIでエージェント的なワークフローを構築するには：

1. **Messages API + Tool Use**: 開発者が自前でエージェントループを構築。ツール定義→モデル呼び出し→ツール実行→結果をモデルに返す、というサイクルを手動で管理
2. **Claude Code**: Anthropic自身がこのパターンを高度に実装したCLIツール。ローカル環境で動作
3. **サードパーティフレームワーク**: LangChain、CrewAI等のオープンソースフレームワークで補完

これらのアプローチには共通の課題があった：
- サンドボックス構築・セキュリティ管理の負担
- 長時間実行時のコンテキストウィンドウ管理
- 認証情報の安全な取り扱い
- スケーリング・障害復旧の設計

Anthropicはこの課題を、Claude Codeの開発で培ったハーネス技術をクラウドサービス化することで解決した。Engineering Blogでは「ペット化したコンテナ」（単一コンテナに全てを詰め込む設計）から「Brain/Hands/Session分離」への設計転換が説明されている。

## 機能の詳細

### コアコンセプト（4つの柱）

| 概念 | 説明 |
|------|------|
| **Agent** | モデル、システムプロンプト、ツール、MCPサーバー、スキルの定義。再利用可能でバージョン管理される |
| **Environment** | パッケージ（Python、Node.js、Go等）、ネットワークアクセス、ファイルマウントを設定したコンテナテンプレート |
| **Session** | AgentとEnvironmentの実行インスタンス。特定のタスクを遂行し、出力を生成する |
| **Events** | アプリケーションとエージェント間のメッセージ（ユーザーターン、ツール結果、ステータス更新）。SSEストリーミング |

### Agent定義

Agentは再利用可能なバージョン管理されたリソース。一度作成すれば、IDで参照して複数のセッションで使い回せる。

**設定フィールド:**

| フィールド | 説明 |
|-----------|------|
| `name` | 必須。人間が読める名前 |
| `model` | 必須。Claude 4.5以降のモデル。Fast Modeも対応（`{"id": "claude-opus-4-6", "speed": "fast"}`） |
| `system` | システムプロンプト。エージェントの振る舞いとペルソナを定義 |
| `tools` | 利用可能ツール。組み込みツールセット＋MCPツール＋カスタムツール |
| `mcp_servers` | MCPサーバー接続設定 |
| `skills` | ドメイン固有の専門知識を提供するスキル |
| `callable_agents` | マルチエージェント編成で呼び出せる他のAgent（研究プレビュー） |
| `description` | エージェントの説明 |
| `metadata` | 任意のキーバリューペア |

**コード例（Python）:**

```python
from anthropic import Anthropic

client = Anthropic()

agent = client.beta.agents.create(
    name="Coding Assistant",
    model="claude-sonnet-4-6",
    system="You are a helpful coding assistant.",
    tools=[{"type": "agent_toolset_20260401"}],
)
```

**Agent ライフサイクル:**
- **更新**: 新バージョンが生成される。省略フィールドは保持、スカラーフィールドは置換、配列フィールドは全置換
- **バージョン一覧**: 変更履歴の追跡が可能
- **アーカイブ**: 読み取り専用化。新セッションは参照不可、既存セッションは継続

### Environment設定

Environmentはエージェントが動作するコンテナ環境を定義する。

**ネットワーク設定:**

| モード | 説明 |
|--------|------|
| `unrestricted` | 全アウトバウンドアクセス許可（安全性ブロックリスト除く）。デフォルト |
| `limited` | `allowed_hosts`リストに制限。`allow_package_managers`/`allow_mcp_servers`で個別許可可能 |

**パッケージマネージャー対応:**

| フィールド | パッケージマネージャー | 例 |
|-----------|---------------------|-----|
| `apt` | システムパッケージ | `"ffmpeg"` |
| `cargo` | Rust | `"ripgrep@14.0.0"` |
| `gem` | Ruby | `"rails:7.1.0"` |
| `go` | Go modules | `"golang.org/x/tools/cmd/goimports@latest"` |
| `npm` | Node.js | `"express@4.18.0"` |
| `pip` | Python | `"pandas==2.2.0"` |

**コード例（Python）:**

```python
environment = client.beta.environments.create(
    name="data-analysis",
    config={
        "type": "cloud",
        "packages": {
            "pip": ["pandas", "numpy", "scikit-learn"],
            "npm": ["express"],
        },
        "networking": {"type": "unrestricted"},
    },
)
```

**ライフサイクル:**
- 複数セッションが同一Environmentを参照可能
- 各セッションは独自のコンテナインスタンスを取得（ファイルシステムは共有されない）
- Environmentはバージョン管理されない

### Session管理

SessionはAgentとEnvironmentの実行インスタンス。

**セッション状態:**

| ステータス | 説明 |
|-----------|------|
| `idle` | 入力待ち（ユーザーメッセージまたはツール確認）。セッション開始時の初期状態 |
| `running` | エージェントが実行中 |
| `rescheduling` | 一時的エラー発生、自動リトライ中 |
| `terminated` | 回復不可能なエラーにより終了 |

**セッション作成時のオプション:**
- エージェントバージョン固定: `agent={"type": "agent", "id": agent_id, "version": 1}`
- Vault参照: `vault_ids=[vault_id]`（MCP認証用）

**操作一覧:**
- `create`: セッション作成（環境プロビジョニングのみ、タスク実行は開始しない）
- `retrieve`: セッション情報取得
- `list`: セッション一覧
- `archive`: アーカイブ（履歴保持、新イベント送信不可）
- `delete`: 永久削除（レコード・イベント・コンテナ全削除）

### Events & ストリーミング

イベントベースの通信モデル。`{domain}.{action}` 命名規則。

**ユーザーイベント（送信）:**

| タイプ | 説明 |
|--------|------|
| `user.message` | テキストコンテンツ付きユーザーメッセージ |
| `user.interrupt` | エージェントの実行中断 |
| `user.custom_tool_result` | カスタムツール呼び出しへの応答 |
| `user.tool_confirmation` | ツール呼び出しの承認/拒否（権限ポリシー要求時） |
| `user.define_outcome` | エージェントが目指す成果の定義（研究プレビュー） |

**エージェントイベント（受信）:**

| タイプ | 説明 |
|--------|------|
| `agent.message` | テキスト応答 |
| `agent.thinking` | 思考内容 |
| `agent.tool_use` | 組み込みツール呼び出し |
| `agent.tool_result` | 組み込みツール実行結果 |
| `agent.mcp_tool_use` | MCPツール呼び出し |
| `agent.mcp_tool_result` | MCPツール結果 |
| `agent.custom_tool_use` | カスタムツール呼び出し |
| `agent.thread_context_compacted` | コンテキストウィンドウに収めるため会話履歴を圧縮 |
| `agent.thread_message_sent` | マルチエージェントスレッドへのメッセージ送信 |
| `agent.thread_message_received` | マルチエージェントスレッドからのメッセージ受信 |

**セッションイベント（受信）:**

| タイプ | 説明 |
|--------|------|
| `session.status_running` | 処理中 |
| `session.status_idle` | タスク完了、入力待ち |
| `session.status_rescheduled` | 一時エラー、自動リトライ |
| `session.status_terminated` | 回復不可能エラーで終了 |
| `session.error` | エラー発生 |
| `session.outcome_evaluated` | アウトカム評価完了（研究プレビュー） |
| `session.thread_created` | マルチエージェントスレッド作成 |
| `session.thread_idle` | マルチエージェントスレッド完了 |

**スパンイベント（オブザーバビリティ）:**

| タイプ | 説明 |
|--------|------|
| `span.model_request_start` | モデル推論開始 |
| `span.model_request_end` | モデル推論完了（`model_usage`にトークン数含む） |
| `span.outcome_evaluation_start` | アウトカム評価開始 |
| `span.outcome_evaluation_ongoing` | アウトカム評価進行中ハートビート |
| `span.outcome_evaluation_end` | アウトカム評価完了 |

### 組み込みツール

`agent_toolset_20260401`で全ツールを一括有効化。個別の有効/無効設定も可能。

| ツール | 名前 | 説明 |
|--------|------|------|
| Bash | `bash` | コンテナ内シェルコマンド実行 |
| Read | `read` | ファイル読み取り |
| Write | `write` | ファイル書き込み |
| Edit | `edit` | ファイル内文字列置換 |
| Glob | `glob` | globパターンによるファイル検索 |
| Grep | `grep` | 正規表現によるテキスト検索 |
| Web fetch | `web_fetch` | URLからコンテンツ取得 |
| Web search | `web_search` | Web検索 |

**ツール設定の柔軟性:**

特定ツールの無効化:
```json
{
  "type": "agent_toolset_20260401",
  "configs": [
    {"name": "web_fetch", "enabled": false},
    {"name": "web_search", "enabled": false}
  ]
}
```

特定ツールのみ有効化:
```json
{
  "type": "agent_toolset_20260401",
  "default_config": {"enabled": false},
  "configs": [
    {"name": "bash", "enabled": true},
    {"name": "read", "enabled": true}
  ]
}
```

### カスタムツール

Messages APIのuser-defined toolsと同様に、独自のカスタムツールを定義可能。エージェントが`agent.custom_tool_use`イベントを発行し、アプリケーション側でツールを実行して`user.custom_tool_result`で結果を返す。

```python
agent = client.beta.agents.create(
    name="Weather Agent",
    model="claude-sonnet-4-6",
    tools=[
        {"type": "agent_toolset_20260401"},
        {
            "type": "custom",
            "name": "get_weather",
            "description": "Get current weather for a location",
            "input_schema": {
                "type": "object",
                "properties": {
                    "location": {"type": "string", "description": "City name"},
                },
                "required": ["location"],
            },
        },
    ],
)
```

### Skills（スキル）

スキルはファイルシステムベースの再利用可能リソース。ドメイン固有の専門知識をエージェントに付与する。プロンプトとは異なり、関連するタスクでのみオンデマンドで読み込まれ、コンテキストウィンドウを効率的に使用する。

**スキルタイプ:**
- **Anthropic組み込みスキル**: PowerPoint、Excel、Word、PDFハンドリング（`xlsx`, `pptx`等）
- **カスタムスキル**: 組織が作成しアップロードするスキル

**制限**: セッションあたり最大20スキル（マルチエージェント時は全エージェント合計）

### MCPコネクタ

Model Context Protocol (MCP) サーバーに接続し、外部ツール・データソースにアクセス。

**設定の分離:**
1. **Agent作成時**: MCPサーバーのURL・名前を宣言（認証情報なし）
2. **Session作成時**: Vault IDで認証情報を供給

```python
agent = client.beta.agents.create(
    name="GitHub Assistant",
    model="claude-sonnet-4-6",
    mcp_servers=[
        {"type": "url", "name": "github", "url": "https://api.githubcopilot.com/mcp/"},
    ],
    tools=[
        {"type": "agent_toolset_20260401"},
        {"type": "mcp_toolset", "mcp_server_name": "github"},
    ],
)
```

**対応プロトコル**: リモートMCPサーバー（HTTP Streamable Transport）

### Credential Vault

認証情報管理のためのプリミティブ。エンドユーザー単位でサードパーティサービスの認証情報を安全に保存・管理する。

**認証タイプ:**
- **`mcp_oauth`**: OAuth 2.0。アクセストークン＋リフレッシュトークンの自動更新対応
- **`static_bearer`**: 固定ベアラートークン（APIキー、パーソナルアクセストークン等）

**セキュリティ特性:**
- シークレットフィールド（`token`, `access_token`, `refresh_token`, `client_secret`）は書き込み専用。APIレスポンスには含まれない
- VaultはWorkspaceスコープ。APIキーアクセス権を持つ全員が使用可能
- MCP server URL あたり1 Vault につき1アクティブ認証情報
- Vault あたり最大20認証情報

**対応済みサービス（確認済み）:** Slack、GitHub、Linear、ClickUp、Notion

## アーキテクチャ（Brain/Hands/Session分離設計）

Anthropic Engineering Blogで詳細に解説されたアーキテクチャ設計。

### 3コンポーネント分離モデル

| コンポーネント | 役割 | 特徴 |
|---------------|------|------|
| **Brain**（ハーネス） | Claude + ハーネス。セッションログからイベントを取得し推論実行 | ステートレス。多数並列起動可能 |
| **Hands**（実行環境） | サンドボックス、MCPサーバー、カスタムツール | 統一インターフェース `execute(name, input) → string` |
| **Session**（状態ログ） | 追記専用イベントログ | BrainとHandsから独立して保持 |

### 設計思想

従来の「単一コンテナに全機能を詰め込む」アプローチは、コンテナが「ペット」化する問題があった。障害時にセッションが丸ごと失われ、デバッグも困難だった。

分離設計により：
- 各コンポーネントが独立して失敗・交換可能
- BrainがクラッシュしてもSessionログが外部に存在するため、新しいBrainで`wake(sessionId)`して再開可能
- Handsの障害はツール呼び出しエラーとして検出され、`provision({resources})`で新コンテナを初期化
- ステートレススケーリング: 多数のBrainをHands接続なしで起動可能

### パフォーマンス

- **p50 TTFT（Time to First Token）**: 約60%削減
- **p95 TTFT**: 90%以上削減

BrainをコンテナからRPC分離したことで、推論開始がセッションログからのイベント取得直後に可能になった。

### セキュリティモデル

**原則**: "tokens are never reachable from the sandbox"

- **パターン1（Git）**: リポジトリアクセストークンをサンドボックス初期化時にローカルgit remoteに紐付け。トークン自体はサンドボックス内に保持されない
- **パターン2（MCPツール）**: OAuthトークンを外部Vaultに格納。Claude は専用プロキシ経由でツール呼び出し。プロキシがセッション関連トークンからVaultの認証情報を取得

### 今後の展望

"meta-harness"として、将来のハーネス形態に未決定のまま対応可能。Claude Codeをはじめとする現在のハーネスはもちろん、タスク特化型ハーネスも同一インターフェースで統合可能。モデル性能向上に応じてハーネス実装を交換でき、インターフェースの安定性を保証する。

## 研究プレビュー機能

以下の3機能は研究プレビュー段階で、利用にはアクセス申請が必要（[申請フォーム](https://claude.com/form/claude-managed-agents)）。

### Outcomes（成果定義）

エージェントに成果目標と成功基準を定義し、Claudeが自己評価・イテレーションを行う機能。構造化ファイル生成の内部テストでは、標準的なプロンプトループと比較して**タスク成功率が最大10ポイント向上**、最も困難な問題で最大の効果を発揮した。

関連イベント: `user.define_outcome`, `session.outcome_evaluated`, `span.outcome_evaluation_*`

### Multi-agent（マルチエージェント）

エージェントが他のエージェントを起動・指示し、複雑なワークを並列化する機能。`callable_agents`フィールドで呼び出し可能なエージェントを定義。

関連イベント: `agent.thread_message_sent`, `agent.thread_message_received`, `session.thread_created`, `session.thread_idle`

### Memory（セッション間メモリ）

エージェントがセッション間でコンテキストを保持し、追加のオーケストレーションなしでマルチステップタスクを完了できる機能。

## SDK対応言語

全7言語のSDKで利用可能：

| 言語 | パッケージ |
|------|-----------|
| Python | `pip install anthropic` |
| TypeScript | `npm install @anthropic-ai/sdk` |
| Java | `com.anthropic:anthropic-java:2.20.0` |
| Go | `go get github.com/anthropics/anthropic-sdk-go` |
| C# | `dotnet add package Anthropic` |
| Ruby | `bundle add anthropic` |
| PHP | `composer require anthropic-ai/sdk` |

`ant` CLI（Homebrew、curl、Go install）でも操作可能。

## 制限事項・注意点

### Claude専用
GPT-4、Gemini、オープンソースモデルは利用不可。Claudeモデル（4.5以降）のみ対応。

### ベータ制約
- 全エンドポイントに`managed-agents-2026-04-01`ベータヘッダー必須（SDKは自動設定）
- リリース間でハーネスの動作が変更される可能性あり
- 研究プレビュー機能（Outcomes/Multi-agent/Memory）は別途アクセス申請必要

### レート制限
| 操作 | 制限 |
|------|------|
| 作成系エンドポイント | 60リクエスト/分 |
| 読み取り系エンドポイント | 600リクエスト/分 |

組織レベルの使用量制限・ティアベースのレート制限も適用される。50エージェント並列実行でトークン消費が集中するとレート上限に到達する。

### ベンダーロックイン
Anthropicインフラ・ツール・セッション形式・サンドボックスに依存するため、他プロバイダーへの移行は容易ではない。

### 既知の課題
- Claudeが明示的なプロンプトなしに機能の完了をテストせず「完了」と報告する傾向がある
- ブラウザネイティブのアラートモーダル等、Puppeteer MCPでは検出できないUI要素がある
- Environment はバージョン管理されない（更新履歴は自前でログ管理推奨）

### ブランディング制限
- 「Claude Agent」「Claude」は使用可。「Claude Code」「Claude Cowork」の名称使用は不可
- Claude Codeブランドのアスキーアートや視覚的要素の模倣は禁止

## 関連機能との比較

### Messages API Tool Use vs Managed Agents

| 観点 | Messages API Tool Use | Managed Agents |
|------|----------------------|----------------|
| エージェントループ | 開発者が自前構築 | Anthropic管理 |
| ツール実行 | クライアント側 | クラウド側（組み込みツール） |
| サンドボックス | なし（自前構築） | セキュアコンテナ提供 |
| セッション管理 | なし | 永続セッション |
| 認証管理 | 自前 | Credential Vault |
| 適する場面 | 細かい制御が必要 | 長時間タスク、非同期処理 |

### Claude Code vs Managed Agents

| 観点 | Claude Code | Managed Agents |
|------|-------------|----------------|
| 実行環境 | ローカルマシン | Anthropicクラウド |
| 対象ユーザー | 開発者個人 | アプリケーション組み込み |
| ツール | ローカルファイル・コマンド | コンテナ内ツール＋MCP |
| インターフェース | CLI/IDE/Web | API（プログラマティック） |

### Advisor Tool vs Managed Agents

Advisor Toolは高速エグゼキューター（Sonnet/Haiku）にアドバイザー（Opus等）を組み合わせるAPIツール。Managed Agentsはエージェントランタイム全体を管理する別レイヤーのサービスであり、Advisor ToolはManaged Agents内でも使用可能。

## ユースケース・活用例

### 早期採用企業の事例

| 企業 | 活用内容 |
|------|----------|
| **Notion** | カスタムAgentでチーム横断の並列タスク実行 |
| **Rakuten** | 数週間でエンタープライズエージェントを部門横断デプロイ |
| **Asana** | AI TeammatesがプロジェクトA内でコラボレーション |
| **Vibecode** | AI ネイティブアプリのインフラプロビジョニングが「10倍高速化」 |
| **Sentry** | バグ→PRワークフローを「数ヶ月ではなく数週間で」構築 |

### ベストプラクティス

- **明示的なテスト要件**: ブラウザ自動化ツールを提供し、Claudeに明示的にend-to-endテストを指示する
- **マルチコンテキストウィンドウ管理**: 初期セッションで`init.sh`と進捗追跡ファイルをセットアップし、後続セッションでインクリメンタルに進捗
- **本番デプロイ**: 大規模運用にはAnthropicセールスチームと適切なレート制限を交渉
- **ネットワーク**: 本番環境では`limited`ネットワーキング + 明示的`allowed_hosts`リスト推奨（最小権限の原則）

## リリース状態

| 項目 | 内容 |
|------|------|
| ステータス | 🧪 パブリックベータ |
| 対象プラン | 全APIアカウント（デフォルト有効） |
| 対象プラットフォーム | Claude API（全SDK対応：Python/TypeScript/Java/Go/C#/Ruby/PHP + ant CLI） |
| 初出日付 | 2026年4月8日 |
| ベータヘッダー | `managed-agents-2026-04-01` |
| 価格（ベータ） | 入力 $3-5/Mトークン、出力 $15-25/Mトークン + アクティブランタイム $0.08/時間 |
| 研究プレビュー機能 | Outcomes、Multi-agent、Memory（要アクセス申請） |

## 情報源一覧

### 公式ドキュメント
- [Claude Managed Agents Overview](https://platform.claude.com/docs/en/managed-agents/overview)
- [Quickstart](https://platform.claude.com/docs/en/managed-agents/quickstart)
- [Agent Setup](https://platform.claude.com/docs/en/managed-agents/agent-setup)
- [Tools](https://platform.claude.com/docs/en/managed-agents/tools)
- [Environments](https://platform.claude.com/docs/en/managed-agents/environments)
- [Sessions](https://platform.claude.com/docs/en/managed-agents/sessions)
- [Events and Streaming](https://platform.claude.com/docs/en/managed-agents/events-and-streaming)
- [Skills](https://platform.claude.com/docs/en/managed-agents/skills)
- [MCP Connector](https://platform.claude.com/docs/en/managed-agents/mcp-connector)
- [Vaults](https://platform.claude.com/docs/en/managed-agents/vaults)

### 公式ブログ
- [Claude Managed Agents: Production-Ready AI at Scale](https://claude.com/blog/claude-managed-agents)
- [Scaling Managed Agents: Decoupling the brain from the hands](https://www.anthropic.com/engineering/managed-agents)

### 技術メディア
- [Help Net Security - Claude Managed Agents bring execution and control to AI agent workflows](https://www.helpnetsecurity.com/2026/04/09/claude-managed-agents-bring-execution-and-control-to-ai-agent-workflows/)
- [InfoWorld - Anthropic rolls out Claude Managed Agents](https://www.infoworld.com/article/4156852/anthropic-rolls-out-claude-managed-agents.html)
- [The New Stack - With Claude Managed Agents, Anthropic wants to run your AI agents for you](https://thenewstack.io/with-claude-managed-agents-anthropic-wants-to-run-your-ai-agents-for-you/)

### コミュニティ・ガイド
- [The AI Corner - Claude Managed Agents: complete guide to building production AI agents (2026)](https://www.the-ai-corner.com/p/claude-managed-agents-guide-2026)
- [Medium - Claude Managed Agents: What It Actually Offers, the Honest Pros and Cons](https://medium.com/@unicodeveloper/claude-managed-agents-what-it-actually-offers-the-honest-pros-and-cons-and-how-to-run-agents-52369e5cff14)
