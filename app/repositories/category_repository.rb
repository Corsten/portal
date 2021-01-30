module CategoryRepository
  extend ActiveSupport::Concern

  included do
    scope :by_register_kind, lambda { |kind|
      where("enable_#{kind.to_sym}" => true) if Category.has_attribute? "enable_#{kind.to_sym}"
    }
  end
end
