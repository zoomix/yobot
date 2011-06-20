class Yobot::Behaviors::Meme
  
  def react(room, message)
    if message =~ /^meme/
      room.text(meme(message.gsub('meme ', '')
    end
  end

  def meme(msg)    
    args = msg[:message].split(/(?:"(.+?)")+/)
    args.reject! {|x| x.strip! ; x.empty? }

    begin
      msg.speak Meme.run args
    rescue Timeout::Error
      # TODO: maybe retry w/ configurable limits?
      msg.speak "** memegenerator.net has timed out. please try again later **"
    end
  end
end

