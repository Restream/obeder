class ApplicationMailer < ActionMailer::Base
  default_url_options[:host] = "https://#{ Settings.domain }"
  default from: 'noreply@restream.rt.ru'
  layout 'mailer'
end
