class Api::UsersController < Api::ApplicationController

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user
    else
      render json: { errors: user.errors }
    end
  end

  def user_params
    params.require(:user).permit(:neem)
  end
end
