# 日報アプリ

プログラミングスクール向けの日報管理 Web アプリケーションです。講師が生徒ごとの学習記録を作成・管理できます。

## 機能

- **ユーザー認証**: アカウント登録・ログイン・ログアウト
- **日報管理**: 生徒ごとの学習記録を作成・編集・削除
- **生徒管理**: 生徒情報の登録・編集（管理者のみ）
- **権限管理**: 一般ユーザー / 管理者の2段階ロール

## 技術スタック

| カテゴリ | 使用技術 |
|---------|---------|
| バックエンド | Ruby on Rails 7.0 |
| フロントエンド | Tailwind CSS v3 / Turbo (Hotwire) |
| データベース | PostgreSQL |
| 認証 | has_secure_password (BCrypt) |

## セットアップ

### 必要環境

- Ruby 3.x
- PostgreSQL
- Node.js（Tailwind CSS ビルド用）

### インストール手順

```bash
# 依存 gem のインストール
bundle install

# データベースの作成とマイグレーション
bin/rails db:create db:migrate

# シードデータの投入（開発環境）
bin/rails db:seed

# 開発サーバーの起動
bin/dev
```

ブラウザで `http://localhost:3000` を開いてください。

### 開発用アカウント

シードデータ投入後、以下のアカウントが使用できます。

| ロール | メールアドレス | パスワード |
|--------|---------------|-----------|
| 管理者 | admin@example.com | password123 |
| 講師 | teacher@example.com | password123 |

## 権限

| 機能 | 一般ユーザー | 管理者 |
|------|------------|--------|
| 日報の閲覧 | ✅ | ✅ |
| 自分の日報を作成・編集・削除 | ✅ | ✅ |
| 生徒一覧の閲覧 | ✅ | ✅ |
| 生徒の登録・編集・削除 | ❌ | ✅ |

## ディレクトリ構成

```
app/
├── controllers/
│   ├── application_controller.rb  # 認証基底クラス
│   ├── reports_controller.rb      # 日報 CRUD
│   ├── students_controller.rb     # 生徒 CRUD（管理者保護あり）
│   ├── sessions_controller.rb     # ログイン・ログアウト
│   └── users_controller.rb        # アカウント登録
├── models/
│   ├── user.rb                    # ユーザー（role: general/admin）
│   ├── student.rb                 # 生徒（enrollment_status enum）
│   └── report.rb                  # 日報
├── views/
│   ├── layouts/application.html.erb  # 共通レイアウト・ナビゲーション
│   ├── reports/                      # 日報ビュー
│   ├── students/                     # 生徒ビュー
│   ├── sessions/                     # ログイン
│   └── users/                        # アカウント登録
└── helpers/
    ├── application_helper.rb      # flash_class ヘルパー
    └── students_helper.rb         # 在籍状況ラベル・バッジクラス
```
