class Api::Users::MenusController < Api::Users::ApplicationController
  def index
    menus = resource_user.menus
    render json: menus
  end
end
