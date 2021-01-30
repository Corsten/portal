class Web::Admin::DocumentsController < Web::Admin::ProtectedApplicationController
  def index
    authorize Document
    query = { s: 'id asc' }.merge(params[:q] || {})
    @q = Document.ransack query
    @documents = @q.result.page(params[:page]).per(params[:per_page])
  end

  def new
    @document = Document.new(params[:document])
    authorize @document
  end

  def create
    @document = Document.new(params[:document])
    authorize @document

    if @document.save
      redirect_to admin_documents_path
    else
      render action: :new
    end
  end

  def edit
    @document = Document.find(params[:id])
    authorize @document
  end

  def update
    @document = Document.find(params[:id])
    authorize @document

    if @document.update(params[:document])
      redirect_to admin_documents_path
    else
      render action: :edit
    end
  end

  def destroy
    document = Document.find(params[:id])
    authorize document
    document.destroy

    redirect_to admin_documents_path
  end
end
