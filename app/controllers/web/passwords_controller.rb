class Web::PasswordsController < Web::ApplicationController
  layout 'session'

  def edit
    return redirect_to(root_path) unless params[:id]
    @user = UserPasswordEditType.new
  end

  def update
    return redirect_to(root_path) unless params[:id]
    @user = UserPasswordEditType.find(params[:id])
    if (@user.active? && (current_user.try(:id) != @user.id))
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
