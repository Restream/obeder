require 'clockwork'

require './config/boot'
require './config/environment'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(1.day, 'neem.update', at: '15:00') do
  UserMenu.joins(:user, :menu).where(menus: { date: Date.tomorrow })
    .where(users: { neem: true }).update_all(['neem = ?, editable = ?', true, false])
end
