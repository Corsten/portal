require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  setup do
    administrator = create :admin
    administrator_sign_in administrator

    @user = create :user
  end

  test 'should get users list' do
    get :index
    assert_response :success
  end

  test 'should get new user' do
    get :new
    assert_response :success
  end

  test 'should post create user' do
    user_attrs = attributes_for :user

    post :create, params: { user: user_attrs }
    assert_response :redirect

    user = User.find_by(email: user_attrs[:email])
    assert user.present?
  end

  test 'should get edit user' do
    get :edit, params: { id: @user }
    assert_response :success
  end

  test 'should put update user' do
    user_attrs = {}
    user_attrs[:full_name] = generate :full_name

    put :update, params: { id: @user.id, user: user_attrs }
    assert_response :redirect

    @user.reload
    assert_equal user_attrs[:full_name], @user.full_name
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete :destroy, params: { id: @user }
    end
    assert_response :redirect
  end

  test 'should post block user' do
    @user = create :actual_user

    post :block, params: { id: @user }
    assert_response :redirect

    @user.reload
    assert @user.blocked?
  end

  test 'should post unblock user' do
    blocked_user = create :blocked_user

    post :unblock, params: { id: blocked_user }
    assert_response :redirect

    blocked_user.reload
    assert blocked_user.actual?
  end
end
