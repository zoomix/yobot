class Yobot::Behaviors::Cowsay
  def describe
    '- I can let the cow say what you mean. Go mrdata, cowsay dude!'.to_s
  end
  
  def react(room, message)
    return room.paste(%x(cowsay #{$1})) {} if message.match(/^cowsay (.+)/i)
    # room.text('pong') {} if message == 'ping'
  end
end