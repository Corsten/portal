require 'test_helper'

class Api::Web::Lk::ProfilesControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end

  test 'should get show' do
    user_sign_in(@user)

    get :show
    assert_response :success
  end

  test "should patch update user's full_name" do
    user_sign_in(@user)
    attrs = { full_name: generate(:full_name) }

    patch :update, params: attrs
    assert_response :success

    @user.reload
    assert_equal attrs[:full_name], @user.full_name
  end

  test "should patch update user's organization" do
    user_sign_in(@user)
    attrs = { organization: generate(:organization) }

    patch :update, params: attrs
    assert_response :success

    @user.reload
    assert_equal attrs[:organization], @user.organization
  end

  test "should patch update user's position" do
    user_sign_in(@user)
    attrs = { position: generate(:position) }

    patch :update, params: attrs
    assert_response :success

    @user.reload
    assert_equal attrs[:position], @user.position
  end

  test "should patch update user's email" do
    user_sign_in(@user)

    attrs = { email: generate(:email) }

    patch :update, params: attrs
    assert_response :success

    @user.reload
    assert_equal attrs[:email], @user.email
  end
end
