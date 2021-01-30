class Api::Web::UserTokensController < Api::Web::ApplicationController
  #=begin
  # @api {get} /backend/api/web/user_tokens/restore_password_token_exist 01 Существует ли токен восстановления пароля
  # @apiVersion 0.1.0
  # @apiGroup UserTokens
  # @apiParam {string} token Токен
  # @apiSampleRequest /backend/api/web/user_tokens/restore_password_token_exist
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # {"code": "ok"}
  # @apiErrorExample {json} Запись не найдена
  # HTTP/1.1 404: Not Found
  # {"code": "not_found","message": "Запись не найдена"}
  #=end
  def restore_password_token_exist
    User::Token.restore_password.with_expire_time(configus.token.restore_password_token_expire).find_by!(body: params[:token])
    render_ok
  end
end
