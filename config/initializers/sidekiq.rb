Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{Settings.redis.host}:#{Settings.redis.port}/#{Settings.redis.sidekiq_db}"
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{Settings.redis.host}:#{Settings.redis.port}/#{Settings.redis.sidekiq_db}"
  }
end
