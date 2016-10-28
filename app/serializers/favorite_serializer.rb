class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :question_id, :user_id
  has_one :question
end