class ApplicationMailer < ActionMailer::Base
  default_url_options[:host] = "http://#{ Settings.domain }"
  default from: 'noreply@restream.rt.ru'
  layout 'mailer'

  def self.inherited(subclass)
    subclass.default template_path: "mailers/#{subclass.name.to_s.underscore}"
  end
end
