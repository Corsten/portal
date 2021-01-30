class Admin::UserPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end

  def block?
    default
  end

  def unblock?
    default
  end
end
