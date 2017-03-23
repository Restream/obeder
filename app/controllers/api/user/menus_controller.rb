class Api::User::MenusController < Api::User::ApplicationController
  include ActionController::Cookies

  def index
    user_menus = current_user.user_menus.includes(menu: [{ menu_dishes: [:dish] }]).for_week
    render json: user_menus
  end
end
