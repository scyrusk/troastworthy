class UserMailer < ActionMailer::Base
  default from: "troastworthy@gmail.com"

  def AT_email(user)
    @user = user
    mail(:to => user.email, :subject => 'Welcome to Troastworthy!')
  end
end
