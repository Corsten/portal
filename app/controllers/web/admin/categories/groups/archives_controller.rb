class Web::Admin::Categories::Groups::ArchivesController < Web::Admin::Categories::Groups::ApplicationController
  def new
    @archive = resource_group.archives.new
    authorize @archive
  end

  def create
    @archive = resource_group.archives.new(archive_params)
    authorize @archive

    if @archive.save
      redirect_to edit_admin_category_group_path(resource_category, @archive.group)
    else
      render :new
    end
  end

  def edit
    @archive = resource_group.archives.find(params[:id])
    authorize @archive
  end

  def update
    @archive = resource_group.archives.find(params[:id])
    authorize @archive

    if @archive.update(archive_params)
      redirect_to edit_admin_category_group_path(resource_category, @archive.group)
    else
      render :edit
    end
  end

  def show
    @archive = resource_group.archives.find(params[:id])
    authorize @archive
  end

  def destroy
    @archive = resource_group.archives.find(params[:id])
    authorize @archive
    @archive.destroy
    redirect_to edit_admin_category_group_path(resource_category, resource_group)
  end

  private

  def archive_params
    params.require(:category_archive).permit(%i[customer_name document notes])
  end
end
