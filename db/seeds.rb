User.create(
    [{ name: 'shotaonizuka', email: 'shota.oni@gmail.com', password: 'hogehoge' }]
)

99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password = "password"
    User.create!(name: name, email: email, password: password)
end