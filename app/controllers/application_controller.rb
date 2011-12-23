class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
    render :inline => "<%= search_field(:user,:uid) %>"
  end
end
