class Api::Users::MenusController < Api::Users::ApplicationController
  def index
    menus = Menu.for_week
    render json: menus, user: resource_user
  end
end
