class Web::Admin::SessionsController < Web::Admin::ApplicationController
  auto_session_timeout_actions

  def new
    redirect_to admin_root_path_for(current_administrator) if administrator_signed_in?
  end

  def create
    administrator = Administrator.find_by(email: params[:administrator][:email])

    if administrator.blank?
      flash.now[:danger] = t('flashes.sessions.create.not_found_administrator')
      render :new
    elsif administrator&.authenticate(params[:administrator][:password])
      administrator_sign_in administrator
      redirect_to stored_location_for(:administrator) || admin_root_path_for(administrator)
    else
      flash.now[:danger] = t('flashes.sessions.create.fail_login_invalid_password')
      render :new
    end
  end

  def destroy
    administrator_sign_out
    reset_session
    redirect_to new_admin_session_path
  end
end
