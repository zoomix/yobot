
class Yobot::Behaviors::QRCode
  BASE_URL = 'http://qrcode.kaywa.com/img.php?s=8&d='
  
  def describe
    '- I can create a QR-Code for you if you go mrdata, qrcode or mrdata, qrcode <message>'
  end
  
  def react(room, message)
    return fetch_qr_code(room, $1) if message.match(/^qrcode (.+)/i)
    return fetch_qr_code(room,  'We are the Burt. You will be assimilated. Resistance is futile.')  if message.match(/^qrcode/i)
  end
  
  def fetch_qr_code(room, words) 
    room.text("#{BASE_URL}#{URI.encode(words)}\#.jpg") {}
  end

  
end

#http://qrcode.kaywa.com/

#<img src="http://qrcode.kaywa.com/img.php?s=8&d=Ah%20come%20one%21%20There%20is%20no%20need%20to%20be%20this%20nerdy%21" alt="qrcode"  />
