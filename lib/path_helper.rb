module PathHelper
  module_function

  def url_creator(path = '', options = {})
    uri = URI(configus.mailer.default_host)
    uri.path = path
    uri.query = { token: options[:token] }.to_param if options[:token].present?
    uri.to_s
  end
end
