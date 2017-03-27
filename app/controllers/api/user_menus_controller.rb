class Api::UserMenusController < Api::ApplicationController
  def index
    date = params[:date] || Date.current
    user_menus = UserMenu.for_date(date)

    render json: user_menus
  end

  def update
    user_menu = UserMenu.find(params[:id])

    if user_menu.update(user_menu_params)
      user_menu.dishes.delete_all
      user_menu.dishes << Dish.where(id: dishes_params.map { |dish| dish[:id] })

      render json: user_menu
    else
      render json: { errors: user_menu.errors }
    end
  end

  private

  def user_menu_params
    params.require(:user_menu).permit(:description, :neem)
  end

  def dishes_params
    params.require(:user_menu).permit(dishes: [:id])[:dishes] || []
  end
end
