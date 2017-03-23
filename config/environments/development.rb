Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.after_initialize do
    # Enable Bullet gem, otherwise do nothing
    Bullet.enable = true

    # Pop up a JavaScript alert in the browser
    Bullet.alert = true

    # Log to the Bullet log file (Rails.root/log/bullet.log)
    Bullet.bullet_logger = true

    # Log warnings to your browser's console.log (Safari/Webkit browsers or Firefox w/Firebug installed)
    Bullet.console = true

    # Pop up Growl warnings if your system has Growl installed. Requires a little bit of configuration
    # Bullet.growl = true

    # Add warnings directly to the Rails log
    Bullet.rails_logger = true

    # Add notifications to Honeybadger
    # Bullet.honeybadger = true

    # Add notifications to bugsnag
    # Bullet.bugsnag = true

    # Add notifications to airbrake
    # Bullet.airbrake = true

    # Add notifications to rollbar
    # Bullet.rollbar = true

    # Adds the details in the bottom left corner of the page. Double click the footer or use close button to hide footer
    Bullet.add_footer = true

    # Include paths with any of these substrings in the stack trace, even if they are not in your main app
    # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]

    # Ignore paths with any of these substrings in the stack trace, even if they are not in your main app
    # Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware' ]

    # Raise errors, useful for making your specs fail unless they have optimized queries
    Bullet.raise = true

    # Each of these settings defaults to true

    # Detect N+1 queries
    # Bullet.n_plus_one_query_enable = true

    # Detect eager-loaded associations which are not used
    # Bullet.unused_eager_loading_enable = true

    # Detect unnecessary COUNT queries which could be avoided
    # with a counter_cache
    # Bullet.counter_cache_enable = false
  end
end
