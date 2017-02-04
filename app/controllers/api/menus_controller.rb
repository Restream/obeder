class Api::MenusController < Api::ApplicationController
  def index
    q = Menu.ransack(params[:q])
    menus = q.result.page(params[:page])
    render json: menus
  end

  def create
    menu = Menu.new(menu_params)
    if menu.save
      render json: menu
    else
      render json: { errors: menu.errors }
    end
  end

  def update
    menu = Menu.find(params[:id])
    if menu.update(menu_params)
      render json: menu
    else
      render json: { errors: menu.errors }
    end
  end

  def destroy
    menu = Menu.find(params[:id])
    if menu.delete
      render json: menu
    else
      render json: { errors: menu.errors }
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:date, :ready, menu_dishes_attributes: [:id, :dish_id, :default])
  end
end
