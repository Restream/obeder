class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @q = User.order(:name).ransack(params[:q])
    @users = @q.result.page(params[:page])
  end

  def new
  end

  def edit
  end
end
