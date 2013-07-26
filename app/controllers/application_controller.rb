class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
  	'/articles/'

  end

private 

  def track_activity(trackable, action = params[:action])
  	current_user.activities.create! action: action, trackable: trackable
  end
end
