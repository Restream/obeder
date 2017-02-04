class Api::UserMenusController < Api::ApplicationController
  def index
    date = params[:date] || Date.today
    user_menus = UserMenu.for_date(date)

    render json: user_menus
  end
end
