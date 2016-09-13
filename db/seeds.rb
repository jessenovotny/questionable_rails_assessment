5.times do
  Category.create(name: Faker::Book.genre)
end

5.times do
  User.create(username: Faker::Internet.user_name, password: "password")
end

6.times do
  Question.create(content: Faker::StarWars.quote, user_id: 1)
end

6.times do
  Question.create(content: Faker::StarWars.quote, user_id: 2)
end

6.times do
  Question.create(content: Faker::StarWars.quote, user_id: 3)
end

Questions.all.each do |question|
  counter = rand(1..5)
  question.categories << Category.find(counter)
  question.user = User.find(counter)
  question.answers.build(content: Faker::Hacker.say_something_smart, user_id: counter).save
  if counter.odd?
    question.answers.build(content: Faker::Hacker.say_something_smart, user_id: counter).save
  end
end

10.times do
  Upvote.create(user_id: rand(1..5), answer_id: rand(1..10))
