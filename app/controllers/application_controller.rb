class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :store_location

  def store_location
 	# store last url - this is needed for post-login redirect to whatever the user last visited.
    
    puts '**********************************'
    puts request.fullpath
    if (request.fullpath != "/users/logout#_=_") # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    puts 'in sign in **********************************'
    puts current_user.firstname

    if session[:previous_url] = '/'
      bookmarklet_path
    else
      session[:previous_url]
    end

    #session[:previous_url] || bookmarklet_path
    #myarticles_path

    #bookmarklet_path
  end

private 

  def track_activity(trackable, action = params[:action])
  	current_user.activities.create! action: action, trackable: trackable
  end

  def after_sign_out_path_for(resource_or_scope)
    flash.alert = 'Successfully Logged Out'
    root_path
  end
end
