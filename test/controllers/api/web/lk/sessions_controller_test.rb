require 'test_helper'

class Api::Web::Lk::SessionsControllerTest < ActionController::TestCase
  setup do
    @user = create :actual_user
  end

  test 'should create auth_token' do
    params = { email: @user.email, password: @user.password }
    post :create, params: params

    assert_response :success
    assert user_auth_token_exists?(json[:auth_token])
  end

  test 'should create auth_token for user with upcase email' do
    params = { email: @user.email.upcase, password: @user.password }
    post :create, params: params

    assert_response :success
    assert user_auth_token_exists?(json[:auth_token])
  end

  test 'should not create auth_token for user with bad password' do
    user = create :user
    params = { email: user.email, password: '' }
    post :create, params: params
    assert_response :forbidden
  end

  test 'should destroy auth_token' do
    auth_token = user_sign_in(@user)
    @request.headers['auth-token'] = auth_token
    delete :destroy

    assert_response :success
    assert_not user_auth_token_exists?(auth_token)
  end

  test 'should expire auth_token' do
    params = { email: @user.email, password: @user.password }
    post :create, params: params

    assert_response :success
    sleep configus.token.auth_token_expire
    assert_not user_auth_token_exists?(json[:auth_token])
  end

  test 'should show session' do
    user_sign_in(@user)
    get :check
    assert_response :success
    assert user_signed_in?
  end

  test 'should not show session without token' do
    get :check
    assert_response :forbidden
  end

  private

  def json
    JSON.parse(response.body).deep_symbolize_keys
  end
end
