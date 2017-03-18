class Web::ApplicationController < ApplicationController
  include AuthHelper
  include FlashHelper
  include Pundit
  protect_from_forgery
end
