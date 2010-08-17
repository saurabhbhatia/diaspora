class StatusMessage < Post
  #include StatusMessagesHelper
  
  xml_name :status_message
  xml_accessor :message

  key :message, String
  validates_presence_of :message
  
  
  def to_activity
        <<-XML
  <entry>
  <activity:verb>http://activitystrea.ms/schema/1.0/post</activity:verb>
  <title>#{self.message}</title>
  <link rel="alternate" type="text/html" href="#{person.url}status_messages/#{self.id}"/>
  <id>#{person.url}status_messages/#{self.id}</id>
  <published>#{self.created_at.xmlschema}</published>
  <updated>#{self.updated_at.xmlschema}</updated>
  </entry>
        XML
  end
  
end

