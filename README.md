# アプリケーション名
モチベボタンくん

# アプリケーション概要
今日の気分とタスクを比較してAIがアドバイスをくれるToDo管理アプリ

# URL
https://motivebutton-kun.onrender.com

# テスト用アカウント
- Basic認証ID：pochi
- Basic認証パスワード：0812
- メールアドレス：testuser@test.com
- パスワード：motiveageta1

# 利用方法
## 気分投稿
1．トップページ（一覧ページ）のヘッダーからユーザー新規登録を行う  
2．「今日の気分は？」ボタンから気分を選択して投稿する

## タスク投稿
1．気分を選択して投稿するとタスク投稿ページに遷移する  
2．今日行うタスクを記入して投稿する  
3．登録ボタンを押すとアドバイスが表示される

## タスク管理
1．トップページのカレンダーから今日の日付をクリックすると詳細ページに遷移する  
2．タスクを達成したらチェックマークをつける  
3．すべてのタスクにチェックマークがついたらお褒めのお言葉が表示される

# アプリケーションを作成した背景
学習でつまずいた翌朝、やる気が出なくなってしまう経験を通じて、焦りや不安に振り回される悩みを解決したいと考えたことがきっかけです。  
このアプリを通じて、プログラミングやWebデザインを学習中の方が学習を習慣化できずに挫折しがちな課題を解決し、やるべきことを着実に続けられる力を身につけられるよう支援します。

# 実装した機能についての画像
## トップページ
[![Image from Gyazo](https://i.gyazo.com/2a6683ef6d0efebedbf4dc31a60da247.png)](https://gyazo.com/2a6683ef6d0efebedbf4dc31a60da247)

## 新規登録画面
[![Image from Gyazo](https://i.gyazo.com/83807818cf6f06f62c6eec203f271ce8.png)](https://gyazo.com/83807818cf6f06f62c6eec203f271ce8)

## ログイン画面
[![Image from Gyazo](https://i.gyazo.com/1e98c1ed24ea07c0508e600279c5cf33.png)](https://gyazo.com/1e98c1ed24ea07c0508e600279c5cf33)

## 気分投稿画面
[![Image from Gyazo](https://i.gyazo.com/b97846a2462d4e42881d670331b64d94.png)](https://gyazo.com/b97846a2462d4e42881d670331b64d94)

## タスク投稿画面
[![Image from Gyazo](https://i.gyazo.com/f6782d4e65520e4d78bf0f006f8ebd59.png)](https://gyazo.com/f6782d4e65520e4d78bf0f006f8ebd59)

## 詳細画面
[![Image from Gyazo](https://i.gyazo.com/9b18067458d2b74d9c6abfea8262661f.png)](https://gyazo.com/9b18067458d2b74d9c6abfea8262661f)

## 編集画面
[![Image from Gyazo](https://i.gyazo.com/783776bca2c90c14f972081558d689a5.png)](https://gyazo.com/783776bca2c90c14f972081558d689a5)

# 実装予定の機能
現在、AIのアドバイス機能を実装中。  
今後は、ユーザー情報を編集できる機能を実装予定。

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/23bf56f90772447b35da0d0a563a1637.png)](https://gyazo.com/23bf56f90772447b35da0d0a563a1637)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/38e3172dcb1e848e292d3ffa47ead1f8.png)](https://gyazo.com/38e3172dcb1e848e292d3ffa47ead1f8)

# 開発環境
- フロントエンド：HTML, CSS, JavaScript
- バックエンド：Ruby on Rails
- インフラ：MySQL(開発環境)、PostgreSQL(本番環境)
- テキストエディタ：VS Code
- タスク管理：GitHubプロジェクトボード

# ローカルでの動作方法
以下のコマンドを順に実行。  
% git clone https://github.com/r070624tue/motivebutton_kun  
% cd motivebutton_kun  
% bundle install  
% rails db:create  
% rails db:migrate  

# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association

- has_many :tasks
- has_many :moods

## tasks テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| content   | string     | null: false                    |
| date_on   | date       | null: false                    |
| completed | boolean    | null: false, default: false    |

### Association

- belongs_to :user

## moods テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| score   | integer    | null: false                    |
| date_on | date       | null: false                    |

### Association

- belongs_to :user
