#!/bin/bash

# ==========================
# 設定
# ==========================
TARGET_DIR="${JAVA_HOME}/lib"

declare -A SPRING_SOURCES=(
    ["spring-boot"]="https://github.com/spring-projects/spring-boot/archive/refs/tags/v3.4.3.zip"
    ["spring-framework"]="https://github.com/spring-projects/spring-framework/archive/refs/tags/v6.2.4.zip"
)

# ==========================
# 共通処理
# ==========================
# インストール先のディレクトリを作成
mkdir -p "$TARGET_DIR"

for PROJECT in "${!SPRING_SOURCES[@]}"; do
    ZIP_FILE="${TARGET_DIR}/${PROJECT}.zip"
    UNZIP_DIR="${TARGET_DIR}/${PROJECT}"

    # ZIP をダウンロード
    if [ ! -f "$ZIP_FILE" ]; then
        echo "▶ ${PROJECT} のソースコードをダウンロードしています..."
        curl -L -o "$ZIP_FILE" "${SPRING_SOURCES[$PROJECT]}"
        echo "✅ ダウンロード完了: $ZIP_FILE"
    else
        echo "⏩ すでに ZIP ファイルが存在します: $ZIP_FILE"
    fi

    # ZIP を解凍
    if [ ! -d "$UNZIP_DIR" ]; then
        echo "▶ ${PROJECT} の ZIP を解凍しています..."
        unzip -o "$ZIP_FILE" -d "$TARGET_DIR"

        # 解凍後のディレクトリ名を修正（例: spring-boot-3.4.3 → spring-boot）
        EXTRACTED_DIR=$(find "$TARGET_DIR" -maxdepth 1 -type d -name "${PROJECT}-*")
        if [ -d "$EXTRACTED_DIR" ]; then
            mv "$EXTRACTED_DIR" "$UNZIP_DIR"
        fi
        echo "✅ 解凍完了: $UNZIP_DIR"
    else
        echo "⏩ すでに解凍済みです: $UNZIP_DIR"
    fi

    # ZIP を削除
    if [ -f "$ZIP_FILE" ]; then
        echo "🗑️  不要になった ZIP ファイルを削除しています..."
        rm "$ZIP_FILE"
        echo "✅ ZIP ファイルの削除完了"
    fi

    echo "🎉 ${PROJECT} の取得が完了しました！"
done

echo "🚀 すべての処理が完了しました！"
