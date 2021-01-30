require 'test_helper'

class Web::Admin::SessionsControllerTest < ActionController::TestCase
  setup do
    @administrator = create :administrator
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should sign in admin' do
    params = { email: @administrator.email, password: @administrator.password }
    post :create, params: { administrator: params }

    assert_equal current_administrator, @administrator
    assert_redirected_to admin_administrators_path
  end

  test 'should not sign in administrator with wrong password' do
    administrator_attrs = attributes_for :administrator
    params = { email: administrator_attrs[:email], password: administrator_attrs[:password] }
    post :create, params: { administrator: params }

    assert_not_equal current_administrator, @administrator
    assert_response :success
  end

  test 'should sign out administrator' do
    administrator_sign_in @administrator
    delete :destroy

    assert_not administrator_signed_in?
    assert_redirected_to new_admin_session_path
  end
end
