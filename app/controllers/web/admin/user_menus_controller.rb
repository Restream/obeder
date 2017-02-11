class Web::Admin::UserMenusController < Web::Admin::ApplicationController
  def index
    @date = date
    @neem_users = User.where(neem: true)
    @user_menus = UserMenu.for_date(params[:date])
    @dishes_stats = @user_menus.map(&:dishes).flatten.map(&:dish_type)
      .group_by { |type| type }
      .map{ |key, value| { type: key, count: value.count } }
  end

  private

  def date
    Date.parse(params[:date])
  end
end
