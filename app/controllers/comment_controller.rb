class CommentController < ApplicationController
  def add_new_comment
    comment = Comment.create()
    
    comment.content = params[:comment]['content']
    comment.comment_type = params[:comment]['type']

    current_user.comments << comment
    Article.find(params[:comment]['article_id']).comments << comment
  
    comment.save

    #redirect_to article_url(params[:comment]['article_id'])

    puts ("articles/show/" + (params[:comment]['article_id']))

    redirect_to ("/articles/show/" + (params[:comment]['article_id']))

  end

end