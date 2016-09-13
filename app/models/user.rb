class User < ApplicationRecord
  has_many :questions, foreign_key: 'asker_id'
  has_many :answers, 
end
