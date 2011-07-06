require 'nokogiri'

class Yobot::Behaviors::VasttrafikFromDestiantion < Yobot::Behaviors::VasttrafikBase
  
  def describe
    '= I can help you get to work. Just go, mrdata, beam me up from bellevue'
  end
  
  
  # def find_station_id(station_name)
  #   doc = Nokogiri::XML(get_station_xml(station_name))
  #   doc.search('item')[0][:stop_id]
  # end
  # 
  
  def get_route_from(origin_id)
    routes = []
    
    doc = Nokogiri::XML(get_route_to_hagakyrkan(origin_id))
    get_listing(doc, "Haga", routes)
    
    doc = Nokogiri::XML(get_route_to_vasaplatsen(origin_id))
    get_listing(doc, "Vasa", routes)
    
    routes.sort
  end
  
  def react(room, message)
    if message.match(/^beam me up from (.+)|from (.+)/i)
      routes = get_route_from(find_station_id($1))
      room.paste(routes.reduce('') {|acc,val|  acc << val << "\n"}) {}
    end
  end
  
  
  # def get_station_xml(station_name)
  #   open("http://vasttrafik.se/External_Services/TravelPlanner.asmx/GetAllSuggestions?count=1&identifier=d5542e00-3230-46eb-a73e-5bd6821bf5ef&searchString=#{URI.encode(station_name)}") { |io| data = io.read }.gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')
  # end
  
  def get_route_to_hagakyrkan(origin_id)
    open(get_route_url(origin_id, '00003040')) { |io| data = io.read }.gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')
  end

  def get_route_to_vasaplatsen(origin_id)
    open(get_route_url(origin_id, '00007300')) { |io| data = io.read }.gsub!(/&lt;/, '<').gsub!(/&gt;/, '>')
  end

  # def get_route_url(start_id, origin_id)
  #   "http://vasttrafik.se/External_Services/TravelPlanner.asmx/GetRoute?identifier=d5542e00-3230-46eb-a73e-5bd6821bf5ef&fromId=#{start_id}&toId=#{origin_id}&dateTimeTravel=#{URI.encode(Time.now.to_s[0..-10])}&whenId=1&priorityId=1&numberOfResultBefore=1&numberOfResulsAfter=4"
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