class ArticleController < ApplicationController
  before_filter :authenticate_user!, :except => [:public_show]

  def index
      @articles = current_user.articles.all
  end

  #Goes to iFrame view
  def iFrame
  end

  #Post response
  def add_new_article
    puts '*******************************************************'
    puts params[:url]

    source = open(params[:url]).read
    readability_output = Readability::Document.new(source, :tags => %w[div p img a], :attributes => %w[src href], :remove_empty_nodes => false)
  

    puts readability_output.images

    article_scrapped = Article.new()
    article_scrapped.user = current_user
    article_scrapped.content = readability_output.content
    article_scrapped.headline = params[:headline]
    article_scrapped.original_url = params[:url]
    article_scrapped.description = params[:description]
    article_scrapped.site_name = params[:site_name]
    article_scrapped.author = params[:author]
    
    if readability_output.images[0].empty?
      article_scrapped.image_url = params[:image_url]
    else
      article_scrapped.image_url = readability_output.images[0]
    end

    article_scrapped.public = true

    article_scrapped.save


    respond_to do |format|
      format.json { render json: article_scrapped }
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def public_show
    @article = Article.find(params[:id])
  end

end
