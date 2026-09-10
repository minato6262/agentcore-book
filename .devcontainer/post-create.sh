#!/usr/bin/env bash
# devcontainer作成後に1回だけ実行されるセットアップスクリプト
set -euo pipefail

echo "==> uvをインストールします"
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi
export PATH="$HOME/.local/bin:$PATH"
uv --version

# 本書で使うPythonをあらかじめ取得しておく（3.14が基本、第10章のみ3.13）
echo "==> Python 3.14 / 3.13 を取得します"
uv python install 3.14 3.13

# Claude Code（任意）。不要なら以下2行を削除してください
echo "==> Claude Codeをインストールします"
npm install -g @anthropic-ai/claude-code

echo "==> バージョン確認"
node --version
npm --version
aws --version

cat <<'MSG'

セットアップが完了しました。

次のステップ:
  1. AWSにログイン    : aws login --remote
  2. ログイン確認      : aws sts get-caller-identity
  3. 章ディレクトリへ   : cd chapter5 && uv sync

AgentCore CLIは書籍の手順に沿って、必要な章で個別にインストールしてください。
  npm install -g @aws/agentcore@latest

MSG
