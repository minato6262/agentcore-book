# 開発コンテナ（devcontainer）

本リポジトリのサンプルコードを、GitHub Codespaces またはお手元のDockerで同じ環境で動かすための設定です。

書籍の付録2「開発環境の構築」で手動インストールする **uv / AWS CLI** と、第13章・第15章で使う **Node.js** をあらかじめ入れた状態でコンテナが起動します。

## 含まれるもの

| ツール | バージョン | 用途 |
|--------|-----------|------|
| Debian (bookworm) ベースイメージ | - | 開発コンテナの土台 |
| uv | 最新 | Python本体とパッケージの管理（本書はPython 3.14。第10章のみ3.13） |
| Node.js | 22 | AgentCore CLI（第5章・第13章）、CDK（第15章）、Next.js（第13章） |
| AWS CLI v2 | 最新 | `aws login --remote` などAWS操作 |
| GitHub CLI | 最新 | リポジトリ操作（任意） |

Pythonはベースイメージに入れず、**uvが章ごとに必要なバージョンを用意** します（`uv sync` 実行時に自動）。

## 使い方（VS Code + ローカルDocker）

1. Docker Desktop（または互換のDocker環境）を起動しておく
2. VS Codeに拡張機能「Dev Containers」をインストール
3. 本リポジトリをVS Codeで開き、コマンドパレットから **Dev Containers: Reopen in Container** を実行

初回はイメージのビルドに数分かかります。

## 使い方（GitHub Codespaces）

GitHubのリポジトリページから **Code → Codespaces → Create codespace** を実行すると、この設定でコードスペースが起動します。付録2.3のuv／AWS CLIのインストール手順は完了済みの状態から始められます。

## コンテナ起動後の流れ

```bash
# AWSにログイン
aws login --remote

# ログインできたか確認
aws sts get-caller-identity

# 動かしたい章へ移動して依存関係をインストール
cd chapter5
uv sync
```

AgentCore CLIは章ごとに書籍の手順でインストールしてください。

```bash
npm install -g @aws/agentcore@latest
```

## 補足

- AWSリージョンは本書に合わせて `us-east-1`（バージニア北部）を環境変数で設定しています
- ポート3000（Next.js）、8080（AgentCoreランタイムのローカル起動）、8501（Streamlit）を自動転送します
- 第5章・第13章・第15章のコンテナイメージのビルドはAWS側（CodeBuild）で行われるため、コンテナ内にDockerは同梱していません。コンテナ内で `docker` コマンドを使いたい場合は `devcontainer.json` の `features` に `ghcr.io/devcontainers/features/docker-outside-of-docker:1` を追加してください
