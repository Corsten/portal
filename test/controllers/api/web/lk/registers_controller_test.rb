require 'test_helper'

class Api::Web::Lk::RegistersControllerTest < ActionController::TestCase
  setup do
    @user = create :user
  end

  test 'should get product register' do
    user_sign_in @user

    get :product_register

    assert_response :success
  end
end
