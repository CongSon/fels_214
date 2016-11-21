User.create!(name: "Example User",
  email: "admin@gmail.com",
  password_digest: "foobar",
  is_admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.com"
  password_digest = "password"
  User.create!(name: name,
    email: email,
    password_digest: "foobar",
    is_admin: false)
end
