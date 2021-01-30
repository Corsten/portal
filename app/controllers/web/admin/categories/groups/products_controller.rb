class Web::Admin::Categories::Groups::ProductsController < Web::Admin::Categories::Groups::ApplicationController
  def new
    @product = resource_group.products.new
    authorize @product
  end

  def create
    @product = resource_group.products.new(product_params)
    authorize @product

    if @product.save
      redirect_to edit_admin_category_group_path(resource_category, @product.group)
    else
      render :new
    end
  end

  def edit
    @product = resource_group.products.find(params[:id])
    authorize @product
  end

  def update
    @product = resource_group.products.find(params[:id])
    authorize @product

    if @product.update(product_params)
      redirect_to edit_admin_category_group_path(resource_category, @product.group)
    else
      render :edit
    end
  end

  def show
    @product = resource_group.products.find(params[:id])
    authorize @product
  end

  def destroy
    @product = resource_group.products.find(params[:id])
    authorize @product
    @product.destroy
    redirect_to edit_admin_category_group_path(resource_category, resource_group)
  end

  private

  def product_params
    params.require(:category_product).permit(%i[name document manufacturer link rating])
  end
end
