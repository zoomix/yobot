require 'spec_helper'

describe Yobot::Behaviors::Cowsay do
  it "writes the dude message form cowsay" do
    room = stub(:room)
    
    room.should_receive(:paste).with(dude_mess)
    
    Yobot::Behaviors::Cowsay.new.react(room, 'cowsay dude!')
  end
  
  it "does nothing if message isn't cowsay" do
    room = stub(:room)
    
    room.should_not_receive(:text)
    room.should_not_receive(:paste)
    
    Yobot::Behaviors::Cowsay.new.react(room, 'kewsay seppo')
  end

  def dude_mess
    <<EOF
 _______ 
< dude! >
 ------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
EOF
  end
end
