class ApplicationPolicy
  attr_reader :administrator, :record

  def initialize(administrator, record)
    @administrator = administrator
    @record = record
  end

  def default
    false
  end

  def index?
    default
  end

  def create?
    default
  end

  def new?
    create?
  end

  def update?
    default
  end

  def edit?
    update?
  end

  def destroy?
    default
  end

  class Scope
    attr_reader :administrator, :scope

    def initialize(administrator, scope)
      @administrator = administrator
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
