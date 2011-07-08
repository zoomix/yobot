require 'logger'

class Yobot::Bot
  def initialize(behaviors)
    @behaviors = behaviors
    @logger = Logger.new(STDERR)
  end
  
  def received_message(room, message)

    matchword = message.match(/^mr.*?data.?(.+)|^data.?(.+)|^computer.?(.+)/i).to_s #Someone is referencing us. Oh joy!

    if matchword.length > 0
      message = ($1 || $2 || $3).strip

      if message.match(/^what do you know/i) or message.match(/^help/i)

        @behaviors.each do |behavior|
          begin
            room.text(behavior.describe) {} if behavior.describe.length > 0
          rescue Exception => e
            @logger.error("failed sending #{behavior.describe} - exception: #{e}")
          end
        end

      else
        @behaviors.each do |behavior|
          behavior.react room, message
        end
      end

    end
  end
  # def received_message(room, message)
  #   if message =~ /^stevie/
  #     @behaviors.each do |behavior|
  #       behavior.react room, message.sub(/^stevie /, '')
  #     end
  #   end
  # end
end
