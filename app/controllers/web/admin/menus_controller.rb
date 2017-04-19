class Web::Admin::MenusController < Web::Admin::ApplicationController
  before_action :authorize_cook

  def edit
    @menu = current_menu
  end

  def update
    @menu = current_menu

    if @menu.update(menu_params)
      f(:success)
      redirect_to edit_admin_menu_path(@menu.date)
    else
      f(:error)
      render action: :edit
    end
  end

  def approve
    @menu = current_menu
    @menu.approve!

    f(:success)
    redirect_to edit_admin_menu_path(@menu.date)
  end

  private

  def menu_params
    params.require(:menu).permit(menu_dishes_attributes: [:id, :default, :dish_id, :_destroy])
  end

  def current_menu
    Menu.current_menu(params[:date])
  end

  def date
    Date.parse(params[:date])
  end
end
