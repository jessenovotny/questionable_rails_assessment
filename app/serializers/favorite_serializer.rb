class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :new_favorite
  has_one :question
end