require 'spec_helper'

describe Yobot::Bot, 'on_message' do

  datas = ["MrData", "mrdata", "mr data", "Mr data", "Mr Data", "Mr. Data", "Mr.data", "Mr data, ", "data", "Computer", "computer, "]

  datas.each do |prefix|
    it "passes the message to all behaviors if it starts with #{prefix}" do
      behavior = stub(:behavior)
      room = stub(:room)
    
      behavior.should_receive(:react).with(room, 'ping')
      Yobot::Bot.new([behavior]).received_message(room, "#{prefix} ping")

    end
  end
  
  it "does nothing if the message doesn't start with some variation of mr data" do
    behavior = stub(:behavior)
    
    behavior.should_not_receive(:react)
    
    Yobot::Bot.new([behavior]).received_message(stub, 'hello')
  end
  
  ["mrdata, help", "mrdata what do you know?"].each do |message|
    it "gets help if it needs to" do
      behavior = Yobot::Behaviors::PingPong.new
      room = stub(:room)
    
      room.should_receive(:text).with("- I can pong you if you ping me")
      Yobot::Bot.new([behavior]).received_message(room, message)
    end
  end
  
end
