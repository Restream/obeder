class Api::User::MenusController < Api::User::ApplicationController
  include ActionController::Cookies

  def index
    # raise current_user.inspect
    # raise cookies.encrypted['_obeder_session']['user_id'].inspect
    user_menus = current_user.user_menus.includes(menu: [{ menu_dishes: [:dish] }]).for_week
    render json: user_menus
  end
end
