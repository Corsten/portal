class Web::FilesController < Web::ApplicationController
  before_action :authorize_user!

  def product_documents
    product = Category::Product.find(params[:product_id])
    document = product.document
    send_data document.read, filename: product.document_original_filename
  end

  def testing_method_documents
    testing_method = Category::TestingMethod.find(params[:testing_method_id])
    document = testing_method.document
    send_data document.read, filename: testing_method.document_original_filename
  end

  def archive_documents
    archive = Category::Archive.find(params[:archive_id])
    document = archive.document
    send_data document.read, filename: archive.document_original_filename
  end

  def main_page_documents
    document = Document.find(params[:document_id])
    file = document.document
    send_data file.read, filename: document.document_original_filename
  end

  def working_group_member_photos
    document = Document.find(params[:document_id])
    file = document.document
    send_data file.read, filename: document.document_original_filename
  end
end
