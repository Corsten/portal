Configus.build Rails.env do
  env :production do
    administrators do
      administrator_session_lifetime 10
    end

    redis -> { Redis.new({ host: ENV.fetch('REDIS_HOST', 'redis'), port: ENV.fetch('REDIS_PORT', '6379'), password: ENV['REDIS_PASSWORD'] }.compact) }

    token do
      length 32
      auth_token_expire -> { ENV['AUTH_TOKEN_EXPIRE'] || 1.day }
      restore_password_token_expire -> { ENV['RESTORE_PASSWORD_TOKEN_EXPIRE'] || 20.minutes }
      confirm_email_token_expire -> { ENV['CONFIRM_EMAIL_TOKEN_EXPIRE'] || 1.day }
      change_attrs_token_expire -> { ENV['CHANGE_ATTRS_TOKEN_EXPIRE'] || 1.day }
    end

    mailer do
      default_host -> { ENV['DEFAULT_HOST'] }
      from 'Портал <noreply@info.ru>'
      reply_to 'noreply@info.ru'
      backoff_strategy [10.seconds, 1.minute, 5.minutes, 10.minutes, 1.hour, 3.hours, 6.hours]
      restore_password_path '/foget'
      change_email_path '/email-edit'
      backend_user_path '/backend/admin/users/'
      backend_event_claim_path '/backend/admin/events_claims/'
      success_confirm_email_path '/email-confirm/success'
      fail_confirm_email_path '/email-confirm/fail'
      allowed_change_email_path '/email-edit/success'
      not_allowed_confirm_email_path '/email-confirm/fail'
    end

    jobs do
      backoff_strategy [10.seconds, 1.minute, 5.minutes, 10.minutes, 1.hour, 3.hours, 6.hours]
    end

    uploader do
      max_file_size -> { ENV.fetch('MAX_FILE_SIZE', 10) }
    end
  end

  env :staging, parent: :production do
    token do
      restore_password_token_expire -> { 5.minutes }
      confirm_email_token_expire -> { 5.minutes }
    end

    mailer do
      default_host -> { ENV['DEFAULT_HOST'] }
      from 'Портал <noreply@info.ru>'
    end

    unisender_gateway do
      api_key -> { ENV.fetch('UNISENDER_API_KEY', '') }
      from -> { ENV.fetch('UNISENDER_FROM', 'fatk-marat@yandex.ru') }
      list_id -> { ENV.fetch('UNISENDER_LIST_ID', '17269633') }
    end
  end

  env :development, parent: :production do
    administrators do
      waiting_time_auth_attempts 1.minute
    end

    mailer do
      default_host 'http://0.0.0.0:8080'
    end

    proteus do
      landing_path 'http://domain.test'
      url 'http://local'
      memset 'test'
      limit 3
    end

    unisender_gateway do
      api_key -> { ENV.fetch('UNISENDER_API_KEY', '6dw4wnxcgrp16cje134f4rnnos3a18kkbkjd9sge') }
      from -> { ENV.fetch('UNISENDER_FROM', 'fatk-marat@yandex.ru') }
      list_id -> { ENV.fetch('UNISENDER_LIST_ID', '17269633') }
    end
  end

  env :test, parent: :development do
    mailer do
      default_host 'http://0.0.0.0:8080'
    end

    token do
      auth_token_expire 1.second
    end
  end
end
