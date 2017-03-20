class Web::ApplicationController < ApplicationController
  include AuthHelper
  include FlashHelper
  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    flash[:error] = t("pundit.#{exception.policy}.#{exception.query}")
    redirect_to(request.referrer || login_path)
  end

  def authorize_admin
    authorize :admin
  end

  def authorize_cook
    authorize :cook
  end

  def authorize_user
    authorize :user
  end

end
