class Admin::Category::PilotPolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
