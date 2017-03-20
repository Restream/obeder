class Web::Admin::ApplicationController < Web::ApplicationController
  layout 'admin'

  after_action :verify_authorized
end
