class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :upvote_count
  has_many :upvotes

end