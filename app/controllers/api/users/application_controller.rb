class Api::Users::ApplicationController < Api::ApplicationController
  def resource_user
    @resource_user ||= User.find(params[:user_id])
  end
end
