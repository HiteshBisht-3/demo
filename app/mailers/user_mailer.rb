class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(
      to: email_address_with_name(@user.email, @user.username),
      subject: "Welcome to My Awesome Site"
    )
  end
end
