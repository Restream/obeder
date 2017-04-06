class Web::WelcomeController < Web::ApplicationController
  before_action :authorize_user
  after_action :verify_authorized
  #Выпилить эту хуйню и разобраться чтоб все ассеты раздавал nginx
  protect_from_forgery except: :index

  def index
  end
end
