class ApplicationController < ActionController::Base
  layout "application"
  protect_from_forgery

  USER_NAME, PASSWORD = "mypolice", "wearesnook!"
  #before_filter :authenticate 
  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
      user_name = USER_NAME && password==PASSWORD
      end
      warden.custom_failure! if performed? 
    end
  
  protected 
  
  def local_request?
    false
  end
end
