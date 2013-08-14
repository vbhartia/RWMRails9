class StaticPagesController < ApplicationController
  def home_page
    #flash.alert = "alert"
    #flash.notice = "notice"
    @home_page = true
  end

  def about
  end

  def contact
  end

  def talent
  end

  def bookmarklet
  end

end
