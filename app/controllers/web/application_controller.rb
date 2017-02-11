class Web::ApplicationController < ApplicationController
  include FlashHelper

  http_basic_authenticate_with name: 'user', password: 'password'
end
