class Web::Admin::Categories::GroupsController < Web::Admin::Categories::ApplicationController
  def new
    @group = resource_category.groups.new
    authorize @group
  end

  def create
    @group = resource_category.groups.new(group_params)
    authorize @group

    if @group.save
      redirect_to edit_admin_category_path(@group.category)
    else
      render :new
    end
  end

  def edit
    @group = resource_category.groups.find(params[:id])
    authorize @group
  end

  def update
    @group = resource_category.groups.find(params[:id])
    authorize @group

    if @group.update(group_params)
      redirect_to edit_admin_category_path(@group.category)
    else
      render :edit
    end
  end

  def show
    @group = resource_category.groups.find(params[:id])
    authorize @group
  end

  def destroy
    @group = resource_category.groups.find(params[:id])

    authorize @group, :destroy?

    @group.destroy

    redirect_to edit_admin_category_path(resource_category)
  end

  private

  def group_params
    params.require(:category_group).permit(%i[name])
  end
end
