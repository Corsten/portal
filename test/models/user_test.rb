require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'not valid user with small password' do
    user = build :user
    user.password = '123'
    user.password_confirmation = user.password

    assert user.invalid?
  end

  test 'not valid user with russian letters' do
    user = build :user
    user.password = 'абвгдезжзикл'
    user.password_confirmation = user.password

    assert user.invalid?
  end

  test "not valid user with password which contains user's email" do
    user = build :user
    user.password = user.email
    user.password_confirmation = user.email

    assert user.invalid?
  end

  test 'not create client with invalid phone_number' do
    user = build :user, phone_number: '+7-(800)-200-06-00'
    user.save
    assert user.new_record?
  end

  test 'not create client with invalid phone_number 2' do
    user = build :user, phone_number: '+7 (800) 200-06-00'
    user.save
    assert user.new_record?
  end
end
