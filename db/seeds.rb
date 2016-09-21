### SEED CATEGORIES ####

10.times do
  Category.create(name: Faker::Book.genre)
end

### SEED USERS ####

30.times do
  User.create(username: Faker::Internet.user_name, password: "password")
end

### SEED QUESTIONS PER USER ####

40.times do
  User.find(rand(1..30)).questions.build(content: Faker::StarWars.quote).save
end

### SEED CATEGORIES & ANSWERS PER QUESTION ####

Question.all.each do |question|
  6.times do
    category = Category.find_by(id: rand(1..10))
    question.categories << category unless question.categories.include?(category) || category.nil? || rand(1..3).even?
  end

  10.times do
    question.answers.build(content: Faker::Hacker.say_something_smart, user_id: rand(1..10)).save if rand(1..3).odd?
  end

  question.answers.each do |answer| 
    10.times do 
      answer.upvotes.build(voter_id: User.find_by(id: rand(1..30)).id).save if rand(1..2).odd?
    end
  end
end

### SEED UPVOTES PER ANSWER OF TOP SEARCH RESULT FILTERS ####


# 100.times do
#   Question.oldest.each{|question| question.answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..20)).id).save}}
# end

# 100.times do
#   Question.most_answered.each{|question| question.answers.each{|answer| answer.upvotes.build(voter_id: User.find_by(id: rand(1..20)).id).save}}
# end
