class UpvotesController < ApplicationController
  
  def create
    upvote = Answer.find(params[:answer_id]).upvotes.build(voter_id: current_user.id)
    unless upvote.save
      Upvote.find_by(id: upvote.errors.messages[:answer][0]).try(:delete)
      flash[:error] = upvote.errors.messages[:voter] unless upvote.errors.messages[:user].empty?
    end
    redirect_to :back
  end

  def destroy
  end
end
