class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :upvote_count, :question_id
  has_many :upvotes
  has_one :question
end