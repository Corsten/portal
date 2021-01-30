class Api::Web::Lk::RegistersController < Api::Web::Lk::ApplicationController
  include Reporters::Helpers

  MS_WORD_MIME_TYPE = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'.freeze
  #=begin
  # @api {get} /backend/api/web/lk/registers/product_register 01 Структура карты
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/registers/product_register
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # [{
  #
  # }]
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def product_register
    category = Category.by_register_kind(:products).includes(groups: :products).all
    render json: category, include: ['groups', 'groups.products'], each_serializer: CategorySerializer
  end

  #=begin
  # @api {get} /backend/api/web/lk/registers/pilot_register 02 Реестр пилотов
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/registers/pilot_register
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # [{
  #
  # }]
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def pilot_register
    category = Category.by_register_kind(:pilots).includes(groups: :pilots).all
    render json: category, include: ['groups', 'groups.pilots'], each_serializer: CategorySerializer
  end

  #=begin
  # @api {get} /backend/api/web/lk/registers/testing_method_register 03 Реестр методик тестирования
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/registers/testing_method_register
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # [{
  #
  # }]
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def testing_method_register
    category = Category.by_register_kind(:testing_methods).includes(groups: :testing_methods).all
    render json: category, include: ['groups', 'groups.testing_methods'], each_serializer: CategorySerializer
  end

  #=begin
  # @api {get} /backend/api/web/lk/registers/archive_register 04 Реестр архива
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/registers/archive_register
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # [{
  #
  # }]
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def archive_register
    category = Category.by_register_kind(:archives).includes(groups: :archives).all
    render json: category, include: ['groups', 'groups.archives'], each_serializer: CategorySerializer
  end

  #=begin
  # @api {get} /backend/api/web/lk/registers/categories_list 07 Список категорий в реестре
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiParam {string} register_kind Register kind (archives, testing_methods ...)
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/registers/categories_list
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # [{
  #   "id": 1,
  #   "name": "Test",
  #   "created_at": "2019-07-10T21:42:31.499+03:00",
  #   "updated_at": "2019-07-10T21:42:31.499+03:00"
  # }]
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def categories_list
    categories_list = params[:register_kind].present? ? Category.by_register_kind(params[:register_kind].to_sym) : Category.all
    render json: categories_list.as_json
  end

  #=begin
  # @api {get} /backend/api/web/lk/registers/category_groups_list 08 Список классов в категорий реестра
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiParam {string} category_id Category ID
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/registers/category_groups_list
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # [{
  #   "id": 2,
  #   "category_id": 1,
  #   "name": "Тестовый класс",
  #   "created_at": "2019-07-10T22:07:10.617+03:00",
  #   "updated_at": "2019-07-10T22:07:10.617+03:00"
  # }]
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def category_groups_list
    groups_list = Category.find(params[:category_id]).groups
    render json: groups_list.as_json
  end

  #=begin
  # @api {get} /backend/api/web/lk/registers/export_product_register 10 Выгрузка карты в формате XLSX
  # @apiVersion 0.1.0
  # @apiGroup Lk
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/registers/export_product_register
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def export_product_register
    products = Category::Product.all
    report = Reporters::MapReporter.new(MapReporterDecorator.decorate_collection(products))
    send_data(report.document, type: MS_WORD_MIME_TYPE, filename: report.report_file_name)
  end
end
