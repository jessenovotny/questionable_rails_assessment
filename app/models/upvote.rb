class Upvote < ApplicationRecord
  belongs_to :user, foreign_key: 'voter_id'
  belongs_to :answer
end