class BasePresenter < Delegator
  attr_reader :model, :h
  alias __getobj__ model

  def initialize(model, view_context)
    @model = model
    @h = view_context
  end
end
