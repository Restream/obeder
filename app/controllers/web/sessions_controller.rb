class Web::SessionsController < Web::ApplicationController
  layout 'session'

  def new
    @session = UserSignInType.new
  end

  def create
    @session = UserSignInType.new(user_sign_in_type_params)
    user = @session.user

    if user.blank?
      flash[:error] = t('user_not_found')
      redirect_to login_path
    elsif user.active? && @session.valid?
      sign_in(user)
      redirect_to (user.role.admin? || user.role.cook?) ? admin_root_path : root_path
    else
      flash.now[:error] = t('password_not_set') if user.inactive?
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
