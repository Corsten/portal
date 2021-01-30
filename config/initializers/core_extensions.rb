# NOTE: объяснение подхода: https://www.justinweiss.com/articles/3-ways-to-monkey-patch-without-making-a-mess/
EmailValidator.prepend CoreExtensions::EmailValidator
AutoSessionTimeout::ClassMethods.prepend CoreExtensions::AutoSessionTimeout::ClassMethods
ActionController::Base.send :include, CoreExtensions::AutoSessionTimeout
