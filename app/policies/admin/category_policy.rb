class Admin::CategoryPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
