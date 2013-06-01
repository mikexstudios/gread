require 'digest/md5'

class Notification

  # static methods
  def self.parse_superfeedr(n)
    #NOTE: We don't hash n['id'] because apparently, that changes contrary to
    #what it is expected to do.
    hid = Digest::MD5.hexdigest(n['status']['feed'])
    #Some feeds do not set an 'updated' timestamp if so, set that to now.
    updated = n['updated'].nil? ? DateTime.now : Time.at(n['updated']).to_datetime
    #Some feeds set a future timestamp. We normalized that to now.
    updated = DateTime.now if updated > DateTime.now 
    feed = Feed.where(:hid => hid).first_or_create(:title => n['title'],
                                                   :url => n['status']['feed'])
    #Set feed's updated_at to what the feed tells us.
    feed.update_attributes(:updated_at => updated)

    #For each entry in feed items, add Entry
    n['items'].each do |i|
      hid = Digest::MD5.hexdigest(i['id'])
      #We don't care if create fails, so we don't use the ! at the end.
      e = feed.entries.create(:hid => hid,
                              :url => i['permalinkUrl'],
                              :title => i['title'])
      #Check if content is filled, if not use summary
      content = i['content'].nil? ? i['summary'] : i['content']
      #Some entries do not set a 'published' timestamp so we set that to now.
      published = i['published'].nil? ? DateTime.now : Time.at(i['published']).to_datetime
      #Some entries set a future timestamp. We normalized that to now.
      published = DateTime.now if published > DateTime.now 
      e.update_attributes(:created_at => published,
                          :content => content)
      e.update_attributes(:author => i['actor']['displayName']) if i['actor']
    end
  end

end
