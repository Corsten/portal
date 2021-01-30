module BaseType
  extend ActiveSupport::Concern

  module ClassMethods
    delegate :model_name, to: :superclass
    delegate :name, to: :superclass

    def permit(*args)
      @_args = args.concat(@_args || [])
    end
  end

  def assign_attributes(attrs = {})
    raise ArgumentError, 'expected hash' if attrs.nil?
    permitted_attrs = attrs.permitted? ? attrs : attrs.send(:permit, self.class._args)
    super(permitted_attrs)
  end
end
