class Admin::EventPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
