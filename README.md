# プログラミングスクール日報アプリ

講師がプログラミングスクールの生徒ごとに学習日報を記録・管理するための Web アプリケーションです。

## 技術スタック

- **Ruby** 3.2.3
- **Rails** 7.0.8
- **PostgreSQL**
- **Tailwind CSS**（Pinterest 風デザインシステム）
- **Hotwire / Turbo**

## 機能

- ユーザー認証（登録・ログイン・ログアウト）
- 日報の作成・閲覧・編集・削除（自分の日報のみ編集・削除可）
- 生徒の管理（管理者のみ登録・編集・削除可）
- 管理者 / 一般ユーザーのロール制御

## ユーザーロール

| ロール | 説明 |
|--------|------|
| `general`（一般） | 日報の閲覧・自分の日報の作成・編集・削除 |
| `admin`（管理者） | 上記に加え、生徒の登録・編集・削除 |

## セットアップ

### 必要環境

- Ruby 3.2.3
- PostgreSQL
- Node.js（Tailwind CSS ビルド用）

### 手順

```bash
# 依存 gem のインストール
bundle install

# データベースの作成とマイグレーション
bin/rails db:create db:migrate

# シードデータの投入（開発用）
bin/rails db:seed

# 開発サーバーの起動
bin/dev
```

アプリは http://localhost:3000 で起動します。

### シードデータのアカウント

`db:seed` 実行後、以下のアカウントでログインできます。

| メールアドレス | パスワード | ロール |
|----------------|------------|--------|
| admin@example.com | password123 | 管理者 |
| teacher@example.com | password123 | 一般 |

## テストの実行

```bash
bin/rails test
```

## データベース構成

```
users       id, name, email, password_digest, role
students    id, name, admission_date, enrollment_status, memo
reports     id, learning_date, content, user_id, student_id
```

## 環境変数

`config/credentials.yml.enc` で管理しています。`RAILS_MASTER_KEY` が必要です。
