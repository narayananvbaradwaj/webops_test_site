require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(roll: "mm12b037")
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
    valid_rolls = ['mm12b037', 'ee12b099', 'ed14b027', 'me13d034']
    valid_rolls.each do |valid_roll|
      @user.roll = valid_roll
      assert @user.valid?, "#{valid_roll} should be valid"
    end
  end

  # test 'roll should be invalid' do
  #   invalid_rolls = ['mm12b37e', 'e112b099', 'ed4b0027', 'm1d3f034']
  #   invalid_rolls.each do |invalid_roll|
  #     @user.roll = invalid_roll
  #     assert_not @user.valid?, "#{invalid_roll} should be invalid"
  #   end
  # end

  test 'roll should be unique' do
    duplicate_user = @user.dup
    duplicate_user.roll = duplicate_user.roll.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
