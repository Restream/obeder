class Web::Admin::MenusController < Web::Admin::ApplicationController
  DATE_OFFSET = 2

  def edit
    @date = date
    @menu = current_menu
    @dishes = dishes
    @closest_days_menus = closest_days_menus(date, DATE_OFFSET)
  end

  def update
    @menu = current_menu

    if @menu.update(menu_params)
      f(:success)
      redirect_to edit_admin_menu_path(@menu.date)
    else
      f(:error)
      @date = @menu.date
      @dishes = dishes
      @closest_days_menus = closest_days_menus(@date, DATE_OFFSET)
      render action: :edit
    end
  end

  def validate
    menu = current_menu

    if menu.valid?(:menu_publish)
      render json: { valid: true }
    else
      render json: { valid: false, errors: menu.errors[:dishes] }
    end
  end

  def approve
    @menu = current_menu
    @menu.ready = true
    @menu.save

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

  def dishes
    Dish.order(:name).all
  end

  def closest_days_menus(date, offset)
    Menu.includes(:dishes, :menu_dishes)
      .for_date_range(date, offset)
      .except_date(date)
      .decorate
  end
end
