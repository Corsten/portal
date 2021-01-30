class Web::Admin::Categories::ApplicationController < Web::Admin::ProtectedApplicationController
  helper_method :resource_category

  def resource_category
    Category.find(params[:category_id])
  end
end
