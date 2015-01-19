require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:Abhishek)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'roll should be present' do
    @user.roll = "   "
    assert_not @user.valid?
  end

  test 'roll should be 8 characters long' do
    @user.roll = "mmm12b037"
    assert_not @user.valid?
    @user.roll = "m12b037"
    assert_not @user.valid?
  end

  test 'roll should be valid' do
    valid_rolls = ['mm12b037', 'ee12b099', 'ed14b027', 'me13d034', 'MM12b037']
    valid_rolls.each do |valid_roll|
      @user.roll = valid_roll
      assert @user.valid?, "#{valid_roll} should be valid"
    end
  end

  test 'roll should be invalid' do
    invalid_rolls = ['mm12b37e', 'e112b099', 'ed4b0027', 'm1d3f034']
    invalid_rolls.each do |invalid_roll|
      @user.roll = invalid_roll
      assert_not @user.valid?, "#{invalid_roll} should be invalid"
    end
  end

  test 'roll should be unique' do
    duplicate_user = @user.dup
    duplicate_user.roll = duplicate_user.roll.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should have a minimum length of 6' do
    @user.password = @user.password_confirmation = "f" * 5
    assert_not @user.valid?
  end

  test "roll should be saved as lower-case" do
    mixed_case_roll = "Mm12B037"
    @user.roll = mixed_case_roll
    @user.save
    assert_equal mixed_case_roll.downcase, @user.reload.roll
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
end
