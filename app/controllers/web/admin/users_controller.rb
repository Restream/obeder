class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @q = User.order(:name).ransack(params[:q])
    @users = @q.result.page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      ::DishesService.set_default_dishes_for_user(@user)
      UserMailer.set_password(@user).deliver
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update user_params
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :neem, :description, :role)
  end
end
