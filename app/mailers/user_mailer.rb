class UserMailer < ApplicationMailer
  def successful_registration(user)
    @user = user
    mail to: @user.email
  end

  def unblock_user_notification(user)
    @user = user
    @login_url = configus.mailer.default_host
    mail to: @user.email
  end

  def restore_password(user, token)
    @user = user
    @restore_password_url = PathHelper.url_creator(configus.mailer.restore_password_path, token: token.body)
    mail to: @user.email
  end
end
