### SEED CATEGORIES ####

10.times do
  Category.create(name: Faker::Book.genre)
end

### SEED USERS ####

10.times do
  User.create(username: Faker::Internet.user_name, password: "password")
end

### SEED QUESTIONS PER USER ####

30.times do
  User.find(rand(1..10)).questions.build(content: Faker::StarWars.quote).save
end

### SEED CATEGORIES & ANSWERS PER QUESTION ####

Question.all.each do |question|
  question.categories << Category.find(rand(1..5))
  question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save
  question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save if rand(1..3).odd?
  question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save if rand(1..3).odd?
end

### SEED UPVOTES PER ANSWER OF TOP SEARCH RESULT FILTERS ####
100.times do
  Question.newest.take(3).each{|question| question.answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..5)).id).save}}

  Question.oldest.take(3).each{|question| question.answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..5)).id).save}}

  Question.most_answered.take(3).each{|question| question.answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..5)).id).save}}
end
