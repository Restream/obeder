class Api::UserMenuVotesController < Api::ApplicationController
  def update
    vote_type = MenuDishVoteType.new(user_menu_vote_params)

    return render json: { errors: vote_type.errors } if vote_type.invalid?

    voteable = vote_type.voteable
    voting_action = vote_type.voted ? :voted_by : :unvoted_by
    voteable.send(voting_action, current_user)

    render json: { user_menu_id: vote_type.user_menu_id, dish_id: vote_type.dish_id, rating: voteable.rating }
  end

  private

  def user_menu_vote_params
    vote_params = params.require(:user_menu_vote).permit(:dish_id, :voted)
    vote_params[:user_menu_id] = params[:user_menu_id]
    vote_params
  end
end
