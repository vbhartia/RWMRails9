class ArticleController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :get_article]


  def index
      @articles = current_user.articles.all
  end

  def delete

      article_to_delete = Article.find(params[:id])
      article_to_delete_headline = article_to_delete.headline
      
      if (article_to_delete.destroy)
        flash.alert = '\'' + article_to_delete_headline + '\'' + ' has been deleted'
        redirect_to :action => 'index'
      end
  end

  #Goes to iFrame view
  def iFrame
  end

  #Post response
  def add_new_article
    
    # Use Readability API
    readability_api_url = 'http://www.readability.com/api/content/v1/parser?url='

    readability_token = '&token=933fe96da256bd87c9497a08fad03cbd111eee1e'

    readability_get_url = readability_api_url + params[:url] + readability_token


    response = HTTParty.get(readability_get_url)

    parsed_json_article = ActiveSupport::JSON.decode(response.body)

    puts 'Readability output**************************************************'
    puts parsed_json_article
    puts params[:url] 


    #doc_split = parsed_json_article["content"].split(' ')
    doc_split = parsed_json_article["content"].split(/(\s|>)/)
   


      
    # **************************************************
    # insert span ids

    # doc_split.each do |res| 
    #   if res.include?('<img') || res.include?('<a')
    #     puts 'in img flag *****************************************'
    #     html_flag = true
    #     #puts 'flag set to true'
    #     #puts res
    #     doc_with_commenting = doc_with_commenting + res + ' '
    #   elsif res.include?('div>') || res.include?('/p>')
    #     puts 'in div tag *****************************************'
    #     doc_with_commenting = doc_with_commenting + res + ' '
    #   else 
    #     if html_flag
    #       #puts 'in html block'
    #       if res.include?('">')
    #         #puts 'detected end'
    #         #puts res
    #         html_flag = false
    #         doc_with_commenting = doc_with_commenting + res + ' '
    #       end
    #     else 
    #       puts 'spanning the word'
    
    #       span_count = span_count + 1
    #       span_tag = '<span id=\'' + span_count.to_s + '\' class="selectable" >' + res + ' </span>'
    #       doc_with_commenting = doc_with_commenting + span_tag
    #     end 
    #   end
    # end


    span_count = 0
    incomplete_html_flag = false
    doc_with_commenting = ''

    doc_split.each do |res|
      puts res
      if word_contains_html(res)
        if is_full_html_tag(res)
           
          doc_with_commenting = doc_with_commenting + res #+ ' '#span_tag

        elsif contains_end_html_tag(res)
          
          # Closes an HTML block
          
          incomplete_html_flag = false
          doc_with_commenting = doc_with_commenting + res #+ ' '
        else
          
          # Starts an HTML block
          
          incomplete_html_flag = true
          doc_with_commenting = doc_with_commenting + res #+ ' '
        end

      elsif (incomplete_html_flag)
        
        # Doesnt contain HTML, but is a part of an HTML block
        
        doc_with_commenting = doc_with_commenting + res #+ ' '

      elsif (incomplete_html_flag == false)
        
        # Doesnt containt html, and is not a a part of an HTML block
        
        span_count = span_count + 1
        span_tag = '<span id=\'' + span_count.to_s + '\' class="selectable" >' + res + '</span>'
        doc_with_commenting = doc_with_commenting + span_tag
    
      end
      
    end 


    # store article

    article_scrapped = Article.new()
    article_scrapped.user = current_user
    
    #article_scrapped.content = parsed_json_article["content"]

    article_scrapped.content = doc_with_commenting
    article_scrapped.headline = parsed_json_article["title"]
    article_scrapped.original_url = parsed_json_article["url"]
    article_scrapped.description = parsed_json_article["excerpt"]
    article_scrapped.site_name = params[:site_name]
    article_scrapped.author = parsed_json_article["author"]
    article_scrapped.image_url = parsed_json_article["lead_image_url"]


    if parsed_json_article["lead_image_url"]
      article_scrapped.image_url = parsed_json_article["lead_image_url"]
      
    else
      if params[:image_url]
        article_scrapped.image_url = params[:image_url]
      end
    end
    # #else
    #   #article_scrapped.image_url = readability_output.images[0]
    # #end

    article_scrapped.save
    
    # track_activity article_scrapped
    
    article_scrapped['creator'] = article_scrapped.user

    respond_to do |format|
      format.json { render json: article_scrapped }
    end


    # Use Readability GEM
    # source = open(params[:url]).read
    # readability_output = Readability::Document.new(source, :tags => %w[div p img a], :attributes => %w[src href], :remove_empty_nodes => false)

    # doc_split = readability_output.content.split(' ')
    


    # span_count = 0
    # html_flag = false
    # doc_with_commenting = ''

    # #insert span ids

    # doc_split.each do |res| 
    #   if res.include?('<img') || res.include?('<a')
    #     puts 'in img flag *****************************************'
    #     html_flag = true
    #     #puts 'flag set to true'
    #     #puts res
    #     doc_with_commenting = doc_with_commenting + res + ' '
    #   elsif res.include?('div>') || res.include?('p>')
    #     puts 'in div tag *****************************************'
    #     doc_with_commenting = doc_with_commenting + res + ' '
    #   else 
    #     if html_flag
    #       #puts 'in html block'
    #       if res.include?('">')
    #         #puts 'detected end'
    #         #puts res
    #         html_flag = false
    #         doc_with_commenting = doc_with_commenting + res + ' '
    #       end
    #     else 
    #       puts 'spanning the word'
    
    #       span_count = span_count + 1
    #       span_tag = '<span id=\'' + span_count.to_s + '\' class="selectable" >' + res + ' </span>'
    #       doc_with_commenting = doc_with_commenting + span_tag
    #     end 
    #   end
    # end


    # #store article
    #article_scrapped = Article.new()
    #article_scrapped.user = current_user
    # article_scrapped.content = doc_with_commenting
    # article_scrapped.headline = params[:headline]
    # article_scrapped.original_url = params[:url]
    # article_scrapped.description = params[:description]
    # article_scrapped.site_name = params[:site_name]
    # article_scrapped.author = params[:author]
    
    # #if readability_output.images[0].empty?
    #   article_scrapped.image_url = params[:image_url]
    # #else
    #   #article_scrapped.image_url = readability_output.images[0]
    # #end

    # article_scrapped.save
    # track_activity article_scrapped
    # respond_to do |format|
    #   format.json { render json: article_scrapped }
    #end
  end

  def show
    @article = Article.find(params[:id])
    
  end

  def get_article
    article = Article.find(params[:id])
    article[:creator] = article.user

    puts 'HERE********************************'
    puts article[:creator].firstname

    #respond_to do |format|
    #  format.json { render :json => article.as_json(
    #    :include => { :creator => article.user}) }
    #end

    respond_to do |format|
      format.json { render :json => article }
    end

  end


  private 
    def remove_html(html)
      html_tags = [ '<div>', '<img>', '<p>', '<span>', '<hr>' ]
      html.gsub(html_tags, '')
      return html
    end

    def only_html(html)
      return html
    end


    def word_contains_html(html)
      #html_open_tags = ['<div', '<img', '<span', '<a', '<p', '<hr', '<strong>', '<meta>', '<br>', '<em>']
      #html_close_tags = ['<div>', '<img>', '<span>', '<a>', '<p>', '<hr>', '<strong>', '<meta>', '<br>', '<em>']


      if html.include?('<') || html.include?('>')
        return true
      else
        return false
      end
    end

    def is_full_html_tag(html)
      
      left_count = html.count('<')
      right_count = html.count('>')

      if (left_count == right_count)
        return true
      else
        return false
      end
    end

    def contains_end_html_tag(html)
      
      left_count = html.count('<')
      right_count = html.count('>')

      if (right_count > left_count)
        return true
      else
        return false
      end
    end

    def remove_html_tags(html)
      html_tags = ['<div>', '<img>', '<span>', '<a>', '<p>', '<hr>', '<strong>', '<meta>', '<br>', '<em>']
      html_close_tags = ['</div>', '</span>', '</a>', '</p>', '</hr>', '</strong>', '</meta>', '<br/>', '</em>']

      html_tags.each { |tag| html = html.gsub(tag, '')}

      html_close_tags.each { |tag| html = html.gsub(tag, '')}

      return html

    end

    def only_html_tags(html)
      html_tags = ['<div>', '<img>', '<span>', '<a>', '<p>', '<hr>', '<strong>', '<meta>', '<br>', '<em>']

      output = ''

      html_tags.each { |tag| 
        if (html.include?(tag))
          output = output + tag
        end
      }

      return output

    end



end
