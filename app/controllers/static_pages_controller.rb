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
      "answer"   => "Creating an account is easy! Click here and then log in with your Facebook account. This enables us to provide great features for you, like sharing articles with friends. Many more features that take advantage of Facebook integration are in development.",
    }

    @FAQ_array[1] = 
    {
      "question" => "Can I create an account without using my Facebook account? What if I don\\'t have Facebook?",      
      "answer"   => "At this time, logging in via Facebook is the only way to access Read With Me.  This enables us to provide you with the complete Read With Me experience.  If you do not have a Facebook account, please click here and create one. It only takes a minute, and then you can begin using Read With Me.  In the future we may also enable you to connect Read With Me with your email, LinkedIn, and Twitter contacts for an even more integrated experience.",
    }

    @FAQ_array[2] = 
    {
      "question" => "How do I share an article?",      
      "answer"   => "This is where the magic of Read With Me really starts.  Download the bookmark tool here. This helps make the sharing process incredibly easy. When you\\ re reading an article that you want to share, just click the bookmark tool in your browser, and from there you can add your comments and share directly to Facebook or save it for your own reference. Even more sharing methods will be available soon!",
    }

    @FAQ_array[3] = 
    {
      "question" => "With whom should I share articles?",      
      "answer"   => "Read With Me is designed to work however you want.  Share interesting articles with friends, complete research with your team at work, or even use the tools for personal use. It\\'s up to you!",
    }

    @FAQ_array[4] = 
    {
      "question" => "Whats in My Articles?",      
      "answer"   => "My Articles is where we put the articles you save for personal use.  These articles arent shared with others, but rather are stored (with your comments intact) for reference later on.",
    }

    @FAQ_array[5] = 
    {
      "question" => "Whats coming next?",      
      "answer"   => "Were working hard to bring you a lot of new features that will further enhance how you share, discuss, and discover news.  These include a personal Dash (think of a news feed of interesting articles for you), sharing within pre-selected groups of your friends or colleagues, and more social ways to interact with your friends.",
    }


  end

end
