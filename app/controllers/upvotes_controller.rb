class UpvotesController < ApplicationController
  def create
    if current_user
      # binding.pry
      answer = Answer.find(params[:answer_id])
      upvote = answer.upvotes.build(voter_id: current_user.id)
      Upvote.find_by(answer_id: answer.id, voter_id: current_user.id).try(:delete) unless upvote.save
      # binding.pry
      render plain: answer.upvote_count
    end
    # redirect_to :back
    # render plain: answer.up
  end
end
