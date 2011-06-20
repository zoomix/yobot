class Yobot::Behaviors::LolCats
  BASE_URL = 'http://icanhascheezburger.com/?random#top'
  COMMAND = /^lolcats/

  def react(room, message)
    if message =~ COMMAND
      room.text(get_lolcats) {}
    end
    @log = Logging.logger["CampfireBot::Plugin::Lolcat"]
  end
  
  def get_lolcats
    # Scrape random lolcat
    http = EventMachine::HttpRequest.new(BASE_URL)
    http.callback do
      Nokogiri::HTML.parse(http.response).css('div.entry img').first['src']
    end
  end
end

