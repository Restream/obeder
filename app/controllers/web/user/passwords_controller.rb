class Web::User::PasswordsController < Web::User::ApplicationController
  def edit
    @user = UserPasswordEditType.new
  end

  def update
    @user = UserPasswordEditType.find_by_id(params[:user_id])

    if @user.blank?
      flash[:error] = t('user_not_found')
      redirect_to edit_user_password_path
    elsif
      @user.active? && (current_user.try(:id) != @user.id)
      flash[:error] = t('authenticate_to_change_password')
      redirect_to login_path
    elsif @user.update(password_params)
      @user.activate!
      flash[:success] = t('password_changed')
      redirect_to login_path
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user_password_edit_type).permit(:password, :password_confirmation)
  end
end
