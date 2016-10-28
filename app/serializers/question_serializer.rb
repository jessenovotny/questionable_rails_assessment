class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :content, :favorite_count
  has_many :favorites
  has_many :answers
end