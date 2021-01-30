# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  default_url_options[:host] = configus.mailer.default_host
  default from: configus.mailer.from,
          reply_to: configus.mailer.reply_to
end
