Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{ENV.fetch("REDIS_HOST", Settings.REDIS_HOST)}:#{ENV.fetch("REDIS_PORT", Settings.REDIS_PORT)}/#{ENV.fetch("REDIS_DB", Settings.SIDEKIQ_REDIS_DB)}"
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{ENV.fetch("REDIS_HOST", Settings.REDIS_HOST)}:#{ENV.fetch("REDIS_PORT", Settings.REDIS_PORT)}/#{ENV.fetch("REDIS_DB", Settings.SIDEKIQ_REDIS_DB)}"
  }
end
