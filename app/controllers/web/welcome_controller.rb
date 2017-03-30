class Web::WelcomeController < Web::ApplicationController
  before_action :authorize_user
  after_action :verify_authorized

  def index
  end
end
