require 'gdocs4ruby'

class Yobot::Behaviors::CaptainsLog
  
  def describe
    '- I can log stuff for you. Just go, mrdata, captains log <message> or computer, captains log <message>'
  end
  
  def react(room, message)
    if message.match(/^captains log (.+)|^captains's log (.+)/i)
      
      
      service = GDocs4Ruby::Service.new
      service.authenticate('burtlog@gmail.com', 'mymiggy3')  

      # doc = GDocs4Ruby::Document.new(@service)
      # doc.title = 'Test Document'
      # doc.content = '<h1>Test Content HTML</h1>'
      # doc.content_type = 'html'
      # doc.save

     # 
     documents = service.files
     documents.each {|x| p "methods: #{x.title}"}
     selected_doc = documents.select {|x| x.title == 'captainslog'}[0]
     p "selected_doc_id: #{selected_doc.id}"
     p "selected_doc: #{selected_doc.get_content('txt')}"
     #  p "content: '#{content}'"
     # 
#       doc = GDocs4Ruby::Document.new(service)
#       doc.title = 'Test Document_dude'
#       doc.content = '<b>Captains log, startdate 20110711.000200</b> this is the message'
# #      doc.content_type = 'text/html'
#       doc.save
#       
      
    end
  end
  
end

