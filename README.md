# todo-api

[![Build Status](https://travis-ci.org/yuzoiwasaki/todo-api.svg?branch=master)](https://travis-ci.org/yuzoiwasaki/todo-api)
[![Coverage Status](https://coveralls.io/repos/github/yuzoiwasaki/todo-api/badge.svg?branch=master)](https://coveralls.io/github/yuzoiwasaki/todo-api?branch=master)

iOS/AndroidのTODOアプリで使用するAPI実装(Sinatra + MySQL + RSpec)

## API仕様

TODOは下記の3つの要素からなる

- タイトル
- 説明
- ステータス(未完了, 完了)

提供するAPI

- TODO一覧取得API(/todos)
- TODO個別取得API(/todos/:id)
- TODOステータス変更API({"status": 0 or 1}をパラメータとして/todos/:id/statusにPOST)
- TODO新規作成API({"title": "foo", "description": "bar"をパラメータとして/todosにPOST)

## 使い方

### 各種gemのインストール
```
$ bundle install
```

### データベースのセットアップ
```
$ mysql -uroot < db/schema.sql
```
### アプリケーションの起動
```
$ bundle exec rackup
```

http://127.0.0.1:9292/todos からAPIにアクセスできます。
