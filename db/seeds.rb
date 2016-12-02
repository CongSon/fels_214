User.create!(name: "Example User",
  email: "admin@gmail.com",
  password: "password",
  password_confirmation: "password",
  is_admin: true,
  created_at: "2016-11-20 00:00:00",
  updated_at: "2016-11-20 00:00:00")

2.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  password_confirmation = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    is_admin: false,
    created_at: "2016-11-21 00:0#{n}:00",
    updated_at: "2016-11-21 00:0#{n}:00")
end

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+3}@gmail.com"
  password = "password"
  password_confirmation = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    is_admin: false,
    created_at: "2016-11-22 00:0#{n}:00",
    updated_at: "2016-11-22 00:0#{n}:00")
end

4.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+8}@gmail.com"
  password = "password"
  password_confirmation = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    is_admin: false,
    created_at: "2016-11-23 00:0#{n}:00",
    updated_at: "2016-11-23 00:0#{n}:00")
end

7.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+12}@gmail.com"
  password = "password"
  password_confirmation = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    is_admin: false,
    created_at: "2016-11-24 00:0#{n}:00",
    updated_at: "2016-11-24 00:0#{n}:00")
end

3.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+19}@gmail.com"
  password = "password"
  password_confirmation = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    is_admin: false,
    created_at: "2016-11-25 00:0#{n}:00",
    updated_at: "2016-11-25 00:0#{n}:00")
end
2.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+22}@gmail.com"
  password = "password"
  password_confirmation = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    is_admin: false,
    created_at: "2016-11-26 00:0#{n}:00",
    updated_at: "2016-11-26 00:0#{n}:00")
end

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+24}@gmail.com"
  password = "password"
  password_confirmation = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation,
    is_admin: false,
    created_at: "2016-11-27 00:0#{n}:00",
    updated_at: "2016-11-27 00:0#{n}:00")
end

10.times do |n|
  Category.create!(name: "Category #{n+1}",
    description: "This is category #{n+1}",
    created_at: "2016-11-20 00:0#{n}:00",
    updated_at: "2016-11-20 00:0#{n}:00")
end

20.times do |n|
  Word.create!(
    content: "word #{n+1}",
    category_id: 1,
    created_at: "2016-11-20 00:1#{n}:00",
    updated_at: "2016-11-20 00:1#{n}:00",
    answers_attributes:
      [
        {
          content: "ansers 1",
          is_correct: false,
          created_at: "2016-11-20 00:1#{n}:00",
          updated_at: "2016-11-20 00:1#{n}:00"
        },
        {
          content: "ansers 2",
          is_correct: true,
          created_at: "2016-11-20 00:1#{n}:00",
          updated_at: "2016-11-20 00:1#{n}:00"
        },
        {
          content: "ansers 3",
          is_correct: false,
          created_at: "2016-11-20 00:1#{n}:00",
          updated_at: "2016-11-20 00:1#{n}:00"
        },
        {
          content: "ansers 4",
          is_correct: false,
          created_at: "2016-11-20 00:1#{n}:00",
          updated_at: "2016-11-20 00:1#{n}:00"
        }
      ]
  )
end

30.times do |n|
  Word.create!(
    content: "word #{n+21}",
    category_id: 2,
    created_at: "2016-11-20 00:1#{n}:00",
    updated_at: "2016-11-20 00:1#{n}:00",
    answers_attributes:
      [
        {
          content: "ansers 1",
          is_correct: false,
          created_at: "2016-11-20 00:1#{n}:00",
          updated_at: "2016-11-20 00:1#{n}:00"
        },
        {
          content: "ansers 2",
          is_correct: false,
          created_at: "2016-11-20 00:1#{n}:00",
          updated_at: "2016-11-20 00:1#{n}:00"
        },
        {
          content: "ansers 3",
          is_correct: true,
          created_at: "2016-11-20 00:1#{n}:00",
          updated_at: "2016-11-20 00:1#{n}:00"
        },
        {
          content: "ansers 4",
          is_correct: false,
          created_at: "2016-11-20 00:1#{n}:00",
          updated_at: "2016-11-20 00:1#{n}:00"
        }
      ]
  )
end

7.times do |m|
  Random.rand(4).times do |n|
    Lesson.create!(
      category_id: 1,
      is_complete: true,
      user_id: 2,
      created_at: "2016-11-#{21+m} 00:1#{n}:00",
      updated_at: "2016-11-#{21+m} 00:1#{n+1}:00")
  end

  Random.rand(4).times do |n|
    Lesson.create!(
      category_id: 2,
      is_complete: true,
      user_id: 3,
      created_at: "2016-11-#{21+m} 00:1#{n}:00",
      updated_at: "2016-11-#{21+m} 00:1#{n+1}:00")
  end
  Random.rand(4).times do |n|
    Lesson.create!(
      category_id: 1,
      is_complete: true,
      user_id: 4,
      created_at: "2016-11-#{21+m} 00:1#{n}:00",
      updated_at: "2016-11-#{21+m} 00:1#{n+1}:00")
  end
end

users = User.all
user  = users.second
following = users[3..20]
followers = users[4..20]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
