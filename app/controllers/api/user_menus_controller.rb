class Api::UserMenusController < Api::ApplicationController
  def index
    date = params[:date] || Date.today
    user_menus = UserMenu.for_date(date)

    render json: user_menus
  end

  def update
    user_menu = UserMenu.find(params[:id])

    user_menu.dishes.delete_all
    user_menu.dishes << Dish.where(id: dishes_params.map { |dish| dish[:id] })

    render json: user_menu
  end

  private

  def dishes_params
    params.require(:user_menu).permit(dishes: [:id])[:dishes] || []
  end
end
