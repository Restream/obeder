Sidekiq.configure_server do |config|
    config.redis = {
      url: "redis://#{ENV["REDIS_HOST"]}:#{ENV["REDIS_PORT"]}/#{ENV["REDIS_DB"]}",
      namespace: "sidekiq_app_name_#{Rails.env}",
    }
end

Sidekiq.configure_client do |config|
    config.redis = {
      url: "redis://#{ENV["REDIS_HOST"]}:#{ENV["REDIS_PORT"]}/#{ENV["REDIS_DB"]}",
      namespace: "sidekiq_app_name_#{Rails.env}",
    }
end
