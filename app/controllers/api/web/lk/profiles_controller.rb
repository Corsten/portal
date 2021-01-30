class Api::Web::Lk::ProfilesController < Api::Web::Lk::ApplicationController
  rescue_from UserProfileService::TokenCheckError, with: :token_check_error

  #=begin
  # @api {get} /backend/api/web/lk/profile 01 Просмотр информации о текущем пользователе
  # @apiVersion 0.1.0
  # @apiGroup Profile
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/profile
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {
  #   "id": 1,
  #   "email": "vasya@pupkin.com",
  #   "full_name": "Пупкин Вася",
  #   "position": "Специалист",
  #   "organization": "Организация"
  # }
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def show
    render json: current_user, fields: %i[id email full_name organization position email]
  end

  #=begin
  # @api {patch} /backend/api/web/lk/profile 02 Обновление текущего пользователя
  # @apiVersion 0.1.0
  # @apiGroup Profile
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/profile
  # @apiParam {string} full_name ФИО
  # @apiParam {string} email Email
  # @apiParam {string} phone_number Номер телефона
  # @apiParam {string} organization Organization
  # @apiParam {string} position Position
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # { "code": "ok" }
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  # HTTP/1.1 422 Forbidden
  # {"code":"error","message": ["Email имеет неверный формат"]}
  #=end
  def update
    if current_user.update(update_permitted_params)
      render_ok
    else
      render_error :unprocessable_entity, :error, current_user.errors.full_messages
    end
  end

  private

  def update_permitted_params
    params.permit(:full_name, :email, :phone_number, :position, :organization)
  end

  def token_check_error
    render_error(:unprocessable_entity, :token_check_error, I18n.t('api.errors.token_check_error'))
  end
end
