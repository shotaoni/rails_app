# frozen_string_literal: true

User.create(
  [{ name: 'shotaonizuka', email: 'shota.oni@gmail.com', password: 'hogehoge', admin: true, activated: true }]
)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@example.com"
  password = 'password'
  User.create!(name: name, email: email, password: password, activated: true)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 6)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
