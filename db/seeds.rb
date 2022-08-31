puts 'Removing the health_check...'
HealthCheck.destroy_all
puts 'Removing the clinic_set_ups...'
ClinicSetUp.destroy_all
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
# first_names = ['鶯', '弥生', '梦睿', '蒼', '樹', '湊', '朝陽', '碧', '大翔', '律', '暖',
              # '陽葵', '紬', '凛', '芽依', '葵', '陽菜', '澪', '莉子', '結菜']
first_names_roma = ['oanh','yayoi', 'mengrui', 'aoi', 'ituki', 'minato', 'asahi', 'ao', 'hiroto', 'ritu', 'dan',
                    'himari', 'tumigi', 'rin', 'mei', 'aoi', 'hina', 'mio', 'riko', 'yuina']
# last_names = ['阮', '畠山', '宋', '高橋', '田中', '伊藤', '渡辺', '山本', '中村', '小林', '加藤',
              # '清水', '佐藤', '鈴木', '高橋', '矢部', '田中', '山本', '中村', '伊藤']
last_names_roma = ['nguyen', 'hatakeyama', 'song', 'takahashi', 'tanaka', 'ito', 'watanabe', 'yamamoto', 'nakamura', 'kobayashi', 'kato',
                  'shimizu', 'sato', 'suzuki', 'takahashi', 'yabe', 'tanaka', 'yamamoto', 'nakamura', 'ito']
first_names_roma.each_with_index do |first_name, index|
  User.create!(
  first_name: first_name,
  last_name: last_names_roma[index],
  email: "#{first_name}_#{last_names_roma[index]}@gmail.com",
  password: 123123,
  fax_extension: 100000 + index,
  admin: false,
  company: company
  )
  puts "#{User.count} users created..."
end
oanh = User.find_by(first_name: 'oanh', last_name: 'nguyen')
oanh.admin = true
oanh.save
puts "#{User.count} users created..."


# ===================== set up=====================
puts "Creating new set_up..."
set_up_2017 = SetUp.create!(
  start_date: Time.local(2017, 9, 4),
  end_date: Time.local(2017, 12, 24),
  company: company
)

set_up_2018 = SetUp.create!(
  start_date: Time.local(2018, 9, 3),
  end_date: Time.local(2018, 12, 21),
  company: company
)

set_up_2019 = SetUp.create!(
  start_date: Time.local(2019, 9, 2),
  end_date: Time.local(2019, 12, 20),
  company: company
)
# =======add new users=========
User.create!(
  first_name: 'tony',
  last_name: 'leng',
  email: "tony_leng@gmail.com",
  password: 123123,
  fax_extension: 111111,
  admin: false,
  company: company
  )
  puts "#{User.count} users created..."

User.create!(
  first_name: 'doug',
  last_name: 'berkley',
  email: "doug_berkley@gmail.com",
  password: 123123,
  fax_extension: 222222,
  admin: false,
  company: company
  )
puts "#{User.count} users created..."
# ================
set_up_2020 = SetUp.create!(
  start_date: Time.local(2020, 9, 7),
  end_date: Time.local(2020, 12, 18),
  company: company
)
set_up_2021 = SetUp.create!(
  start_date: Time.local(2021, 9, 6),
  end_date: Time.local(2021, 12, 24),
  company: company
)
puts company.users.count
puts "#{SetUp.count} set_up created..."

#=====================15 clinic_set_up=====================
puts 'Creating health_checks...'
SetUp.all.each do |set_up|
  Clinic.all.each do |clinic|
    ClinicSetUp.create!(
      clinic: clinic,
      set_up: set_up
    )
  end
end

puts "#{SetUp.count} set_up created..."
#=====================health check=====================

puts 'Creating health_checks...'

User.all.first(14).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2017,
    date: set_up_2017.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2017"
end
User.all.first(13).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2018,
    date: set_up_2018.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2018"
end

User.all.first(16).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2019,
    date: set_up_2019.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2019"
end

User.all.first(18).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2020,
    date: set_up_2020.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2020"
end

User.all.first(21).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2021,
    date: set_up_2021.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2021"
end

puts "Adding results to health check..."
set_ups = [set_up_2017, set_up_2018, set_up_2019, set_up_2020]
set_ups. each do |set_up|
  set_up.health_checks.each do |health_check|
    file = URI.open('https://www.mhlw.go.jp/bunya/roudoukijun/anzeneisei36/dl/18_01.pdf')
    health_check.result.attach(io: file, filename: 'result.pdf', content_type: 'file/pdf')
  end
end
set_up_2021.health_checks.first(20).each do |health_check|
  file = URI.open('https://www.mhlw.go.jp/bunya/roudoukijun/anzeneisei36/dl/18_01.pdf')
  health_check.result.attach(io: file, filename: 'result.pdf', content_type: 'file/pdf')
end
