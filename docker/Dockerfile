# Ubuntuリリースノート: https://wiki.ubuntu.com/Releases
# ベースイメージ:Ubuntu 24:04
FROM ubuntu:24.04

# パッケージのインストール時に対話的なプロンプトが表示されないように設定する
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージのインストール
RUN set -eux && \ 
    apt-get update && \
    apt-get install -y \
    # bashコマンド補完
    bash-completion \
    # treeコマンド
    tree \
    # 基本的な開発ツール
    build-essential \  
    # URLからデータを転送するためのツール
    curl \
    # バージョン管理システム
    git \
    # テキストエディタ  
    vim \
    # 圧縮ツール
    zip \  
    # 解凍ツール
    unzip \
    # 圧縮アーカイブツール
    tar \  
    # ファイル間の差分を表示するためのツール
    diffutils \
    # ファイルやディレクトリを検索するためのツール
    findutils \
    # ファイルを圧縮・解凍するためのツール
    gzip \
    # コマンドラインで使用するGitリポジトリビューア
    tig \
    # コマンドの実行ファイルの場所を表示するためのツール
    which && \ 
    # APTキャッシュのクリーンアップ
    apt-get clean && \
    # APTリポジトリのメタデータを削除してディスクスペースを節約
    rm -rf /var/lib/apt/lists/*

###### JDKのダウンロード ######

# 環境変数の設定
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# JDKダウンロード先(Adoptium)のURL: https://github.com/adoptium/temurin17-binaries/releases/
# OpenJDKをダウンロードするURL
ARG OPEN_JDK_DOWNLOAD_URL=https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.13%2B11/OpenJDK17U-jdk_x64_linux_hotspot_17.0.13_11.tar.gz

# OpenJDKの一時保存先
ARG TEMP_OPEN_JDK_DOWNLOAD_DIR=/tmp/openjdk.tar.gz

# OpenJDKのダウンロードとインストール
RUN set -eux && \
    # OpenJDKを指定されたURLからダウンロードし、一時ディレクトリに保存
    curl -L -o ${TEMP_OPEN_JDK_DOWNLOAD_DIR} ${OPEN_JDK_DOWNLOAD_URL} && \
    # インストール先のディレクトリを作成
    mkdir -p ${JAVA_HOME} && \
    # ダウンロードしたtar.gzファイルを解凍し、指定ディレクトリに展開
    tar -xzf ${TEMP_OPEN_JDK_DOWNLOAD_DIR} -C ${JAVA_HOME} --strip-components 1 && \
    # 解凍後、一時ファイルを削除
    rm ${TEMP_OPEN_JDK_DOWNLOAD_DIR}

# Kotlinコンパイラダウンロード先URL: https://github.com/JetBrains/kotlin/releases/download/
# Kotlinコンパイラのダウンロードとインストール
ARG BASE_URL_KOTLIN=https://github.com/JetBrains/kotlin/releases/download/
# Kotlinコンパイラのバージョン
ARG KOTLIN_VERSION=2.1.10
# Kotlinコンパイラのファイル名
ARG KOTLIN_FILE_NAME=kotlin-compiler-${KOTLIN_VERSION}.zip

# Kotlinのダウンロード
RUN set -eux && \
    # Kotlinコンパイラを指定されたURLからダウンロードし、一時ディレクトリに保存
    curl -L -o /tmp/kotlin-compiler.zip ${BASE_URL_KOTLIN}/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip && \
    # ダウンロードしたZIPファイルを解凍し、指定ディレクトリに展開
    unzip /tmp/kotlin-compiler.zip -d /opt/kotlin && \
    # 解凍後、一時ファイルを削除
    rm /tmp/kotlin-compiler.zip

# 環境変数の設定
ENV KOTLIN_HOME=/opt/kotlin/kotlin-compiler-${KOTLIN_VERSION}
ENV PATH="${KOTLIN_HOME}/bin:${PATH}"



# Gradleのダウンロード
ARG GRADLE_VERSION=8.13
ARG BASE_URL_GRADLE=https://services.gradle.org/distributions
ARG GRADLE_FILE_NAME=gradle-${GRADLE_VERSION}-bin.zip

RUN set -eux && \
    # Gradleを指定されたURLからダウンロードし、一時ディレクトリに保存
    curl -L -o /tmp/gradle.zip ${BASE_URL_GRADLE}/gradle-${GRADLE_VERSION}-bin.zip && \
    # ダウンロードしたZIPファイルを解凍し、指定ディレクトリに展開
    unzip /tmp/gradle.zip -d /opt/gradle && \
    # 解凍後、一時ファイルを削除
    rm /tmp/gradle.zip

# 環境変数の設定
ENV GRADLE_HOME=/opt/gradle/gradle-${GRADLE_VERSION}
ENV PATH="${GRADLE_HOME}/bin:${PATH}"


WORKDIR /workspace

ENV LANG=C.UTF-8

ENV DEVCONTAINER=true