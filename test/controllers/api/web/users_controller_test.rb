require 'test_helper'

class Api::Web::UsersControllerTest < ActionController::TestCase
  test 'should post create' do
    attrs = attributes_for(:user).slice(:full_name, :password, :password_confirmation, :email, :position, :organization)

    assert_difference('User.count') do
      post :create, params: attrs
    end

    assert_response :success
  end

  test 'should post send email restore password by email' do
    user = create :user

    user.unblock!

    post :send_restore_password_email, params: { email: user.email }
    assert_response :success
  end

  test 'should patch update password' do
    token = create :user_token_restore_password
    user = token.user
    password = generate :password
    attrs = { token: token.body, password: password, password_confirmation: password }

    patch :update_password, params: attrs
    assert_response :success

    user.reload
    assert user&.authenticate attrs[:password]
  end

  test 'should not patch update password' do
    token = create :user_token_restore_password
    user = token.user
    password = generate :password
    attrs = { token: token.body, password: password, password_confirmation: 'SUPERpassword120' }

    patch :update_password, params: attrs
    assert_response :unprocessable_entity

    user.reload
    assert_not user&.authenticate attrs[:password]
  end
end
