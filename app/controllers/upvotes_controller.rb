class UpvotesController < ApplicationController
  def create
    answer = Answer.find(params[:answer_id])
    upvote = answer.upvotes.build(voter_id: current_user.id)
    Upvote.find_by(answer_id: answer.id, voter_id: current_user.id).try(:delete) unless upvote.save
    redirect_to :back
  end
end
