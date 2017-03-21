class Web::PasswordsController < Web::ApplicationController
  layout 'session'

  def edit
    return redirect_to(root_path) unless params[:id]
    @user = UserPasswordEditType.new
  end

  def update
    return redirect_to(root_path) unless params[:id]
    @user = UserPasswordEditType.find(params[:id])

    if @user.update(password_params)
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
