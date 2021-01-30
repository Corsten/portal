require 'test_helper'

class Api::Web::UserTokensControllerTest < ActionDispatch::IntegrationTest
  test 'should get restore password token' do
    token = create :user_token_restore_password
    get restore_password_token_exist_api_web_user_tokens_url(token: token.body)
    assert_response :success
  end

  test 'should not found restore password token' do
    token = create :user_token_confirm_email
    get restore_password_token_exist_api_web_user_tokens_url(token: token.body)
    assert_response :not_found
  end
end
