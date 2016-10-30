### CLEAR DB FIRST ###
DatabaseCleaner.clean_with(:truncation)

### SEED CATEGORIES ####

15.times do
  Category.create(name: Faker::Book.genre)
end

### SEED USERS ####

15.times do
  user = User.create(username: Faker::Internet.user_name, password: "password")
  user = User.create(username: Faker::Internet.user_name, password: "password") unless user.valid?
end

### SEED QUESTIONS PER USER ####

questions = ["Never tell me the odds!", "Well, you said you wanted to be around when I made a mistake.", "You will never find a more wretched hive of scum and villainy. We must be cautious.", "Wars not make one great.",
         "You do have your moments. Not many, but you have them.", "Now, witness the power of this fully operational battle station.", "No reward is worth this.", "Shut him up or shut him down.",
         "I have a bad feeling about this.", "Who\'s the more foolish; the fool, or the fool who follows him?", "Would somebody get this big walking carpet out of my way?", "I find your lack of faith disturbing.",
         "If they follow standard Imperial procedure, they\'ll dump their garbage before they go to light-speed.", "Only at the end do you realize the power of the Dark Side.", "Bounty hunters! We don\'t need this scum.",
         "It\'s not impossible. I used to bullseye womp rats in my T-16 back home, they\'re not much bigger than two meters.", "Strike me down, and I will become more powerful than you could possibly imagine.",
         "You know, that little droid is going to cause me a lot of trouble.", "If you\'re saying that coming here was a bad idea, I\'m starting to agree with you.", "You\'ll find I\'m full of surprises!",
         "Aren\'t you a little short for a Stormtrooper?", "You are unwise to lower your defenses!", "R2-D2, you know better than to trust a strange computer!", "Truly wonderful, the mind of a child is.",
         "That is why you fail.", "A Jedi uses the Force for knowledge and defense, never for attack.", "Adventure. Excitement. A Jedi craves not these things.", "Judge me by my size, do you?",
         "Fear is the path to the dark side... fear leads to anger... anger leads to hate... hate leads to suffering.", "Do. Or do not. There is no try."]

questions.each do |question|
  question = question[0...-1] + "?"
  Question.create(content: question, asker_id: rand(1..15))
end

### SEED CATEGORIES, ANSWERS, AND FAVORITES PER QUESTION ####

Question.all.each do |question|
  rand(3..6).times do
    category = Category.find_by(id: rand(1..15))
    question.categories << category unless question.categories.include?(category) || category.nil?
  end

  rand(3..6).times do
    user_id = User.find_by(id: rand(1..15)).try(:id)
    answer = question.answers.build(content: Faker::Hacker.say_something_smart[0...-1] + ".", user_id: user_id)
    rand(1..3).times do
      rand(1..3).times do
        rand(1..3).times do
          answer.content += " " + Faker::Hacker.say_something_smart[0...-1] + "."
        end
      end
    end
    answer.save
  end

  rand(3..8).times do
    user_id = User.find_by(id: rand(1..15)).try(:id)
    until user_id != question.asker_id
      user_id = User.find_by(id: rand(1..15)).try(:id)
    end
    question.favorites.build(user_id: user_id).save
  end
end

### SEED UPVOTES PER ANSWER ####

Answer.all.each do |answer|
  rand(1..8).times do 
    user_id = User.find_by(id: rand(1..15)).try(:id)
    until user_id != answer.user_id
      user_id = User.find_by(id: rand(1..15)).try(:id)
    end
    answer.upvotes.build(voter_id: user_id).save
  end
end