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
    unless params[:controller] == "devise/sessions" && ["create", "new"].include?(params[:action])
      if get_resource_class
        self.class.load_and_authorize_resource :class => get_resource_class
      else
        self.class.load_and_authorize_resource
      end
    end
  end

  def resource_class_map
    { "ec2/instances" => Ec2Instance,
      "ec2/volumes" => Ec2Volume,
      "ec2/snapshots" => Ec2Snapshot
    }
  end

  def get_resource_class
    resource_class_map[params[:controller]]
  end

end
