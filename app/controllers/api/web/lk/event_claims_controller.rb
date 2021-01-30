class Api::Web::Lk::EventClaimsController < Api::Web::Lk::ApplicationController
  #=begin
  # @api {post} /backend/api/web/lk/event_claims 03 Регистрация на событие
  # @apiVersion 0.1.0
  # @apiGroup Lk Content
  # @apiPermission Аутентифицированный клиент
  # @apiHeader {String} auth-token  Authentication Token
  # @apiParam {string} event_id id события
  # @apiParam {string} full_name ФИО
  # @apiParam {string} email Email
  # @apiParam {string} phone_number Номер телефона
  # @apiSampleRequest /backend/api/web/lk/event_claims
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {"code":"ok"}
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def create
    event_claim = current_user.event_claims.find_by(event_id: params[:event_id])
    event = Event.scheduled.find_by(id: params[:event_id])
    if event_claim.blank? && event.present?
      event_claim = event.claims.new(create_permitted_params)
      event_claim.user = current_user
      if event_claim.save
        Resque.enqueue(NewEventClaimJob, user_id: current_user.id, claim_id: event_claim.id)
        render json: { code: :ok }
      else
        render_error :unprocessable_entity, :error, event_claim.errors.full_messages
      end
    elsif event.nil?
      render_error :unprocessable_entity, :error, t('api.errors.claim_not_found')
    elsif event_claim.blocked?
      render_error :forbidden, :error, t('api.errors.confirmation_waiting')
    else
      render_error :forbidden, :error, t('api.errors.already_registered')
    end
  end

  #=begin
  # @api {get} /backend/api/web/lk/event_claims/check 04 Проверка регистрации на событие
  # @apiVersion 0.1.0
  # @apiGroup Lk Content
  # @apiPermission Аутентифицированный клиент
  # @apiHeader {String} auth-token  Authentication Token
  # @apiParam {string} event_id id события
  # @apiSampleRequest /backend/api/web/lk/event_claims/check
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {
  #   "code": "confirmation_waiting",
  #   "message": "translation missing: ru.api.errors.confirmation_waiting"
  # }
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def check
    event_claim = current_user.event_claims.find_by(event_id: params[:event_id])

    if event_claim.blank?
      render_error :forbidden, :error, t('api.errors.not_found')
    elsif event_claim.blocked?
      render_error :forbidden, :confirmation_waiting, t('api.errors.confirmation_waiting')
    else
      render_error :forbidden, :success, t('api.errors.success_registration')
    end
  end

  private

  def create_permitted_params
    params.permit(:full_name, :email, :phone_number)
  end
end
