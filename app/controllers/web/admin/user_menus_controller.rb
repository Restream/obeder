class Web::Admin::UserMenusController < Web::Admin::ApplicationController
  before_action :authorize_cook

  def index
    date = params[:date]
    @date = Date.parse(date) if date

    @neem_users = User.joins(user_menus: :menu)
      .where('users.neem = ? OR (user_menus.neem = ? AND menus.date = ?)', true, true, date)
      .where.not(role: 'cook')
      .distinct

    @user_menus = UserMenu.with_users.with_dishes.for_date(date)
      .where.not(user: @neem_users, users: { role: 'cook' })
      .ordered_by_user_name

    @dishes_stats = Dish.joins(:user_menus)
      .where('user_menus.id IN (?)', @user_menus.pluck(:id))
      .group_by(&:name)
      .map{ |key, value| { type: key, count: value.count } }

    menu = Menu.find_by(date: date)
    unless menu.nil?
      @default_dishes = menu.dishes
        .joins(:menu_dishes)
        .where(menu_dishes: { default: true })
        .ordered_by_name
    end
  end
end
