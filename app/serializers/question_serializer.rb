class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_many :favorites
end