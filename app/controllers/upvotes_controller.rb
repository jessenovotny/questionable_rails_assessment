class UpvotesController < ApplicationController
  def create
    # binding.pry
    Answer.find(params[:answer_id]).upvotes.build(voter_id: current_user.id).save
    redirect_to :back
  end

  def destroy
  end
end
