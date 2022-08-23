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
first_names = ['畠山', '梦睿', '蒼', '樹', '湊', '朝陽', '碧', '大翔', '律', '暖',
              '陽葵', '紬', '凛', '芽依', '葵', '陽菜', '澪', '莉子', '結菜', '鶯']
first_names_roma = ['hatakeyama', 'mengrui', 'aoi', 'ituki', 'minato', 'asahi', 'ao', 'hiroto', 'ritu', 'dan',
                    'himari', 'tumigi', 'rin', 'mei', 'aoi', 'hina', 'mio', 'riko', 'yuina', 'oanh']
last_names = ['弥生', '宋', '高橋', '田中', '伊藤', '渡辺', '山本', '中村', '小林', '加藤',
              '清水', '佐藤', '鈴木', '高橋', '矢部', '田中', '山本', '中村', '伊藤', '阮']
last_names_roma = ['yayoi', 'song', 'takahashi', 'tanaka', 'ito', 'watanabe', 'yamamoto', 'nakamura', 'kobayashi', 'kato',
                  'shimizu', 'sato', 'suzuki', 'takahashi', 'yabe', 'tanaka', 'yamamoto', 'nakamura', 'ito', 'nguyen']
first_names.each_with_index do |first_name, index|
  User.create!(
  first_name: first_name,
  last_name: last_names[index],
  email: "#{first_names_roma[index]}_#{last_names_roma[index]}@gmail.com",
  password: 123123,
  fax_extension: 100000 + index,
  admin: false,
  company: company
  )
  puts "#{User.count} users created..."
end
oanh = User.find_by(first_name: '鶯', last_name: '阮')
oanh.admin = true
oanh.save
puts "#{User.count} users created..."


# =====================3 set up=====================
puts "Creating new set_up..."
set_up_2020 = SetUp.create!(
  start_date: Time.local(2020, 7, 1),
  end_date: Time.local(2020, 10, 1),
  company: company
)
set_up_2021 = SetUp.create!(
  start_date: Time.local(2021, 7, 1),
  end_date: Time.local(2021, 10, 1),
  company: company
)
set_up_2022 = SetUp.create!(
  start_date: Time.local(2022, 7, 1),
  end_date: Time.local(2022, 10, 1),
  company: company
)
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
#=====================15 health check with 10 results=====================
require 'open-uri'

puts 'Creating health_checks...'

User.all.first(15).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2020,
    date: set_up_2020.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2020"
end
User.all.first(19).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2021,
    date: set_up_2021.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2021"
end
User.all.first(4).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2022,
    date: set_up_2022.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2022"
end

puts "Adding results to health check..."
set_up_2020.health_checks.each do |health_check|
    file = URI.open('https://www.mhlw.go.jp/bunya/roudoukijun/anzeneisei36/dl/18_01.pdf')
    health_check.result.attach(io: file, filename: 'result.pdf', content_type: 'file/pdf')
end
set_up_2021.health_checks.each do |health_check|
  file = URI.open('https://www.mhlw.go.jp/bunya/roudoukijun/anzeneisei36/dl/18_01.pdf')
  health_check.result.attach(io: file, filename: 'result.pdf', content_type: 'file/pdf')
end

file = URI.open('https://www.mhlw.go.jp/bunya/roudoukijun/anzeneisei36/dl/18_01.pdf')
set_up_2022.health_checks.first.result.attach(io: file, filename: 'result.pdf', content_type: 'file/pdf')
