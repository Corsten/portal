class Web::Admin::UsersController < Web::Admin::ProtectedApplicationController
  def index
    authorize User
    query = { s: 'id asc' }.merge(params[:q] || {})
    @q = User.active.ransack query
    @users = @q.result.page(params[:page]).per(params[:per_page])
    @filter_params = params.permit!.slice(:q, :page, :per_page).to_h
  end

  def new
    @user = UserType.new(params[:user])
    authorize @user
  end

  def create
    @user = UserType.new(params[:user])
    authorize @user

    if @user.save
      redirect_to admin_users_path
    else
      render action: :new
    end
  end

  def edit
    @user = UserType.active.find(params[:id])
    authorize @user
  end

  def update
    @user = UserType.active.find(params[:id])
    authorize @user

    if @user.update(params[:user])
      redirect_to admin_users_path
    else
      render action: :edit
    end
  end

  def destroy
    user = User.active.find(params[:id])
    authorize user
    user.destroy

    redirect_to admin_users_path
  end

  def block
    user = User.active.find(params[:id])
    authorize user
    user.block!

    flash[:success] = t('flashes.user.block', id: user.id)

    redirect_back(fallback_location: admin_users_path)
  end

  def unblock
    user = User.active.find(params[:id])
    authorize user
    user.unblock!

    Resque.enqueue(UserUnblockJob, user.id)

    flash[:success] = t('flashes.user.unblock', id: user.id)

    redirect_back(fallback_location: admin_users_path)
  end
end
