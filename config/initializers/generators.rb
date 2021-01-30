Rails.application.config.generators do |g|
  g.template_engine :haml
  g.test_framework  :test_unit, fixture: true, fixture_replacement: :factory_bot
  g.stylesheets false
  g.javascripts false
  g.helper false
  g.skip_routes true
end
