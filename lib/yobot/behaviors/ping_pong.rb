class Yobot::Behaviors::PingPong
  def describe
    '- I can pong you if you ping me'.to_s
  end
  
  def react(room, message)
    room.text('pong') {} if message == 'ping'
  end
end