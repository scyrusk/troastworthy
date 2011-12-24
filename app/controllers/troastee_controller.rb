
class TroasteeController < ApplicationController
  before_filter :authenticate

  def index
    @vis_js = 1
    @stylesheets = [ 'troastee' ]

    if params[:ball] != nil
      @user = User.find_by_pid(params[:ball])
      session[:troastee] = @user.pid if @user != nil
      @troaster = User.find_by_uid(session[:troaster])
    else
      @user = User.find_by_pid(session[:troastee])
      @troaster = User.find_by_uid(session[:troaster])
    end
    @troasts = @user.about_troasts.sort{|a,b| b.date <=>a.date}
  end

  def deleteAT
    @vis_js = 1
    puts 'Getting to deleteAT'
    if params[:id]
      @troast = Troast.find_by_id(params[:id])
      @troastee = User.find_by_pid(session[:troastee])
      @troastee.deleteAboutTroast(@troast)
      @troastee.save
      @troast.destroy

      @troasts = @troastee.about_troasts.sort{|a,b| b.date<=>a.date}

      @from_delete = true
      render '/troastee/index.js.erb', :layout => false
    end
  end

  protected
  def authenticate
    if session[:troaster] == nil
      flash[:notice] = 'Whoops, looks like we can\'t figure out who you are, please enter your access token again'
      redirect_to root_url  
    else
        troaster_uid = session[:troaster]
        troastee = (params[:ball] == nil ? User.find_by_pid(session[:troastee]) : User.find_by_pid(params[:ball]))
        if troaster_uid == troastee.uid
          flash[:notice] = 'Whoops, you\'re not allowed to look at that! Shoo!'
          redirect_to "http://www.dafk.net/what/"
        end
    end
  end
end
