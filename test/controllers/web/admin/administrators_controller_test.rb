require 'test_helper'

class Web::Admin::AdministratorsControllerTest < ActionController::TestCase
  setup do
    @admin = create :admin
  end

  test 'should get a list of administrators' do
    administrator_sign_in @admin
    get :index
    assert_response :success
  end

  test 'should get new administrator' do
    administrator_sign_in @admin
    get :new
    assert_response :success
  end

  test 'should post create administrator' do
    administrator_sign_in @admin

    admin_attrs = attributes_for :administrator

    post :create, params: { administrator: admin_attrs }
    assert_response :redirect

    administrator = Administrator.find_by(email: admin_attrs[:email])
    assert administrator.present?
  end

  test 'should get edit admin' do
    administrator_sign_in @admin
    get :edit, params: { id: @admin }
    assert_response :success
  end

  test 'should put update admin' do
    administrator_sign_in @admin

    admin_attrs = {}
    admin_attrs[:name] = generate :name

    put :update, params: { id: @admin.id, administrator: admin_attrs }
    assert_response :redirect
    assert_redirected_to admin_administrators_path

    @admin.reload
    assert_equal admin_attrs[:name], @admin.name
  end

  test 'should delete destroy admin' do
    administrator_sign_in @admin

    administrator = create :administrator

    assert_difference('Administrator.count', -1) do
      delete :destroy, params: { id: administrator }
    end

    assert_response :redirect
  end

  test 'should not delete destroy oneself' do
    administrator_sign_in @admin

    assert_difference('Administrator.count', 0) do
      delete :destroy, params: { id: @admin }
    end

    assert_redirected_to admin_administrators_path
  end
end
