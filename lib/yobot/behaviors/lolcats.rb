class Yobot::Behaviors::Lolcats
  BASE_URL = 'http://icanhascheezburger.com/?random#top'
  COMMAND = /^lolcats/

  def react(room, message)
    if message =~ COMMAND
      get_lolcats(room)
    end
  end
  
  def get_lolcats(room)
    # Scrape random lolcat
    http = EventMachine::HttpRequest.new(BASE_URL).get :redirects => 1
    http.callback do
      imgEl = Nokogiri::HTML.parse(http.response).css('div.entry img').first
      room.text(imgEl['src']) {} if imgEl
    end
  end
end

