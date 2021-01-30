class Admin::WorkingGroupMemberPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
