Inky.configure do |config|
  config.template_engine = :haml
end

Premailer::Rails.config.merge!(preserve_styles: true, remove_ids: true)
