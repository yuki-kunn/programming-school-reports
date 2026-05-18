# ============================================================
# 本番・開発共通: マスタデータ（タグ）
# ============================================================
Tag.find_or_create_by!(name: 'FS')
Tag.find_or_create_by!(name: 'LEGO')
Tag.find_or_create_by!(name: 'mbot2')

puts "タグを作成しました（FS / LEGO / mbot2）"

# ============================================================
# 本番用: 管理者ユーザー
# ============================================================
yuki_admin = User.find_or_initialize_by(email: 'hokuyoyuki@gmail.com')
yuki_admin.name = '管理者' if yuki_admin.name.blank?
yuki_admin.password = ENV.fetch('YUKI_ADMIN_PASSWORD', 'ChangeMe2025!') if yuki_admin.new_record?
yuki_admin.role = :superadmin
yuki_admin.save!

puts "本番管理者: hokuyoyuki@gmail.com (role=superadmin)"

# ============================================================
# 開発環境のみ: ダミーデータ
# ============================================================
unless Rails.env.production?
  admin = User.find_or_create_by!(email: 'admin@example.com') do |u|
    u.name = '管理者'
    u.password = 'password123'
    u.role = :admin
  end

  teacher = User.find_or_create_by!(email: 'teacher@example.com') do |u|
    u.name = '鈴木 先生'
    u.password = 'password123'
    u.role = :general
  end

  fs_tag   = Tag.find_by!(name: 'FS')
  lego_tag = Tag.find_by!(name: 'LEGO')
  mbot_tag = Tag.find_by!(name: 'mbot2')

  students = [
    { name: '田中 花子', admission_date: '2025-04-01', enrollment_status: :active,    tag: fs_tag },
    { name: '佐藤 一郎', admission_date: '2025-04-01', enrollment_status: :active,    tag: lego_tag },
    { name: '山田 次郎', admission_date: '2024-04-01', enrollment_status: :graduated, tag: mbot_tag },
  ].map do |attrs|
    student = Student.find_or_initialize_by(name: attrs[:name])
    student.assign_attributes(attrs)
    student.save!
    student
  end

  [
    { student: students[0], content: "Rubyの変数とデータ型について学習しました。特に配列とハッシュの違いを理解できました。次回はメソッドの定義を学ぶ予定です。", learning_date: Date.today },
    { student: students[1], content: "HTMLとCSSの基礎を学びました。Flexboxを使ったレイアウトの組み方が理解できてきました。", learning_date: Date.today - 1 },
    { student: students[0], content: "条件分岐とループ処理を学習しました。if/elsif/else文とeach文を使った実装ができるようになりました。", learning_date: Date.today - 2 },
  ].each do |attrs|
    Report.find_or_create_by!(user: teacher, student: attrs[:student], learning_date: attrs[:learning_date]) do |r|
      r.content = attrs[:content]
    end
  end

  puts "開発用ダミーデータを作成しました"
  puts "管理者: admin@example.com / password123"
  puts "講師:   teacher@example.com / password123"
end
