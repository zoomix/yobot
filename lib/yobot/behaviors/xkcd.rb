class Yobot::Behaviors::Xkcd
  BASE_URL = 'http://xkcd.com/'
  RANDOM_URL = 'http://dynamic.xkcd.com/random/comic/'
  
  def react(room, message)
    if message =~ /^xkcd$/ || message =~ /^xkcd latest/
      fetch_comic room
    elsif message =~ /^xkcd random/
      fetch_random room
    elsif message =~ /^xkcd (\d+)/
      fetch_comic room, $1
    end
  end
  
  private
  
  def fetch_random(room)
    # Fetch the latest page and then find the link to the previous comic.
    # This will give us a number to work with (that of the penultimate strip).
    http = EventMachine::HttpRequest.new(RANDOM_URL).get :redirects => 1
    http.callback do
      parse_comic(room, http.response)
    end
  end

  def fetch_comic(room, id=nil)
    http = EventMachine::HttpRequest.new("#{BASE_URL}#{id.to_s + '/' if id}").get
    http.callback do
      parse_comic(room, http.response)
    end
  end
  
  def parse_comic(room, response)
    doc = Nokogiri::HTML.parse(response)
    imageEl = doc.css('#middleContent img').first

    room.text(imageEl['src']) {}
    room.text(imageEl['title']) {}
  end
end

