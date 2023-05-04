require 'open-uri'
require 'faker'
require 'json'

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

# ===================== 14 clinics=====================
puts 'Creating clinics...'
i = 0
while i < 27
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

# ===================== 52 users=====================
puts 'Creating manual users...'

manual_users = [
  ['oanh', 'nguyen', "https://i.postimg.cc/h4NJkHQS/oanh.jpg"],
  ['yayoi', 'hatakeyama', "https://i.postimg.cc/50d2VgXp/yaya.jpg"],
  ['mengrui', 'song', "https://i.postimg.cc/PJHCjHb7/song.jpg"],
  ['tony', 'leng', "https://static.wikia.nocookie.net/marvelcentral/images/9/97/Tony-Stark.jpg/revision/latest?cb=20130429010603"],
  ['doug', 'berkley', "https://ca.slack-edge.com/T02NE0241-U4APKLFLM-da0b004a3774-512"]
]

manual_users.each_with_index do |user, index|
  file = URI.open(user[2])
  User.create!(
    first_name: user[0],
    last_name: user[1],
    email: "#{user[0]}_#{user[1]}@healthway.live",
    password: 123123,
    fax_extension: "(+81)33-2136-10#{index}",
    company: company
  ).photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
  puts "#{User.count} users created..."
end

oanh = User.find_by(first_name: 'oanh', last_name: 'nguyen')
oanh.admin = true
oanh.save
puts "#{User.count} users created..."

# ==========
puts 'Creating Japanese users with photo...'

photo_japanese_users = [
  ['ori', 'konuma'],
  ['himeka', 'kishi'],
  ['konomi', 'hironaka'],
  ['ine', 'fukunaga'],
  ['kana', 'katayama'],

  ['wakano', 'motozawa'],
  ['aya', 'ogino'],
  ['arisu', 'tazawa'],
  ['nishi', 'fukunaga'],
  ['agasa', 'yuguchi'],

  ['matsuko', 'takeshita'],
  ['junko', 'horie'],
  ['miyoshi', 'kotake'],
  ['masae', 'mase'],
  ['saki', 'miura']
]

photo_japanese_users.each do |user|
  file = URI.open("https://source.unsplash.com/featured?profile&#{user[0]}##{rand(1..1000)}")
  User.create!(
    first_name: user[0],
    last_name: user[1],
    email: "#{user[0]}_#{user[1]}@healthway.live",
    password: 123123,
    company: company
  ).photo.attach(io: file, filename: 'user.png', content_type: 'image/jpg')
  puts "#{User.count} users created..."
end

# ==========
puts 'Creating no-photo Japanese users...'

no_photo_japanese_users = [
  ['atsushi', 'hashimoto'],
  ['sakiko', 'wada'],
  ['hinako', 'ito'],
  ['sawa', 'kotani'],
  ['aya', 'kubota'],

  ['ruri', 'okamoto'],
  ['takeo', 'yamamoto'],
  ['kayako', 'koda'],
  ['mariko', 'oshima'],
  ['kenta', 'kiyomizu'],

  ['hachiro', 'sakuta'],
  ['rieko', 'ogawa'],
  ['riho', 'mori'],
  ['eiji', 'ishibashi'],
  ['akio', 'shimura']
]

no_photo_japanese_users.each do |user|
  file = URI.open("https://ui-avatars.com/api/?background=random&name=#{user[0]}+#{user[1]}")
  User.create!(
    first_name: user[0],
    last_name: user[1],
    email: "#{user[0]}_#{user[1]}@healthway.live",
    password: 123123,
    company: company
  ).photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
  puts "#{User.count} users created..."
end


# ==========
puts 'Creating English name users...'
english_users = []
17.times do
  user = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  }
  english_users << user
end
puts "Created #{english_users.count} English users"

english_users.each do |user|
  file = URI.open("https://source.unsplash.com/featured?profile&#{user[:first_name]}##{rand(1..1000)}")
  User.create!(
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: "#{user[:first_name]}_#{user[:last_name]}@healthway.live",
    password: 123123,
    company: company
  ).photo.attach(io: file, filename: 'user.png', content_type: 'image/jpg')
  puts "#{User.count} users created..."
end


# ===================== set up=====================
puts "Creating new set_up..."

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

User.all.first(47).each_with_index do |user, index|
  HealthCheck.create!(
    user: user,
    set_up: set_up_2021,
    date: set_up_2021.start_date + rand(0..90).day,
    clinic: Clinic.all.sample
  )
  puts "#{HealthCheck.count} health_checks created for set_up_2021"
end

puts "Adding results to health check..."
set_up_2021.health_checks.first(43).each do |health_check|
  file = URI.open('https://www.mhlw.go.jp/bunya/roudoukijun/anzeneisei36/dl/18_01.pdf')
  health_check.result.attach(io: file, filename: 'result.pdf', content_type: 'file/pdf')
end



# # first_names = ['鶯', '弥生', '梦睿', '蒼', '樹', '湊', '朝陽', '碧', '大翔', '律', '暖',
#               # '陽葵', '紬', '凛', '芽依', '葵', '陽菜', '澪', '莉子', '結菜']
# first_names_roma = ['aoi', 'adrian', 'minato', 'gregory', 'patrick', 'hiroto', 'ritu', 'henry',
#                     'himari', 'chelsea', 'rin']
# # last_names = ['阮', '畠山', '宋', '高橋', '田中', '伊藤', '渡辺', '山本', '中村', '小林', '加藤',
#               # '清水', '佐藤', '鈴木', '高橋', '矢部', '田中', '山本', '中村', '伊藤']
# last_names_roma = ['takahashi', 'monk', 'ito', 'house', 'jane', 'nakamura', 'kobayashi', 'kwon',
#                   'shimizu', 'cheung', 'suzuki']
# first_names_roma.each_with_index do |first_name, index|
#   file = URI.open("https://source.unsplash.com/featured?profile##{rand(1..1000)}")
#   User.create!(
#   first_name: first_name,
#   last_name: last_names_roma[index],
#   email: "#{first_name}_#{last_names_roma[index]}@healthway.live",
#   password: 123123,
#   fax_extension: 81332136100 + index,
#   admin: false,
#   company: company
#   ).photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
#   puts "#{User.count} users created..."
# end

# puts 'Creating no-photo English name users...'
# no_photo_first_name = ['tim', 'aoi', 'naval', 'peter', 'krystle', 'yuina']
# no_photo_last_name = ['ferris', 'yabe', 'ravikant', 'attia', 'cho', 'ito']

# no_photo_first_name.each_with_index do |first_name, index|
#   file = URI.open("https://ui-avatars.com/api/?background=random&name=#{first_name}+#{no_photo_last_name[index]}")
#   User.create!(
#     first_name: first_name,
#     last_name: no_photo_last_name[index],
#     email: "#{first_name}_#{no_photo_last_name[index]}@healthway.live",
#     password: 123123,
#     fax_extension:  + index,
#     admin: false,
#     company: company
#   ).photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
#   puts "#{User.count} users created..."
# end

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
# set_up_2019 = SetUp.create!(
#   start_date: Time.local(2019, 9, 2),
#   end_date: Time.local(2019, 12, 20),
#   company: company
# )
# set_up_2020 = SetUp.create!(
#   start_date: Time.local(2020, 9, 7),
#   end_date: Time.local(2020, 12, 18),
#   company: company
# )
