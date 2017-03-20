class Web::Admin::UserMenusController < Web::Admin::ApplicationController

  def index
    @date = Date.parse(params[:date]) if params[:date]
    @neem_users = User.joins(user_menus: :menu).where(neem: true).or(User.joins(user_menus: :menu).where('user_menus.neem = ? AND menus.date = ?', true, params[:date]))
    @user_menus = UserMenu.with_users.with_dishes.em.for_date(params[:date]).by_user_name
    @dishes_stats = @user_menus.map(&:dishes).flatten.group_by(&:name)
      .map{ |key, value| { type: key, count: value.count } }
  end

end
