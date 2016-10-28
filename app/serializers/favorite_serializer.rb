class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :question_id, :user_id, :new_favorite
  has_one :question
end