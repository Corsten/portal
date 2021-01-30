class AdminMailer < ApplicationMailer
  default to: -> { Administrator.all_admins.pluck(:email) }

  def new_user_notification(options = {})
    @user = options[:user]
    @user_url = user_url(id: @user.id)
    mail to: Administrator.new_users_notification_admins.pluck(:email)
  end

  def new_pilot_import_notification(options = {})
    @created_at = options[:created_at]
    @user = options[:user]
    attachments[options[:original_filename].to_s] = {
      mime_type: options[:content_type],
      content: options[:document].read
    }

    mail to: Administrator.new_pilots_notification_admins.pluck(:email)
  end

  def new_testing_method_import_notification(options = {})
    @created_at = options[:created_at]
    @user = options[:user]
    attachments[options[:original_filename].to_s] = {
      mime_type: options[:content_type],
      content: options[:document].read
    }

    mail to: Administrator.new_testing_methods_notification_admins.pluck(:email)
  end

  def new_event_claim_notification(options = {})
    @claim = options[:claim]
    @user = options[:user]
    @event = @claim.event

    @claim_url = claim_url(id: @claim.id)

    mail to: Administrator.new_event_claim_notification_admins.pluck(:email)
  end

  def user_url(options = {})
    uri = URI.join(
      configus.mailer.default_host,
      configus.mailer.backend_user_path,
      "#{options[:id]}/",
      'edit'
    )
    uri.to_s
  end

  def claim_url(options = {})
    uri = URI.join(
      configus.mailer.default_host,
      configus.mailer.backend_event_claim_path,
      "#{options[:id]}/",
      'edit'
    )
    uri.to_s
  end
end
