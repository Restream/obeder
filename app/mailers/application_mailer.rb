class ApplicationMailer < ActionMailer::Base
  default_url_options[:host] = 'https://obeder.herokuapp.com'
  default from: 'noreply@restream.rt.ru'
  layout 'mailer'
end
