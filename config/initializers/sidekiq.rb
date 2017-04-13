Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{ENV.fetch("REDIS_HOST") { "127.0.0.1" }}:#{ENV.fetch("REDIS_PORT") { "6379" }}/#{ENV.fetch("REDIS_DB") { "db0" }}"
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{ENV.fetch("REDIS_HOST") { "127.0.0.1" }}:#{ENV.fetch("REDIS_PORT") { "6379" }}/#{ENV.fetch("REDIS_DB") { "db0" }}"
  }
end
