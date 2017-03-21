class Web::Admin::UserMenusController < Web::Admin::ApplicationController

  def index
    date = params[:date]
    @date = Date.parse(date) if date
    @neem_users = User.joins(user_menus: :menu)
                      .where(neem: true)
                      .or(User.joins(user_menus: :menu).where('user_menus.neem = ? AND menus.date = ?', true, date))
                      .distinct
    @user_menus = UserMenu.with_users.with_dishes.em.for_date(date)
                          .where('users.neem = ? AND user_menus.neem = ?', false, false)
                          .by_user_name
    @dishes_stats = @user_menus.map(&:dishes).flatten.group_by(&:name)
      .map{ |key, value| { type: key, count: value.count } }
  end

end
