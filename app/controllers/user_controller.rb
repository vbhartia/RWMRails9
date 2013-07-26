class UserController < ApplicationController
	def info
	  output = User.find(params[:user_id])

	  puts params[:user_id]

	  respond_to do |format|
        format.json { render :json => output }
      end
    end
end
