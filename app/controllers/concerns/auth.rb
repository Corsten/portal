module Concerns
  module Auth
    def administrator_sign_in(administrator)
      session[:administrator_id] = administrator.id
    end

    def administrator_sign_out
      session[:administrator_id] = nil
    end

    def current_administrator
      @current_administrator ||= Administrator.find_by(id: session[:administrator_id])
    end

    def administrator_signed_in?
      current_administrator
    end

    def authenticate_administrator!
      store_location_for(:administrator, request.original_url)
      redirect_to new_admin_session_path unless administrator_signed_in?
    end

    def user_sign_in(user)
      auth_token = new_unique_user_auth_token
      store.set auth_token, user.id
      user_auth_token_expiration auth_token
      cookies_set_user_auth_token auth_token
      auth_token
    end

    def current_user
      @current_user ||= User.find_by(id: token_user_id)
    end

    def user_signed_in?
      current_user.present?
    end

    def user_sign_out
      return if user_auth_token.blank?
      store.del user_auth_token
      cookies.delete(:auth_token)
    end

    def user_auth_token_exists?(auth_token)
      store.exists auth_token
    end

    def user_auth_token_expiration(auth_token)
      store.expire auth_token, configus.token.auth_token_expire
    end

    def raise_error_if_user_not_signed_in
      raise Api::Web::Lk::ApplicationController::UserNotAuthenticated unless user_signed_in?
    end

    def renew_user_auth_token!
      return if user_auth_token.blank?
      user_auth_token_expiration(user_auth_token)
    end

    private

    def cookies_set_user_auth_token(auth_token)
      cookies[:auth_token] = if Rails.env.test?
                               auth_token
                             else
                               { value: auth_token, expires: configus.token.auth_token_expire, httponly: true }
                             end
    end

    def new_unique_user_auth_token
      token = CodeGenerator.random_token
      return token unless user_auth_token_exists? token
      new_unique_user_auth_token
    end

    def user_auth_token
      @user_auth_token ||= cookies[:auth_token].presence
    end

    def token_user_id
      @token_user_id = store.get(user_auth_token) if user_auth_token.present?
    end

    def store
      TokenStore.instance.connection
    end
  end
end
