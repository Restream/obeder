class Api::Admin::MenusController < Api::ApplicationController
  def validate
    menu = MenuPublishType.current_menu(params[:date])
    if menu.valid?
      render json: { valid: true }
    else
      render json: { valid: false, errors: menu.errors[:dishes] }
    end
  end
end
