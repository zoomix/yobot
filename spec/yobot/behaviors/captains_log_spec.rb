require 'spec_helper'

describe Yobot::Behaviors::CaptainsLog do
  it "writes pong if it gets a ping" do
    room = stub(:room)
    
    room.should_receive(:text).with('dude wheres your car?')
    
    Yobot::Behaviors::CaptainsLog.new.react(room, 'captains log dude wheres your car?')
  end
  
  it "does nothing if message isn't ping" do
    room = stub(:room)
    
    room.should_not_receive(:text)
    
    Yobot::Behaviors::CaptainsLog.new.react(room, 'kaptenens stubbe')
  end
end
