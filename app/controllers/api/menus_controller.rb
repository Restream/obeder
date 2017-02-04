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
        MenuDish.create(menu_dish_attrs)
      end
      render json: menu
    else
      render json: { errors: menu.errors }
    end
  end

  def update
    menu = Menu.find(params[:id])

    new_menu_dishes_ids = menu_dishes_params.map { |dish| dish[:id] }
    existing_menu_dishes_ids = menu.menu_dishes.pluck(:id)

    deleted_menu_dishes_ids = existing_menu_dishes_ids - new_menu_dishes_ids
    MenuDish.where(id: deleted_menu_dishes_ids).delete_all

    updated_menu_dishes_ids = existing_menu_dishes_ids & new_menu_dishes_ids
    updated_menu_dishes_ids.each do |id|
      new_menu_dish = menu_dishes_params.select { |dish| dish[:id] == id }.first
      MenuDish.find(id).update(new_menu_dish)
    end

    created_menu_dishes_ids = new_menu_dishes_ids - existing_menu_dishes_ids
    created_menu_dishes_ids.each do |id|
      menu_dish = menu_dishes_params.select { |dish| dish[:id] == id }.first
      menu_dish_attrs = menu_dish.to_h
      menu_dish_attrs[:menu_id] = menu.id
      MenuDish.create(menu_dish_attrs)
    end

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
    params.require(:menu).permit(:date, :ready)
  end

  def menu_dishes_params
    params.require(:menu).permit(menu_dishes: [:id, :dish_id, :default])[:menu_dishes] || []
  end
end
