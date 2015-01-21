class AccountActivationsController < ApplicationController

  def edit
    roll_from_smail = params[:email][0, 8]
    user = User.find_by(roll: roll_from_smail)
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end