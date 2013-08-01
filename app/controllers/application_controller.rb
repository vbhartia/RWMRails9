class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :store_location

  def store_location
 	# store last url - this is needed for post-login redirect to whatever the user last visited.
    puts request
    if (request.fullpath != "/login" && 
       (request.fullpath != "/logout" &&
        !request.xhr?)) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end



  def after_sign_in_path_for(resource)
  	#session[:previous_url] || bookmarklet_path
    #myarticles_path

    bookmarklet_path
  end

private 

  def track_activity(trackable, action = params[:action])
  	current_user.activities.create! action: action, trackable: trackable
  end
end
