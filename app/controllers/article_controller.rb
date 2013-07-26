class ArticleController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :get_article]

  def index
      @articles = current_user.articles.all
  end

  #Goes to iFrame view
  def iFrame
    puts '*******************************************************'

    response = HTTParty.get('http://www.readability.com/api/content/v1/parser?url=http://www.businessweek.com/articles/2013-07-25/jeff-bezos-doesnt-care-what-you-think-about-amazons-quarterly-earnings&token=933fe96da256bd87c9497a08fad03cbd111eee1e')

    puts response.body

    parsed_json = ActiveSupport::JSON.decode(response.body)
    puts parsed_json['title']
  end

  #Post response
  def add_new_article
    
    source = open(params[:url]).read
    readability_output = Readability::Document.new(source, :tags => %w[div p img a], :attributes => %w[src href], :remove_empty_nodes => false)
    

    #readability_url = 'http://www.readability.com/api/content/v1/parser?url=' + (params[:url]) + '&token=933fe96da256bd87c9497a08fad03cbd111eee1e'

    #response = HTTParty.get(readability_url)

    #puts response.body

    #parsed_json = ActiveSupport::JSON.decode(response.body)
    
    #readability_output = parsed_json['content']

    #puts readability_output


    doc_split = readability_output.content.split(' ')
    #doc_split = readability_output.split(' ')


    span_count = 0
    html_flag = false
    doc_with_commenting = ''

    #insert span ids

    doc_split.each do |res| 
      if res.include?('<img') || res.include?('<a')
        html_flag = true
        #puts 'flag set to true'
        #puts res
        doc_with_commenting = doc_with_commenting + res + ' '
      else 
        if html_flag
          #puts 'in html block'
          if res.include?('">')
            #puts 'detected end'
            #puts res
            html_flag = false
            doc_with_commenting = doc_with_commenting + res + ' '
          end
        else 
          span_count = span_count + 1
          span_tag = '<span id=\'' + span_count.to_s + '\'>' + res + ' </span>'
          doc_with_commenting = doc_with_commenting + span_tag
        end 
      end
    end


    #store article
    article_scrapped = Article.new()
    article_scrapped.user = current_user
    article_scrapped.content = doc_with_commenting
    article_scrapped.headline = params[:headline]
    article_scrapped.original_url = params[:url]
    article_scrapped.description = params[:description]
    article_scrapped.site_name = params[:site_name]
    article_scrapped.author = params[:author]
    
    #if readability_output.images[0].empty?
      article_scrapped.image_url = params[:image_url]
    #else
      #article_scrapped.image_url = readability_output.images[0]
    #end

    article_scrapped.save
    track_activity article_scrapped
    respond_to do |format|
      format.json { render json: article_scrapped }
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def get_article
    article = Article.find(params[:id])

    respond_to do |format|
      format.json { render :json => article }
    end

  end

end
