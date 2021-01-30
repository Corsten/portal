class Api::Web::Lk::TestingMethodsController < Api::Web::Lk::ApplicationController
  #=begin
  # @api {post} /backend/api/web/lk/testing_methods 06 Создание методики тестирования
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiPermission Аутентифицированный клиент
  # @apiHeader {String} auth-token  Authentication Token
  # @apiParam {string} group_id id группы в которую доавится методика
  # @apiParam {string} customer_name Наименование организации-заказчика
  # @apiParam {string} notes Примечания
  # @apiParam {file} document Файл
  # @apiSampleRequest /backend/api/web/lk/testing_methods
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {
  #   "id":1,
  #   "group_id": "4",
  #   "category_id": "1",
  #   "customer_name": "Test",
  #   "notes": "Test"
  #   "document_link": "/backend/files/testing_method_documents/5",
  # }
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def create
    group = Category::Group.find(params[:group_id])
    testing_method = group.testing_methods.new(create_permitted_params)
    testing_method.user = current_user
    if testing_method.save
      Resque.enqueue(TestingMethodImportJob, id: testing_method.id, user_id: testing_method.user.id)
      render json: testing_method, serializer: Category::TestingMethodSerializer
    else
      render_error :unprocessable_entity, :error, testing_method.errors.full_messages
    end
  end

  private

  def create_permitted_params
    params.permit(:customer_name, :notes, :document, :group_id)
  end
end
