require 'spec_helper'

describe Yobot::Behaviors::FuckYeah do
	
  it "writes dude image if it gets a fuck yeah dude" do
    room = stub(:room)
    
    room.should_receive(:text).with('http://fuckyeahnouns.com/images/dude#.jpg')
    Yobot::Behaviors::FuckYeah.new.react(room, 'fuck yeah dude')
  end
  
  it "writes mo money image if it gets a fuck yeah mo money" do
    room = stub(:room)
    
    room.should_receive(:text).with('http://fuckyeahnouns.com/images/mo%20money#.jpg')
    Yobot::Behaviors::FuckYeah.new.react(room, 'fuck yeah mo money')
  end
  
  it "does nothing if message isn't fuck yeah" do
    room = stub(:room)
    
    room.should_not_receive(:text)
    
    Yobot::Behaviors::FuckYeah.new.react(room, 'feck yeah')
  end
    
end

