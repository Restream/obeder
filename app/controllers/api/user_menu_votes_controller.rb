class Api::UserMenuVotesController < Api::ApplicationController
  def update
    user_menu = UserMenuUpdateType.find(params[:id])
    return head :bad_request unless user_menu

    menu_dish = MenuDishVoteType.find_by(menu_id: user_menu.menu_id, dish_id: params[:dish_id])
    return head :bad_request unless menu_dish

    if params[:voted]
      menu_dish.voted_by(current_user)
    else
      menu_dish.unvoted_by(current_user)
    end

    render json: { id: user_menu.id, dish_id: menu_dish.dish_id, rating: menu_dish.rating }
  end

  private

  def user_menu_params
    params.require(:user_menu).permit(:description, :neem)
  end

  def dishes_params
    params.require(:user_menu).permit(dishes: [:id])[:dishes] || []
  end
end
