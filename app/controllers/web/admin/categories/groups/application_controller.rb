class Web::Admin::Categories::Groups::ApplicationController < Web::Admin::Categories::ApplicationController
  helper_method :resource_group

  def resource_group
    Category::Group.find(params[:group_id])
  end
end
