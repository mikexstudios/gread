require 'digest/md5'

class Notification

  # static methods
  def self.parse_superfeedr(n)
    #Get feed by 'hid' or create new feed entry
    #NOTE: We don't hash n['id'] because apparently, that changes contrary
    #to what it is expected to do.
    hid = Digest::MD5.hexdigest(n['status']['feed'])
    #Some feeds don't report an updated attribute.
    #TODO: Also make sure that feed can't have a future updated time.
    updated = n['updated'].nil? ? DateTime.now : Time.at(n['updated']).to_datetime
    feed = Feed.where(:hid => hid).first_or_create(:title => n['title'],
                                                   :url => n['status']['feed'])
    #Set feed's updated_at to what the feed tells us.
    feed.update_attributes(:updated_at => updated)

    #For each entry in feed items, add Entry
    puts n['items']
    n['items'].each do |i|
      hid = Digest::MD5.hexdigest(i['id'])
      published = i['published'].nil? ? DateTime.now : Time.at(i['published']).to_datetime
      #We don't care if create fails, so we don't use the ! at the end.
      e = feed.entries.create(:hid => hid,
                              :url => i['permalinkUrl'],
                              :title => i['title'])
      #Check if content is filled, if not use summary
      content = i['summary'] if i['summary']
      content = i['content'] if i['content']
      #Override created_at with the published time of the entry.
      e.update_attributes(:created_at => published,
                          :content => content)

      if i['actor']
        e.update_attributes(:author => i['actor']['displayName'])   
      end
    end
  end

end
