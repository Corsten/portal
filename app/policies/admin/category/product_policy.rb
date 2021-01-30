class Admin::Category::ProductPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
