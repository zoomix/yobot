require 'nokogiri'
require 'open-uri'

class Yobot::Behaviors::Vasttrafik
  
  Urls = {:vasaplatsen => 'http://vasttrafik.se/External_Services/NextTrip.asmx/GetForecast?identifier=d5542e00-3230-46eb-a73e-5bd6821bf5ef&stopId=00007300', 
          :hagakyrkan  => 'http://vasttrafik.se/External_Services/NextTrip.asmx/GetForecast?identifier=d5542e00-3230-46eb-a73e-5bd6821bf5ef&stopId=00003040'}
  
  def describe
    '- I can tell you the tram departures. Just go: MrData, list departures'
  end

  def get_departures_xml(key)
    open(Urls[key]) { |io| data = io.read }.gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')    
  end
  
  def departures(travel_xml, stop)
    doc = Nokogiri::XML(travel_xml)
    doc.search('item').reduce([]) do |all_items, item|
      all_items << (stop + " " + line_number(item) + towards(item) + " " + dept_times(item))
    end
  end
  
  def react(room, message)
    if message.match(/^list.?departures|^departures/i)
      departures(get_departures_xml(:vasaplatsen), 'vasapl.').sort!.each { |departure| room.text(departure) {} }
      sleep 2
      departures(get_departures_xml(:hagakyrkan), 'hagak.').sort!.each { |departure| room.text(departure) {} }
      # room.text('pong') {} if message == 'ping'
    end
  end
  
  

  private
  
  def line_number(item)
    line_id = item.attributes['line_id']
    return line_id.to_s + " - " if line_id
    ''
  end
  
  def towards(item)
    item.children[0].children[0].text
  end
  
  def dept_times(item)
    
    item['next_trip'] + "min" + (("/" + item['next_next_trip'] + "min") if item['next_next_trip'].length > 0)
    rescue Exception => e
      '(no departure times)'
  end
  
end