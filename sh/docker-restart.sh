#!/bin/bash
set -e  # エラーがあれば停止

# イメージ名（run.sh と統一）
IMAGE_NAME="kotlin"

# コンテナ名（停止時に特定しやすくするため）
CONTAINER_NAME="kotlin-dev"

echo "=== Docker コンテナを再起動します: $CONTAINER_NAME ==="

# もしコンテナが動いていたら停止（エラーが出ても無視）
docker stop $CONTAINER_NAME 2>/dev/null || true

# もしコンテナが残っていたら削除（エラーが出ても無視）
docker rm $CONTAINER_NAME 2>/dev/null || true

# 再度コンテナを起動
docker run -it --rm \
    --name $CONTAINER_NAME \
    -v "$(dirname "$0")/..:/workspace" \
    -w /workspace \
    -p 8080:8080 \
    $IMAGE_NAME

echo "✅ コンテナの再起動が完了しました"
