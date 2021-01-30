class Web::Admin::AdministratorsController < Web::Admin::ProtectedApplicationController
  def index
    authorize Administrator
    query = { s: 'id asc' }.merge(params[:q] || {})
    @q = policy_scope(Administrator).ransack query
    @administrators = @q.result.page(params[:page]).per(params[:per_page])
  end

  def new
    @administrator = AdministratorType.new(params[:administrator])
    authorize @administrator
  end

  def create
    @administrator = AdministratorType.new(params[:administrator])
    authorize @administrator

    if @administrator.save
      redirect_to admin_administrators_path
    else
      render action: :new
    end
  end

  def edit
    @administrator = AdministratorType.find(params[:id])
    authorize @administrator
  end

  def update
    @administrator = AdministratorType.find(params[:id])
    authorize @administrator

    if @administrator.update(params[:administrator])
      redirect_to admin_administrators_path
    else
      render action: :edit
    end
  end

  def destroy
    administrator = Administrator.find(params[:id])
    authorize administrator
    administrator.destroy

    redirect_to admin_administrators_path
  end
end
