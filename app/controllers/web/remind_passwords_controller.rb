class Web::RemindPasswordsController < Web::ApplicationController
  layout 'session'

  def edit
    @user_type = UserRemindPasswordType.new
  end

  def update
    @user_type = UserRemindPasswordType.new(user_remind_password_type_params)
    user = @user_type.user
    if @user_type.valid? && user.present?
      user.deactivate!
      UserMailer.change_password(user).deliver
      flash[:success] = t('password_has_been_reset')
      redirect_to login_path
    else
      if user.blank? && @user_type.valid?
        flash.now[:error] = t('user_not_found')
      end
      render :edit
    end
  end

  private

  def user_remind_password_type_params
    params.require(:user_remind_password_type).permit(:email)
  end
end
