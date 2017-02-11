class Api::Users::MenusController < Api::Users::ApplicationController
  def index
    user_menus = resource_user.user_menus.includes(menu: [{ menu_dishes: [:dish] }]).for_week
    render json: user_menus
  end
end
