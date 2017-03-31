require './config/boot'
require './config/environment'

require 'clockwork'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(1.second, 'guzzle.update', at: Settings.worker_guzzle_at) do
  GuzzleWorker.perform_async
end
