class Yobot::Bot
  def initialize(behaviors)
    @behaviors = behaviors
  end
  
  def received_message(room, message)
    if message =~ /^stevie/
      @behaviors.each do |behavior|
        behavior.react room, message.sub(/^stevie /, '')
      end
    end
  end
end
