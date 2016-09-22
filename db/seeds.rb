### CLEAR DB FIRST ###
DatabaseCleaner.clean_with(:truncation)

### SEED CATEGORIES ####

15.times do
  Category.create(name: Faker::Book.genre)
end

### SEED USERS ####

40.times do
  User.create(username: Faker::Internet.user_name, password: "password")
end

### SEED QUESTIONS PER USER ####

User.all.each do |user|
  rand(1..6).times do
    unless user.questions.build(content: Faker::StarWars.quote).save
      user.questions.build(content: Faker::Hipster.sentence).save
    end
  end
end

### SEED CATEGORIES, ANSWERS, AND FAVORITES PER QUESTION ####

Question.all.each do |question|
  rand(1..5).times do
    category = Category.find_by(id: rand(1..15))
    question.categories << category unless question.categories.include?(category) || category.nil?
  end

  rand(1..10).times do
    user_id = User.find_by(id: rand(1..40)).try(:id)
    question.answers.build(content: Faker::Hacker.say_something_smart, user_id: user_id).save
  end

  rand(1..30).times do
    user_id = User.find_by(id: rand(1..40)).try(:id)
    question.favorites.build(user_id: user_id).save
  end
end

### SEED UPVOTES PER ANSWER ####

Answer.all.each do |answer|
  rand(1..15).times do 
    answer.upvotes.build(voter_id: User.find_by(id: rand(1..30)).id).save
  end
end