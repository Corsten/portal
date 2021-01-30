class Admin::Category::ArchivePolicy < ApplicationPolicy
  def default
    administrator.role.admin?
  end
end
