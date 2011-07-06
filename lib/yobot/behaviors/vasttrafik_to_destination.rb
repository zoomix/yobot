require 'nokogiri'

class Yobot::Behaviors::VasttrafikToDestiantion < Yobot::Behaviors::VasttrafikBase
  
  def describe
    '= I can help you get home. Just go, mrdata, set course for bellevue'
  end
  
  
  # def find_station_id(station_name)
  #   doc = Nokogiri::XML(get_station_xml(station_name))
  #   doc.search('item')[0][:stop_id]
  # end
  # 
  
  def get_route_to(destination_id)
    routes = []
    
    doc = Nokogiri::XML(get_route_from_hagakyrkan(destination_id))
    get_listing(doc, "Haga", routes)
    
    doc = Nokogiri::XML(get_route_from_vasaplatsen(destination_id))
    get_listing(doc, "Vasa", routes)
    
    routes.sort
  end
  
  def react(room, message)
    if message.match(/^set course for (.+)/i)
      routes = get_route_to(find_station_id($1))
      #room.text('im working') {}
      room.paste(routes.reduce('') {|acc,val|  acc << val << "\n"}) {}
    end
  end
  
    # 
    # def get_station_xml(station_name)
    #   open("http://vasttrafik.se/External_Services/TravelPlanner.asmx/GetAllSuggestions?count=1&identifier=d5542e00-3230-46eb-a73e-5bd6821bf5ef&searchString=#{URI.encode(station_name)}") { |io| data = io.read }.gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')
    # end
  
  def get_route_from_hagakyrkan(destination_id)
    open(get_route_url('00003040', destination_id)) { |io| data = io.read }.gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')
  end

  def get_route_from_vasaplatsen(destination_id)
    open(get_route_url('00007300', destination_id)) { |io| data = io.read }.gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')
  end
  # 
  # def get_route_url(start_id, destination_id)
  #   "http://vasttrafik.se/External_Services/TravelPlanner.asmx/GetRoute?identifier=d5542e00-3230-46eb-a73e-5bd6821bf5ef&fromId=#{start_id}&toId=#{destination_id}&dateTimeTravel=#{URI.encode(Time.now.to_s[0..-10])}&whenId=1&priorityId=1&numberOfResultBefore=1&numberOfResulsAfter=4"
  # end

    # 
    # private
    # def get_listing(doc, stop, routes)
    #   doc.search('items').each do |items|
    #     items.children.each do |item|
    #       time = (DateTime.parse("#{item[:departure_time]} #{Time.now.zone}").to_time - Time.now)/60
    #       routes << "#{"%03d" % time.floor}min - #{item.children[0].text} - #{stop}"
    #     end
    #   end
    #   
    # end
  
end