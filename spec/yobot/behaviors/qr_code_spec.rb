require 'spec_helper'

describe Yobot::Behaviors::QRCode do
    
  it "writes a qr-code image if it gets a qrcode with a long message" do
    room = stub(:room)
    
    room.should_receive(:text).with('http://qrcode.kaywa.com/img.php?s=8&d=We%20are%20the%20burt.%20You%20will%20be%20assimilated.#.jpg')
    Yobot::Behaviors::QRCode.new.react(room, 'qrcode We are the burt. You will be assimilated.')
  end
  
  it "writes a qr-code image of the burt manifesto if it gets a qrcode without a message" do
    room = stub(:room)

    room.should_receive(:text).with('http://qrcode.kaywa.com/img.php?s=8&d=We%20are%20the%20Burt.%20You%20will%20be%20assimilated.%20Resistance%20is%20futile.#.jpg')
    Yobot::Behaviors::QRCode.new.react(room, 'qrcode')
  end
  
  it "does nothing if message isn't qrcode" do
    room = stub(:room)
    
    room.should_not_receive(:text)
    
    Yobot::Behaviors::QRCode.new.react(room, 'ze code mr bond')
  end
end