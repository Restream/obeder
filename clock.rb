require './config/boot'
require './config/environment'

require 'clockwork'

include Clockwork

every(1.day, 'freeze_user_menu', at: Settings.freeze_user_menu_at) do
  UserMenuFreezeWorker.perform_async
end
