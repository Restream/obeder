class Web::Admin::MenusController < Web::Admin::ApplicationController
  def edit
    @menu = current_menu
  end

  def update
    @menu = current_menu

    if @menu.update(menu_params)
      redirect_to edit_admin_menu_path(@menu.date)
    else
      render action: 'edit'
    end
  end

  private

  def menu_params
    params.require(:menu).permit(menu_dishes_attributes: [:id, :default, :dish_id, :_destroy])
  end

  def current_menu
    Menu.for_date(params[:date]).first || Menu.create(date: params[:date])
  end
end
