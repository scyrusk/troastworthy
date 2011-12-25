class UserMailer < ActionMailer::Base
  default from: "sauvik+tw@cmu.edu"

  def AT_email(user)
    @user = user
    mail(:to => user.email, :subject => 'Welcome to Troastworthy!')
  end
end
