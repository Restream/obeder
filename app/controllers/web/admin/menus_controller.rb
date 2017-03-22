class Web::Admin::MenusController < Web::Admin::ApplicationController
  DATE_OFFSET = 2

  def edit
    @date = date
    @menu = current_menu
    @dishes = Dish.order(:name).all
    @closest_days_menus = Menu.includes(menu_dishes: :dish)
      .except_date(@date)
      .for_date_range(@date, DATE_OFFSET)
      .decorate
  end

  def update
    @menu = current_menu

    @menu.update(menu_params) ? f(:success) : f(:error)
    redirect_to edit_admin_menu_path(@menu.date)
  end

  def approve
    @menu = current_menu

    if @menu.valid?(:menu_publish)
      @menu.ready = true
      @menu.save
    else
      f(:error)
      redirect_to edit_admin_menu_path(@menu.date)
      return
    end

    User.find_each do |user|
      user_menu = UserMenu.create(user: user, menu: @menu, neem: user.neem)
      menu_dishes = @menu.menu_dishes.default
      dishes = menu_dishes.map(&:dish)
      user_menu.dishes << dishes
    end

    f(:success)
    redirect_to edit_admin_menu_path(@menu.date)
  end

  private

  def menu_params
    params.require(:menu).permit(menu_dishes_attributes: [:id, :default, :dish_id, :_destroy])
  end

  def current_menu
    Menu.for_date(params[:date]).first || Menu.create(date: params[:date])
  end

  def date
    Date.parse(params[:date])
  end
end
