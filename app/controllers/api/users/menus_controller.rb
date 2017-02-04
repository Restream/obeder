class Api::Users::MenusController < Api::Users::ApplicationController
  def index
    menus = Menu.ready.for_week
    render json: menus, each_serializer: UserMenuSerializer, user: resource_user
  end
end
