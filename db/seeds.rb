admin = User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.name = '管理者'
  u.password = 'password123'
  u.role = :admin
end

teacher = User.find_or_create_by!(email: 'teacher@example.com') do |u|
  u.name = '先生 太郎'
  u.password = 'password123'
  u.role = :general
end

students = [
  { name: '田中 花子', admission_date: '2025-04-01', enrollment_status: :active },
  { name: '鈴木 一郎', admission_date: '2025-04-01', enrollment_status: :active },
  { name: '佐藤 次郎', admission_date: '2024-04-01', enrollment_status: :graduated },
].map { |attrs| Student.find_or_create_by!(name: attrs[:name]) { |s| s.assign_attributes(attrs) } }

Report.find_or_create_by!(user: teacher, student: students[0], learning_date: Date.today) do |r|
  r.content = 'Rubyの基礎を学習しました。変数、配列、ハッシュについて理解が深まりました。'
end
