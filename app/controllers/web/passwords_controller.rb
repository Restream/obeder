class Web::PasswordsController < Web::ApplicationController
  layout 'session'

  def edit
    @password = PasswordType.new
  end

  def update
    @password = PasswordType.new(password_params)

    if @password.valid?
      # FIXME надо пераписать
      @user = User.find(params[:id])
      @user.password = @password.password
      @user.save
      redirect_to login_path
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:password_type).permit(:password, :password_confirmation)
  end

end
