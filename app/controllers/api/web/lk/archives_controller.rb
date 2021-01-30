class Api::Web::Lk::ArchivesController < Api::Web::Lk::ApplicationController
  #=begin
  # @api {post} /backend/api/web/lk/archives 05 Создание архива
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiPermission Аутентифицированный клиент
  # @apiHeader {String} auth-token  Authentication Token
  # @apiParam {string} group_id id группы в которую доавится архив
  # @apiParam {string} customer_name Наименование организации-заказчика
  # @apiParam {string} notes Примечания
  # @apiParam {file} document Файл
  # @apiSampleRequest /backend/api/web/lk/archives
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {
  #   "id":1,
  #   "group_id": "4",
  #   "category_id": "1",
  #   "customer_name": "Test",
  #   "notes": "Test"
  #   "document_link": "/backend/files/archive_documents/5",
  # }
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def create
    group = Category::Group.find(params[:group_id])
    archive = group.archives.new(create_permitted_params)
    archive.user = current_user
    if archive.save
      Resque.enqueue(ArchiveImportJob, id: archive.id, user_id: archive.user.id)
      render json: archive, serializer: Category::ArchiveSerializer
    else
      render_error :unprocessable_entity, :error, archive.errors.full_messages
    end
  end

  private

  def create_permitted_params
    params.permit(:customer_name, :notes, :document)
  end
end
