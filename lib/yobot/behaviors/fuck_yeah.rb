class Yobot::Behaviors::FuckYeah
  BASE_URL = 'http://fuckyeahnouns.com/images/'
  
  def describe
    '- I can share your enthusiasm if you scream fuck yeah <keywords>'
  end
  
  def react(room, message)
    fetch_fuck_yeah(room, $1) if message.match(/fuck.?yeah (.+)/i)
  end
  
  def fetch_fuck_yeah(room, words) 
    room.text("#{BASE_URL}#{URI.encode(words)}\#.jpg") {}
  end
  
end