# frozen_string_literal: true

User.create(
  [{ name: 'shotaonizuka', email: 'shota.oni@gmail.com', password: 'hogehoge', admin: true, activated: true }]
)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@example.com"
  password = 'password'
  User.create!(name: name, email: email, password: password)
end
