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

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| content | string     | null: false                    |
| date_on | date       | null: false                    |
| status  | integer    | null: false                    |

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
