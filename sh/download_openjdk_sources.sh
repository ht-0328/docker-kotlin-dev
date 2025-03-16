#!/bin/bash

# ==========================
# 設定
# ==========================
JAVA_LIB_DIR="${JAVA_HOME}/lib"
TAR_FILE="${JAVA_LIB_DIR}/jdk-17.0.13.11.tar.gz"
UNZIP_DIR="${JAVA_LIB_DIR}/jdk-17.0.13.11"
DOWNLOAD_URL="https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.13%2B11/OpenJDK17U-jdk-sources_17.0.13_11.tar.gz"

# ==========================
# 共通処理
# ==========================
# インストール先のディレクトリを作成
mkdir -p "$JAVA_LIB_DIR"

# ソースコードをダウンロード
if [ ! -f "$TAR_FILE" ]; then
    echo "▶ OpenJDK のソースコードをダウンロードしています..."
    curl -L -o "$TAR_FILE" "$DOWNLOAD_URL"
    echo "✅ ダウンロード完了: $TAR_FILE"
else
    echo "⏩ すでに TAR ファイルが存在します: $TAR_FILE"
fi

# TAR.GZ を解凍
if [ ! -d "$UNZIP_DIR" ]; then
    echo "▶ TAR.GZ ファイルを解凍しています..."
    tar -xzf "$TAR_FILE" -C "$JAVA_LIB_DIR"

    # 実際の解凍フォルダ名を取得（例: "jdk-17.0.13+11"）
    EXTRACTED_DIR=$(find "$JAVA_LIB_DIR" -maxdepth 1 -type d -name "jdk-17.0.13*")

    if [ -d "$EXTRACTED_DIR" ]; then
        mv "$EXTRACTED_DIR" "$UNZIP_DIR"
    fi

    echo "✅ 解凍完了: $UNZIP_DIR"
else
    echo "⏩ すでに解凍済みです: $UNZIP_DIR"
fi

# TAR.GZ を削除
if [ -f "$TAR_FILE" ]; then
    echo "🗑️  不要になった TAR.GZ ファイルを削除しています..."
    rm "$TAR_FILE"
    echo "✅ TAR.GZ ファイルの削除完了"
fi

echo "🚀 すべての処理が完了しました！"
