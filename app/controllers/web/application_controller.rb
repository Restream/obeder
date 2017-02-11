class Web::ApplicationController < ApplicationController
<<<<<<< 3409e72d4d81b5727c6f4f047de6fad653f7904f
=======
  include FlashHelper

  http_basic_authenticate_with name: 'user', password: 'password'
>>>>>>> add approve menu button
end
