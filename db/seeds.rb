puts 'Removing the health_check...'
HealthCheck.destroy_all
puts 'Removing the clinics...'
Clinic.destroy_all
puts 'Removing the users...'
User.destroy_all
puts 'Removing the set_ups...'
SetUp.destroy_all
puts 'Removing the companies...'
Company.destroy_all

# ===================== 15 clinics=====================
puts 'Creating clinics...'
i = 0
while i < 29
  unless File.readlines('db/clinics.text')[i] == nil
    Clinic.create!(
      name: File.readlines('db/clinics.text')[i],
      address: File.readlines('db/clinics.text')[i + 1]
    )
    i += 2
  end
end
puts "#{Clinic.count} clinics created..."

# =====================1 company=====================
company = Company.create!(
  name: "Google"
)
puts "#{Company.count} company created..."

# ===================== 20 users=====================
puts 'Creating new users...'
first_names = ['蓮', '陽翔', '蒼', '樹', '湊', '朝陽', '碧', '大翔', '律', '暖',
                '陽葵', '紬', '凛', '芽依', '葵', '陽菜', '澪', '莉子', '結菜', '杏']
first_names_roma =['ren', 'haruto', 'aoi', 'ituki', 'minato', 'asahi', 'ao', 'hiroto', 'ritu', 'dan',
                    'himari', 'tumigi', 'rin', 'mei', 'aoi', 'hina', 'mio', 'riko', 'yuina', 'an']
last_names = ['佐藤', '鈴木', '高橋', '田中', '伊藤', '渡辺', '山本', '中村', '小林', '加藤', '清水',
              '佐藤', '鈴木', '高橋', '田中']
last_names_roma = ['sato', 'suzuki', 'takahashi', 'tanaka', 'ito', 'watanabe', 'yamamoto', 'nakamura', 'kobayashi','kato', 'shimizu',
                  'sato', 'suzuki', 'takahashi', 'tanaka']

  i = 0
  while i < 20
  User.create!(
  first_name: first_names[i],
  last_name: last_names[i],
  email: "#{first_names_roma[i]}_#{last_names_roma[i]}@gmail.com",
  password: 123123,
  fax_extension: 100000 + i,
  admin: false,
  company: company
  )
  i += 1
  puts "#{User.count} users created..."
end
User.last.admin = true
puts "#{User.count} users created..."


# =====================1 set up=====================
puts "Creating new set_up..."
set_up = SetUp.create!(
  start_date: Time.local(2022, 9, 1),
  end_date: Time.local(2022, 12, 1),
  company: company
)
puts "#{SetUp.count} set_up created..."
#=====================15 health check with 10 results=====================

puts 'Creating health_checks...'
Clinic.all.each_with_index do |clinic, index|
  HealthCheck.create!(
  user: User.all[index],
  set_up: set_up,
  date: Time.local(2022, 9, 1) + rand(0..90).day,
  clinic: clinic
  )
  puts "#{HealthCheck.count} health_checks created"
end
# HealthCheck.all.first(10).each do |health_check|
#   health_check.result.attach(io: File.open('db/health_check_results'), filename: 'sample.pdf', content_type: 'file/pdf')
# end
