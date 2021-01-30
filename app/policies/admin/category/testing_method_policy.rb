class Admin::Category::TestingMethodPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
