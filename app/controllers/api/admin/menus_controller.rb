class Api::Admin::MenusController < Api::ApplicationController
  def validate
    menu = Menu.current_menu(params[:date])
    
    if menu.valid?(:menu_publish)
      render json: { valid: true }
    else
      render json: { valid: false, errors: menu.errors[:dishes] }
    end
  end
end
