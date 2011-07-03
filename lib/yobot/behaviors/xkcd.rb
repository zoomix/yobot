require 'open-uri'

class Yobot::Behaviors::Xkcd
  BASE_URL = 'http://xkcd.com/'
  RANDOM_URL = 'http://dynamic.xkcd.com/random/comic/'
#  SEARCH_URL = 'http://www.google.com/cse?cx=012652707207066138651%3Azudjtuwe28q&ie=UTF-8&sa=Search&siteurl=xkcd.com%2F&q='
  SEARCH_URL = 'http://derp.co.uk/xkcd/page?search=Search&q='

  def describe()
    '- I can entertain you by showing you xkcds. Go mrdata, xkcd or xkcd random or xkcd 312'
  end
  
  def react(room, message)
    if message =~ /^xkcd$/ || message =~ /^xkcd latest/
      fetch_comic room
    elsif message =~ /^xkcd random/
      fetch_random room
    elsif message =~ /^xkcd find (.+)/
      find_comic room, $1
    elsif message =~ /^xkcd (\d+)/
      fetch_comic room, $1
    end
  end

  private
  
  def fetch_random(room)
    parse_comic(room, open(RANDOM_URL))
  end

  def fetch_comic(room, id=nil)
    parse_comic(room, open("#{BASE_URL}#{id.to_s + '/' if id}"))
  end

  def find_comic(room, search_word)
    comic_id = parse_search_page(room, get_search_html(search_word))
    fetch_comic(room, comic_id)
  end

  def get_search_html(search_word)
    open("#{SEARCH_URL}#{URI.encode(search_word)}")
  end
  
  def parse_search_page(room, search_result_html)
    doc = Nokogiri::HTML.parse(search_result_html)
    as = doc.xpath('//a')
    as.each do |x|
      return $1 if x[:href] =~ /xkcd\.com\/(\d+)/
    end
  end

  def parse_comic(room, response)
    doc = Nokogiri::HTML.parse(response)
    imageEl = doc.css('#middleContent img').first

    room.text(imageEl['src']) {}
    room.text(imageEl['title']) {}
  end
end

