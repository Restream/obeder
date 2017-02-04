class Api::MenusController < Api::ApplicationController
  def index
    q = Menu.ransack(params[:q])
    menus = q.result.page(params[:page])
    render json: menus
  end

  def create
    menu = Menu.new(menu_params)
    if menu.save
      menu_dishes_params.each do |menu_dish|
        menu_dish_attrs = menu_dish.to_h
        menu_dish_attrs[:menu_id] = menu.id
        MenuDish.create!(menu_dish_attrs)
      end
      render json: menu
    else
      render json: { errors: menu.errors }
    end
  end

  def update
    menu = Menu.find(params[:id])
    if menu.update(menu_params)
      menu.dishes.delete_all
      menu.menu_dishes << menu_dishes_params.map { |menu_dish| MenuDish.create(menu_dish) }
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
    params.require(:menu).permit(:date, :ready)
  end

  def menu_dishes_params
    params.require(:menu).permit(menu_dishes: [:dish_id, :default])[:menu_dishes] || []
  end
end
