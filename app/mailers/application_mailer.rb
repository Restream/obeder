class ApplicationMailer < ActionMailer::Base
  default_url_options[:host] = "http://#{ Settings.domain }"
  default from: 'noreply@restream.rt.ru'
  layout 'mailer'
end
