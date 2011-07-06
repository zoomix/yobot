require 'nokogiri'

class Yobot::Behaviors::VasttrafikBase
  
  def find_station_id(station_name)
    doc = Nokogiri::XML(get_station_xml(station_name))
    doc.search('item')[0][:stop_id]
  end
  
  
  def get_station_xml(station_name)
    open("http://vasttrafik.se/External_Services/TravelPlanner.asmx/GetAllSuggestions?count=1&identifier=d5542e00-3230-46eb-a73e-5bd6821bf5ef&searchString=#{URI.encode(station_name)}") { |io| data = io.read }.gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')
  end

  def get_route_url(start_id, destination_id)
    "http://vasttrafik.se/External_Services/TravelPlanner.asmx/GetRoute?identifier=d5542e00-3230-46eb-a73e-5bd6821bf5ef&fromId=#{start_id}&toId=#{destination_id}&dateTimeTravel=#{URI.encode(Time.now.to_s[0..-10])}&whenId=1&priorityId=1&numberOfResultBefore=1&numberOfResulsAfter=4"
  end

  def get_listing(doc, stop, routes)
    doc.search('items').each do |items|
      items.children.each do |item|
        time = (DateTime.parse("#{item[:departure_time]} #{Time.now.zone}").to_time - Time.now)/60
        routes << "#{"%03d" % time.floor}min - #{item.children[0].text} - #{stop}"
      end
    end
  end
  
end