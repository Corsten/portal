class Admin::Category::GroupPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
