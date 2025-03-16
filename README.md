# Dockerの操作方法

## ビルド方法

### sh実行の権限を付与する

```sh
sudo chmod +x sh/docker-build.sh
```

### shを実行する
```sh
sudo ./sh/docker-build.sh
```

## 実行方法

### sh実行の権限を付与する

```sh
sudo chmod +x sh/docker-restart.sh
```

### shを実行する
```sh
sudo ./sh/docker-restart.sh
```

## コンテナが正常に作成したかを確認する

### Javaが正常にインストールされたか

```sh
java -version
```

### Kotlinが正常にインストールされたか

```sh
kotlin -version
```


### Gradleが正常にインストールされたか

```sh
gradle -v
```


## コンテナから抜ける

```sh
exit
```

## コンテナの一覧を表示する

```sh
docker ps -a
```

## Dockerの未使用データをすべて削除する

```sh
sudo docker system prune -a
```

# Gitの設定方法

## ユーザ名の設定

```sh
git config --global user.name "自身のユーザ名"
```

## メールアドレスの設定

```sh
git config --global user.email "自身のメールアドレス"
```