class UserMailer < ActionMailer::Base
  default from: ApplicationSettings.config['system_reply_email']


  # Sends a user an email with a confirmation link, requesting
  # that they click to activate their account.
  def confirmation_email(user)
    @user = user
    @url = confirmation_path(user.token, {:only_path => false})
    mail(:to => user.email, :subject => "New User Confirmation")
  end


  # Advises user that their registration is complete and that they may now login
  def confirmation_complete_email(user)
    @user = user
    mail(:to => user.email, :subject => "Registration Complete")
  end


  def send_password(user, password)
    @user = user
    @password = password
    @url = login_path({:only_path => false})
    mail(:to => user.email, :subject => "Account Created")
  end


  def password_reset_request(user)
    @user = user
    @url = update_password_path(@user.reset_token, {:only_path => false})
    mail(:to => @user.email, :subject => "Password Reset Request")
  end


end
