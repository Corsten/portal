class Web::Admin::CategoriesController < Web::Admin::ProtectedApplicationController
  def index
    authorize Category
    query = { s: 'id asc' }.merge(params[:q] || {})
    @q = Category.ransack query
    @categories = @q.result.page(params[:page]).per(params[:per_page])
  end

  def new
    @category = Category.new(params[:category])
    authorize @category
  end

  def create
    @category = Category.new(params[:category])
    authorize @category

    if @category.save
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize @category
  end

  def update
    @category = Category.find(params[:id])
    authorize @category

    if @category.update(params[:category])
      redirect_to admin_categories_path
    else
      render action: :edit
    end
  end

  def destroy
    category = Category.find(params[:id])
    authorize category
    category.destroy

    redirect_to admin_categories_path
  end
end
