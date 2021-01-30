class Web::Admin::Categories::Groups::TestingMethodsController < Web::Admin::Categories::Groups::ApplicationController
  def new
    @testing_method = resource_group.testing_methods.new
    authorize @testing_method
  end

  def create
    @testing_method = resource_group.testing_methods.new(testing_method_params)
    authorize @testing_method

    if @testing_method.save
      redirect_to edit_admin_category_group_path(resource_category, @testing_method.group)
    else
      render :new
    end
  end

  def edit
    @testing_method = resource_group.testing_methods.find(params[:id])
    authorize @testing_method
  end

  def update
    @testing_method = resource_group.testing_methods.find(params[:id])
    authorize @testing_method

    if @testing_method.update(testing_method_params)
      redirect_to edit_admin_category_group_path(resource_category, @testing_method.group)
    else
      render :edit
    end
  end

  def show
    @testing_method = resource_group.testing_methods.find(params[:id])
    authorize @testing_method
  end

  def destroy
    @testing_method = resource_group.testing_methods.find(params[:id])
    authorize @testing_method
    @testing_method.destroy
    redirect_to edit_admin_category_group_path(resource_category, resource_group)
  end

  private

  def testing_method_params
    params.require(:category_testing_method).permit(%i[customer_name document notes])
  end
end
