### SEED CATEGORIES ####

# 5.times do
#   Category.create(name: Faker::Book.genre)
# end

### SEED USERS ####

# 5.times do
#   User.create(username: Faker::Internet.user_name, password: "password")
# end

### SEED QUESTIONS PER USER ####

# 20.times do
#   User.find(rand(1..5)).questions.build(content: Faker::StarWars.quote).save
# end

### SEED UPVOTES ####

# Question.all.each do |question|
#   question.categories << Category.find(rand(1..5))
#   question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save
#   question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save if rand(1..3).odd?
#   question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..5)).save if rand(1..3).odd?
# end

### SEED UPVOTES ####
100.times do
  # binding.pry
  Question.newest.take(3).each{|question| question.answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..5)).id).save}}

  Question.oldest.take(3).each{|question| question.answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..5)).id).save}}

  Question.most_answers.take(3).each{|question| question.answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..5)).id).save}}

  # Question.find_by(id: rand(169..179)).answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..80)).id).save}
  # Upvote.create(voter_id: User.find_by(id: rand(1..80).id, answer_id: )
  # User.find_by(id: rand(1..80)).upvotes.build(answer_id: rand(1..500)).save
end
