module UserProfileService
  class TokenCheckError < StandardError; end

  module_function

  CRITICAL_ACCOUNT_PARAMS = %i[].freeze

  def update(user, params)
    new_email = params.key?(:email) && user.email != params[:email]

    user.assign_attributes(full_name: params[:full_name]) if params.key?(:full_name)
    user.assign_attributes(email: params[:email], confirmed_email: false) if new_email

    user.save
  end

  def changed_attributes(user, params)
    changed_attributes = {}

    params.each do |key, attr|
      changed_attributes[key.to_sym] = attr if user.send(key.to_s) != attr
    end
    changed_attributes
  end

  def can_update?(user, attrs, token)
    changed_attributes = changed_attributes(user, attrs)

    return true if (CRITICAL_ACCOUNT_PARAMS & changed_attributes.keys).empty?

    change_attrs_token = User::Token.change_attrs.with_expire_time(configus.token.change_attrs_token_expire).find_by(body: token)

    raise TokenCheckError unless change_attrs_token.present? && change_attrs_token.user == user

    true
  end
end
