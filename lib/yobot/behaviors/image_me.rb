require 'googleajax'

class Yobot::Behaviors::ImageMe
  BASE_URL = 'http://images.google.com/images'
  
  COMMAND = /^(?:image|fetch) me /

  def react(room, message)
    if message =~ COMMAND
      room.text(random_url(message.gsub(COMMAND, '')))
    end
  end
  
  private

  def fetch_image_urls(term)
    GoogleAjax.referrer = 'http://www.salescrunch.com'
    return GoogleAjax::Search.images(term, :start => rand(7))[:results].map { |e| e[:unescaped_url] }
  end
  
  def random_url(term)
    image_urls = fetch_image_urls(term)
    return image_urls[rand(image_urls.size)]
  end  
end

