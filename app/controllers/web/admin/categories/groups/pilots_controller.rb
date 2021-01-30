class Web::Admin::Categories::Groups::PilotsController < Web::Admin::Categories::Groups::ApplicationController
  def new
    @pilot = resource_group.pilots.new
    authorize @pilot
  end

  def create
    @pilot = resource_group.pilots.new(pilot_params)
    authorize @pilot

    if @pilot.save
      redirect_to edit_admin_category_group_path(resource_category, @pilot.group)
    else
      render :new
    end
  end

  def edit
    @pilot = resource_group.pilots.find(params[:id])
    authorize @pilot
  end

  def update
    @pilot = resource_group.pilots.find(params[:id])
    authorize @pilot

    if @pilot.update(pilot_params)
      redirect_to edit_admin_category_group_path(resource_category, @pilot.group)
    else
      render :edit
    end
  end

  def show
    @pilot = resource_group.pilots.find(params[:id])
    authorize @pilot
  end

  def destroy
    @pilot = resource_group.pilots.find(params[:id])
    authorize @pilot
    @pilot.destroy
    redirect_to edit_admin_category_group_path(resource_category, resource_group)
  end

  private

  def pilot_params
    params.require(:category_pilot).permit(
      %i[customer_name supplier_name software_name manufacturer_name
         in_rsr registry_link leader_state unfunctional_requirements
         functional_requirements notes manufacturer_link customer_link status result]
    )
  end
end
