class Api::UserMenuVotesController < Api::ApplicationController
  def update
    vote_type = MenuDishVoteType.new(user_menu_vote_params)
    voteable = vote_type.voteable

    if vote_type.valid?
      raise ::ActiveRecord::RecordNotFound if voteable.nil?

      voting_action = vote_type.voted ? :voted_by : :unvoted_by
      voteable.send(voting_action, current_user)

      render json: { id: vote_type.user_menu_id, dish_id: vote_type.dish_id, rating: voteable.rating }
    else
      render json: { errors: vote_type.errors }
    end
  end

  private

  def user_menu_vote_params
    vote_params = params.require(:user_menu_vote).permit(:dish_id, :voted).to_h
    vote_params[:user_menu_id] = params[:id]
    vote_params
  end
end
