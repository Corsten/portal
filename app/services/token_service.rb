module TokenService
  module_function

  def generate_restore_password_token(user)
    user.tokens.create(kind: :restore_password, body: generate_random_token)
  end

  def generate_confirm_email_token(user)
    user.tokens.create(kind: :confirm_email, body: generate_random_token)
  end

  def generate_change_attrs_token(user)
    user.tokens.create(kind: :change_attrs, body: generate_random_token)
  end

  def generate_random_token
    token = CodeGenerator.random_token
    token_exist?(token) ? generate_random_token : token
  end

  def token_exist?(token)
    User::Token.exists?(body: token)
  end
end
