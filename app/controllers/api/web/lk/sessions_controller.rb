class Api::Web::Lk::SessionsController < Api::Web::Lk::ApplicationController
  skip_before_action :raise_error_if_user_not_signed_in, only: %i[create destroy]
  skip_after_action :renew_user_auth_token!, only: :destroy

  include ActionView::Helpers::UrlHelper

  #=begin
  # @api {post} /backend/api/web/lk/session 01 Создание сессии
  # @apiVersion 0.1.0
  # @apiGroup Sessions
  # @apiParam {string} email Email
  # @apiParam {string} password Пароль
  # @apiSampleRequest /backend/api/web/lk/session
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {"code":"ok", "auth_token": "Mz6LwCykBvln555laX1oodVlO5YebfV8"}
  # @apiError {string} code Результат выполнения запроса.
  #   @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def create
    user = User.active.by_downcase_email(params[:email]).first

    if user.blank?
      render_error :forbidden, :auth_error, t('api.errors.not_registered_email')
    elsif user.blocked?
      render_error :forbidden, :auth_error, t('api.errors.not_active_user')
    elsif user.need_recover_pass
      restore_password_url = restore_passwort_url(user)
      render_error :forbidden, :auth_error, t('api.errors.need_recover_password', link: link_to(restore_password_url, restore_password_url, target: :_blank))
    elsif user&.authenticate params[:password]
      auth_token = user_sign_in user
      render json: { code: :ok, auth_token: auth_token }
    else
      render_error :forbidden, :auth_error, t('api.errors.invalid_password')
    end
  end

  #=begin
  # @api {delete} /backend/api/web/lk/session 02 Удаление сессии
  # @apiVersion 0.1.0
  # @apiGroup Sessions
  # @apiSampleRequest /backend/api/web/lk/session
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {"code":"ok"}
  # @apiError {string} code Результат выполнения запроса.
  #=end
  def destroy
    user_sign_out
    render json: { code: :ok }
  end

  #=begin
  # @api {get} /backend/api/web/lk/session/check 03 Проверка сессии
  # @apiVersion 0.1.0
  # @apiGroup Sessions
  # @apiSampleRequest /backend/api/web/lk/session/check
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {"code":"ok"}
  # @apiError {string} code Результат выполнения запроса.
  #   @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def check
    render json: { code: :ok }
  end

  private

  def restore_passwort_url(user)
    token = TokenService.generate_restore_password_token(user)
    PathHelper.url_creator(configus.mailer.restore_password_path, token: token.body)
  end
end
