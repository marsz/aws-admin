class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not authorized to access this page #{request.env["HTTP_REFERER"]}"
    redirect_to request.env["HTTP_REFERER"] || root_url
  end

  private

  def authenticate_user!
    super
    self.class.load_and_authorize_resource unless params[:controller] == "devise/sessions" && ["create", "new"].include?(params[:action])
  end

end
