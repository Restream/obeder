class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  def index
    redirect_to edit_admin_menu_path(Date.current)
  end
end
