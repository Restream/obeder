require './config/boot'
require './config/environment'

require 'clockwork'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(1.day, 'freeze_user_menu', at: Settings.freeze_user_menu_at) do
  UserMenuFreezeWorker.perform_async
end
