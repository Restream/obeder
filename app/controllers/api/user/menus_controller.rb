class Api::User::MenusController < Api::User::ApplicationController
  def index
    user_menus = current_user.user_menus.includes(:menu).for_week
    render json: user_menus
  end
end
