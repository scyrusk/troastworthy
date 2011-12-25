class PublicController < ApplicationController
  def index
    session[:troaster] = nil
    session[:troastee] = nil
    @vis_js = 1
    @stylesheets = [ 'public' ]
  end

  def search
    @stylesheets = [ 'public' ]
    @vis_js = 1

    if params[:search]
      @users = User.all.select{|a| a.uid != params[:search]}
      @user = User.search(params[:search])
      session[:troaster] = @user.uid if @user != nil
    elsif session[:troaster]
      @users = User.all.select{|a| a.uid != session[:troaster]}
      @user = User.find_by_uid(session[:troaster])
    end

    unless @user
      session[:failCount] = (session[:failCount] ? session[:failCount] + 1 : 1);
      flash[:notice] = 'Whoops, looks like we can\'t figure out who you are, please enter your access token again'
      if session[:failCount] >= 5
        redirect_to "http://www.dafk.net/what/"
      else
        redirect_to root_url     
      end
    end
  end

#  def reqDecrypt
#    unless params[:enc] == nil
#      text = User.unsub(params[:enc],CAESAR_KEY)
#      render :text => text
#    end
#  end

#  def sendATMailsFTW
#    User.all.each do |u|
#      puts u.email
#      UserMailer.AT_email(u).deliver
#    end

#    render :text => 'Emails sent!'
#  end
end
