class DocumentSerializer < ActiveModel::Serializer
  include Concerns::UploadInfo

  attributes :id, :name, :kind, :kind_text, :document_date, :document_link

  def document_date
    object.document_date.present? ? I18n.l(object.document_date, format: :only_date) : object.document_date
  end
end
