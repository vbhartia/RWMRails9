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
    puts params[:URL]

    source = open(params[:URL]).read
    readability_output = Readability::Document.new(source, :tags => %w[div p img a], :attributes => %w[src href], :remove_empty_nodes => false)
    puts '****************************************************************************'
    puts '****************************************************************************'

    puts readability_output.images

    article_scrapped = Article.new()
    article_scrapped.user = current_user
    article_scrapped.content = readability_output.content
    article_scrapped.headline = 'Place Holder'
    article_scrapped.original_url = params[:URL]
    article_scrapped.image_url = readability_output.images[0]

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
