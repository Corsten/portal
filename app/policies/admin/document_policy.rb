class Admin::DocumentPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
