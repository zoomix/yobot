require 'open-uri'

class Yobot::Behaviors::Xkcd
  BASE_URL = 'http://xkcd.com/'
  RANDOM_URL = 'http://dynamic.xkcd.com/random/comic/'

  def describe()
    '- I can entertain you by showing you xkcds. Go mrdata, xkcd or xkcd random or xkcd 312'
  end
  
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
    parse_comic(room, open(RANDOM_URL))
    # http = EventMachine::HttpRequest.new(RANDOM_URL).get :redirects => 1
    # http.callback do
    #   parse_comic(room, http.response)
    # end
  end

  def fetch_comic(room, id=nil)
    parse_comic(room, open("#{BASE_URL}#{id.to_s + '/' if id}"))
    # http = EventMachine::HttpRequest.new("#{BASE_URL}#{id.to_s + '/' if id}").get
    #     http.callback do
    #       parse_comic(room, http.response)
    #     end
  end

  def parse_comic(room, response)
    doc = Nokogiri::HTML.parse(response)
    imageEl = doc.css('#middleContent img').first

    room.text(imageEl['src']) {}
    room.text(imageEl['title']) {}
  end
end

