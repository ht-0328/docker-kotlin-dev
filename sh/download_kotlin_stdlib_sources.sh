#!/bin/bash

# ==========================
# 設定
# ==========================
JAVA_LIB_DIR="${JAVA_HOME}/lib"
ZIP_FILE="${JAVA_LIB_DIR}/kotlin-stdlib-2.1.10.zip"
UNZIP_DIR="${JAVA_LIB_DIR}/kotlin-stdlib-2.1.10"
DOWNLOAD_URL="https://github.com/JetBrains/kotlin/archive/refs/tags/v2.1.10.zip"

# ==========================
# 共通処理
# ==========================
# インストール先のディレクトリを作成
mkdir -p "$JAVA_LIB_DIR"

# ZIP をダウンロード
if [ ! -f "$ZIP_FILE" ]; then
    echo "Kotlin 標準ライブラリのソースコードをダウンロードしています..."
    curl -L -o "$ZIP_FILE" "$DOWNLOAD_URL"
    echo "ダウンロード完了: $ZIP_FILE"
else
    echo "すでに ZIP ファイルが存在します: $ZIP_FILE"
fi

# ZIP を解凍
if [ ! -d "$UNZIP_DIR" ]; then
    echo "ZIP ファイルを解凍しています..."
    unzip -o "$ZIP_FILE" -d "$JAVA_LIB_DIR"

    # 実際の解凍フォルダ名を取得（例: "kotlin-2.1.10"）
    EXTRACTED_DIR=$(find "$JAVA_LIB_DIR" -maxdepth 1 -type d -name "kotlin-*")

    if [ -d "$EXTRACTED_DIR" ]; then
        mv "$EXTRACTED_DIR" "$UNZIP_DIR"
    fi

    echo "解凍完了: $UNZIP_DIR"
else
    echo "すでに解凍済みです: $UNZIP_DIR"
fi

# ZIP を削除
if [ -f "$ZIP_FILE" ]; then
    echo "不要になった ZIP ファイルを削除しています..."
    rm "$ZIP_FILE"
    echo "ZIP ファイルの削除完了"
fi

echo "すべての処理が完了しました！"
