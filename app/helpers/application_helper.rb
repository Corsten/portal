module ApplicationHelper
  def han(model, attribute)
    model.to_s.classify.constantize.human_attribute_name(attribute)
  end

  def present(model, presenter_klass = nil)
    return if model.blank?
    klass = presenter_klass || "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
    presenter
  end
end
