class Web::ApplicationController < ApplicationController
  include FlashHelper
  include Pundit
  protect_from_forgery
end
