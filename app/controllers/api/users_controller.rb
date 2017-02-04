class Api::UsersController < Api::ApplicationController
  def index
    users = User.all
    render json: users
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
    params.permit(:neem)
  end
end
