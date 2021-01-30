class Admin::AdministratorPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end

  def update?
    default && can_edit?
  end

  def edit?
    update?
  end

  def destroy?
    update? && record != administrator
  end

  def block?
    update? && record != administrator
  end

  def unblock?
    update? && record != administrator
  end

  def can_edit?
    true
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
