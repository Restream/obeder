class Api::UserMenuVotesController < Api::ApplicationController
  def update
    vote_type = MenuDishVoteType.new(user_menu_vote_params)

    if vote_type.valid?
      VotesService.assign_dish_vote(vote_type, current_user)
      render json: vote_type
    else
      render json: { errors: vote_type.errors }
    end
  end

  private

  def user_menu_vote_params
    params.require(:user_menu_vote).permit(:dish_id, :voted).merge(user_menu_id: params[:user_menu_id])
  end
end
