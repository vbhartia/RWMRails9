class CommentController < ApplicationController
  before_filter :authenticate_user!, :except => [:get_article_comments]
  def add_new_comment
    puts '*********************************'
    puts params[:content]
    puts params[:comment_ids]
    
    
    comment = Comment.create()
    
    comment.content = params[:content]
    comment.comment_type = params[:comment_type]
    comment.comment_location_ids = params[:comment_location_ids]


    current_user.comments << comment
    Article.find(params[:article_id]).comments << comment
  
    comment.save

    #redirect_to article_url(params[:comment]['article_id'])

    puts ("articles/show/" + (params[:article_id]))

    #redirect_to ("/articles/show/" + (params[:comment]['article_id']))

    respond_to do |format|
        format.json { render :json => comment }
    end

  end

  def get_article_comments

    all_comments = Article.find(params[:article_id]).comments

    respond_to do |format|
        format.json { render :json => all_comments }
    end

  end 

end