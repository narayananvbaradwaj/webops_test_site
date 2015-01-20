require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:Abhishek)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.smail], mail.to
    assert_equal ["noreply@thewebopsclub.org"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  # test "password_reset" do
  #   user = users(:Abhishek)
  #   mail = UserMailer.password_reset
  #   assert_equal "Password reset", mail.subject
  #   assert_equal [user.smail], mail.to
  #   assert_equal ["noreply@thewebopsclub.org"], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end

end
