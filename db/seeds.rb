require 'open-uri'

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
first_names_roma = ['oanh','yayoi', 'mengrui', 'aoi', 'adrian', 'minato', 'gregory', 'patrick', 'hiroto', 'ritu', 'henry',
                    'himari', 'chelsea', 'rin', 'tim', 'aoi', 'naval', 'peter', 'krystle', 'yuina']
# last_names = ['阮', '畠山', '宋', '高橋', '田中', '伊藤', '渡辺', '山本', '中村', '小林', '加藤',
              # '清水', '佐藤', '鈴木', '高橋', '矢部', '田中', '山本', '中村', '伊藤']
last_names_roma = ['nguyen', 'hatakeyama', 'song', 'takahashi', 'monk', 'ito', 'house', 'jane', 'nakamura', 'kobayashi', 'kwon',
                  'shimizu', 'cheung', 'suzuki', 'ferris', 'yabe', 'ravikant', 'attia', 'cho', 'ito']
                  first_names_roma.each_with_index do |first_name, index|
                  file = URI.open("https://source.unsplash.com/featured?profile##{rand(1..1000)}")
  User.create!(
  first_name: first_name,
  last_name: last_names_roma[index],
  email: "#{first_name}_#{last_names_roma[index]}@healthway.live",
  password: 123123,
  fax_extension: 100000 + index,
  admin: false,
  company: company
  ).photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
  puts "#{User.count} users created..."
end

oanh = User.find_by(first_name: 'oanh', last_name: 'nguyen')
oanh.admin = true
oanh.fax_extension = '(+81)3‑3213‑6090'
oanh.email = "oanh_nguyen@healthway.live"
oanh.photo.attach(io: URI.open("https://i.postimg.cc/h4NJkHQS/oanh.jpg"), filename: 'oanh.jpeg', content_type: 'image/jpeg')
oanh.save
puts "#{User.count} users created..."

song = User.find_by(first_name: 'mengrui', last_name: 'song')
song.fax_extension = '(+81)3‑3213‑6099'
song.email = "mengrui_song@healthway.live"
song.photo.attach(io: URI.open("https://i.postimg.cc/PJHCjHb7/song.jpg"), filename: 'song.jpg', content_type: 'image/jpg')
song.save
puts "#{User.count} users created..."

# ===================== set up=====================
puts "Creating new set_up..."
# set_up_2017 = SetUp.create!(
#   start_date: Time.local(2017, 9, 4),
#   end_date: Time.local(2017, 12, 24),
#   company: company
# )

# set_up_2018 = SetUp.create!(
#   start_date: Time.local(2018, 9, 3),
#   end_date: Time.local(2018, 12, 21),
#   company: company
# )

set_up_2019 = SetUp.create!(
  start_date: Time.local(2019, 9, 2),
  end_date: Time.local(2019, 12, 20),
  company: company
)
# =======add new users=========
file = URI.open("https://source.unsplash.com/featured?profile##{rand(1..1000)}")
User.create!(
  first_name: 'tony',
  last_name: 'leng',
  email: "tony_leng@healthway.live",
  password: 123123,
  fax_extension: 111111,
  admin: false,
  company: company
  ).photo.attach(io: URI.open("https://media-exp1.licdn.com/dms/image/C5103AQElW6RLpcTF1Q/profile-displayphoto-shrink_800_800/0/1552818706998?e=1667433600&v=beta&t=X3IiCO42lp7zxX0oS-6lNjPrJloGGdmvvK6K0d3G25Q"), filename: 'tony.png', content_type: 'image/png')
puts "#{User.count} users created..."

file = URI.open("https://source.unsplash.com/featured?profile##{rand(1..1000)}")
User.create!(
  first_name: 'doug',
  last_name: 'berkley',
  email: "doug_berkley@healthway.live",
  password: 123123,
  fax_extension: 222222,
  admin: false,
  company: company
  ).photo.attach(io: URI.open("https://ca.slack-edge.com/T02NE0241-U4APKLFLM-da0b004a3774-512"), filename: 'doug.jpg', content_type: 'image/jpg')
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

# User.all.first(14).each_with_index do |user, index|
#   HealthCheck.create!(
#     user: user,
#     set_up: set_up_2017,
#     date: set_up_2017.start_date + rand(0..90).day,
#     clinic: Clinic.all.sample
#   )
#   puts "#{HealthCheck.count} health_checks created for set_up_2017"
# end
# User.all.first(13).each_with_index do |user, index|
#   HealthCheck.create!(
#     user: user,
#     set_up: set_up_2018,
#     date: set_up_2018.start_date + rand(0..90).day,
#     clinic: Clinic.all.sample
#   )
#   puts "#{HealthCheck.count} health_checks created for set_up_2018"
# end

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
set_ups = [set_up_2019, set_up_2020]
set_ups.each do |set_up|
  set_up.health_checks.each do |health_check|
    file = URI.open('https://www.mhlw.go.jp/bunya/roudoukijun/anzeneisei36/dl/18_01.pdf')
    health_check.result.attach(io: file, filename: 'result.pdf', content_type: 'file/pdf')
  end
end
set_up_2021.health_checks.first(20).each do |health_check|
  file = URI.open('https://www.mhlw.go.jp/bunya/roudoukijun/anzeneisei36/dl/18_01.pdf')
  health_check.result.attach(io: file, filename: 'result.pdf', content_type: 'file/pdf')
end
