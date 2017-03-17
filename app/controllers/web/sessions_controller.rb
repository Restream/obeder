class Web::SessionsController < Web::ApplicationController
  layout 'admin'
  # skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @session = UserSignInType.new
  end

  def create
    @session = UserSignInType.new(user_sign_in_type_params)

    if @session.valid?
      user = @session.user
      sign_in(user)

      f(:success)
      redirect_to root_path
    else
      # f(:error, now: true)
      render :new
    end
  end

  def destroy
    sign_out

    f(:success)
    redirect_to new_session_path
  end

  private

  def user_sign_in_type_params
    params.require(:user_sign_in_type).permit(:email, :password)
  end
end
