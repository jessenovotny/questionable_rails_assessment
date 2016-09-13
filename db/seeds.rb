5.times do
  Category.create(name: Faker::Book.genre)
end

5.times do
  User.create(username: Faker::Internet.user_name, password: "password")
end

20.times do
  Question.create(content: Faker::StarWars.quote)
end

Questions.all.each do |question|
  question.categories << Category.find(rand(1..5))
  question.user = User.find(rand(1..5))
  question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save
  question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save if rand(1..3).odd?
  question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save if rand(1..3).odd?
end

10.times do
  User.find(rand(1..5)).upvotes.build(answer_id: rand(1..10)).save
end
