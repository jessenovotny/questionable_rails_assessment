class UpvoteSerializer < ActiveModel::Serializer
  attributes :id, :voter_id, :answer_id
  has_one :answer
end