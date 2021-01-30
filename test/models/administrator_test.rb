require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase
  test 'should valid administrator' do
    administrator = build :administrator
    assert administrator.valid?
  end

  test 'should not valid administrator without email' do
    administrator = build :administrator, email: nil
    assert administrator.invalid?
  end

  test 'should not valid administrator invalid email with invalid high level domain length' do
    administrator = build :administrator, email: 'a@a.a'
    assert administrator.invalid?
  end
end
