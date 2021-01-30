class Api::Web::Lk::PilotsController < Api::Web::Lk::ApplicationController
  #=begin
  # @api {post} /backend/api/web/lk/pilots/import 09 Импорт пилотов
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiPermission Аутентифицированный клиент
  # @apiHeader {String} auth-token  Authentication Token
  # @apiParam {array[string]} notes Примечания
  # @apiParam {file} document Файл
  # @apiSampleRequest /backend/api/web/lk/pilots/import
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {"code":"ok"}
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def import
    pilot_import = current_user.imports.new(import_permitted_params)
    if pilot_import.save
      Resque.enqueue(PilotImportJob, id: pilot_import.id, user_id: pilot_import.user.id)
      render json: { code: :ok }
    else
      render_error :unprocessable_entity, :error, pilot_import.errors.full_messages
    end
  end

  #=begin
  # @api {get} /backend/api/web/lk/pilots/pilot_template 02 Шаблон для создания пилотов
  # @apiVersion 0.1.0
  # @apiGroup Lk Content
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/pilots/pilot_template
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # [{
  #   "id": 4,
  #   "name": "Директивы",
  #   "kind": "decree",
  #   "kind_text": "Приказ",
  #   "document_date": "2018-12-06T00:00:00.000+03:00",
  #   "document_link": "/backend/files/main_page_documents/4"
  # }]
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def pilot_template
    pilot_template = Document.pilot_template
    render json: pilot_template, each_serializer: DocumentSerializer
  end

  private

  def import_permitted_params
    params.permit(:notes, :document)
  end
end
