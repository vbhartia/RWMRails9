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

  def error_pages
  end  

  def faq
    @FAQ_array = Array.new

    @FAQ_item = Hash.new

    @FAQ_array[0] = 
    {
      "question" => "How do I create an account?",      
      "answer"   => "Creating an account is easy!" + "<a href='" + ENV['domain'] +"'> Click here </a> and then log in with your Facebook account. This enables us to provide great features for you, like sharing articles with friends. Many more features that take advantage of Facebook integration are in development.",
    }

    @FAQ_array[1] = 
    {
      "question" => "Can I create an account without using my Facebook account? What if I don\'t have Facebook?",      
      "answer"   => "At this time, logging in via Facebook is the only way to access Read With Me.  This enables us to provide you with the complete Read With Me experience. In the future we may also enable you to connect Read With Me with your email, LinkedIn, and Twitter contacts for an even more integrated experience.",
    }

    @FAQ_array[2] = 
    {
      "question" => "How do I share an article?",      
      "answer"   => "This is where the magic of Read With Me really starts. Setup the bookmark tool <a href='" + bookmarklet_path + "' > Here </a>. This helps make the sharing process incredibly easy. When you\'re reading an article that you want to share, just click the bookmark tool in your browser, and from there you can add your comments and share directly to Facebook or save it for your own reference. Even more sharing methods will be available soon!",
    }

    @FAQ_array[3] = 
    {
      "question" => "With whom should I share articles?",      
      "answer"   => "Read With Me is designed to work however you want it to.  Share interesting articles with friends, complete research with your team at work, or even use the tools for personal use. It\'s up to you! For a full demo of how to use Read With Me, please see the video below.",
    }

    @FAQ_array[4] = 
    {
      "question" => "Whats in My Articles?",      
      "answer"   => "My Articles is where we put the articles you save for personal use.  These articles arent shared with others, but rather are stored (with your comments intact) for reference later on.",
    }

    @FAQ_array[5] = 
    {
      "question" => "What\'s coming next?",      
      "answer"   => "We're working hard to bring you many new features that will further enhance how you share, discuss, and discover news. In the near term, we are working on integrating notifications into the system, to help you track conversations more easily.",
    }

    qSix_url = "<a href='mailto:?to=info@getreadwithme.com&amp;subject=Suggestions for Read With Me'>here</a>"

    @FAQ_array[6] = 
    {
      "question" => "Can I offer my feedback, or suggest a new feature",      
      "answer"   => "Of course! We are still in alpha, and would love to hear your thoughts. Send us an email by clicking " + qSix_url +". Thank you!",
    }


  end

end
