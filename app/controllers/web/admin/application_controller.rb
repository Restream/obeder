class Web::Admin::ApplicationController < Web::ApplicationController
  layout 'admin'
  http_basic_authenticate_with name: 'admin', password: 'password'
end
