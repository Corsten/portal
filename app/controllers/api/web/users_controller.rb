class Api::Web::UsersController < Api::Web::ApplicationController
  #=begin
  # @apiGroup Users
  # @api {post} /backend/api/web/users 01 Создать пользователя
  # @apiVersion 0.1.0
  # @apiName Create verified user
  # @apiDescription Создание пользователя
  # @apiPermission all
  # @apiParam {String} full_name ФИО
  # @apiParam {String} password Пароль
  # @apiParam {String} password_confirmation Подтверждение пароля
  # @apiParam {String} email Email
  # @apiParam {String} phone_number Номер телефона (маска: +7 000 000-00-00)
  # @apiParam {String} organization Организация
  # @apiParam {String} position Должность
  # @apiSuccessExample {json} Success
  # { "code":"ok", "auth_token": "Mz6LwCykBvln555laX1oodVlO5YebfV8"}
  # @apiSuccessExample {json} Error
  # { "code": "error", message: ['Email имеет неверное значение'] }
  # @apiSampleRequest /backend/api/web/users
  #=end
  def create
    user = User.find_by(email: permitted_params[:email])

    if user.present? && user.blocked?
      render_error :forbidden, :auth_error, t('api.errors.not_active_user')
    else
      user = User.new permitted_params
      if user.save
        Resque.enqueue(UserRegistrationJob, user.id)
        render json: { code: :ok }
      else
        render_error :unprocessable_entity, :error, user.errors.full_messages
      end
    end
  end

  #=begin
  # @api {post} /backend/api/web/users/send_restore_password_email 02 Отправить письмо для восстановления пароля
  # @apiVersion 0.1.0
  # @apiGroup Users
  # @apiParam {string} email E-mail пользователя
  # @apiSampleRequest /backend/api/web/users/send_restore_password_email
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {"code": "ok"}
  # @apiErrorExample {json} Запись не найдена
  # HTTP/1.1 404: Not Found
  # {"code": "not_found","message": "Запись не найдена"}
  #=end
  def send_restore_password_email
    user = User.actual.by_downcase_email(params[:email]).first

    if user.present?
      Resque.enqueue(UserRestorePasswordJob, user.id)
      render_ok
    else
      render_error :unprocessable_entity, :error, t('api.errors.not_registered_email')
    end
  end

  #=begin
  # @api {patch} /backend/api/web/users/update_password 03 Обновление пароля пользователя
  # @apiVersion 0.1.0
  # @apiGroup Users
  # @apiParam {string} token Токен для восстановления пароля (из письма)
  # @apiParam {string} password Новый пароль
  # @apiParam {string} password_confirmation Подтверждение нового пароля
  # @apiSampleRequest /backend/api/web/users/update_password
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # { code: :ok }
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Запись не найдена
  # HTTP/1.1 404: Not Found
  # {"code": "not_found","message": "Запись не найдена"}
  #=end
  def update_password
    token = User::Token.restore_password.with_expire_time(configus.token.restore_password_token_expire).find_by!(body: params[:token])
    user = token.user.becomes Api::UserUpdatePasswordType

    if user.update(update_password_params)
      user.need_recover_pass = false
      user.save
      render_ok
    else
      render_error :unprocessable_entity, :error, user.errors
    end
  end

  private

  def permitted_params
    params.permit(:full_name, :password, :password_confirmation, :email, :phone_number, :organization, :position)
  end

  def update_password_params
    params.permit(:password, :password_confirmation)
  end
end
