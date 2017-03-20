class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  before_action :authorize_cook

  def index
    redirect_to edit_admin_menu_path(Date.current)
  end
end
