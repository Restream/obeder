class Web::SessionsController < Web::ApplicationController
  layout 'session'

  def new
    @session = UserSignInType.new
  end

  def create
    @session = UserSignInType.new(user_sign_in_type_params)

    if @session.valid?
      user = @session.user
      sign_in(user)

      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    sign_out

    redirect_to login_path
  end

  private

  def user_sign_in_type_params
    params.require(:user_sign_in_type).permit(:email, :password)
  end
end
