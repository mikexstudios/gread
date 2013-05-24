require 'digest/md5'

class Notification

  # static methods
  def self.parse_superfeedr(n)
    #Get feed by 'hid' or create new feed entry
    hid = Digest::MD5.hexdigest(n['id'])
    updated = Time.at(n['updated']).to_datetime
    feed = Feed.where(:hid => hid).first_or_create(:title => n['title'],
                                                   :url => n['status']['feed'])
    #Set feed's updated_at to what the feed tells us.
    feed.update_attributes(:updated_at => updated)

    #For each entry in feed items, add Entry
    n['items'].each do |i|
      hid = Digest::MD5.hexdigest(i['id'])
      published = Time.at(i['published']).to_datetime
      #We don't care if create fails, so we don't use the ! at the end.
      e = feed.entries.create(:hid => hid,
                              :permalink => i['permalinkUrl'],
                              :title => i['title'],
                              :content => i['content'])
      #Override created_at with the published time of the entry.
      e.update_attributes(:created_at => published)

      if i['actor']
        e.update_attributes(:author => i['actor']['displayName'])   
      end
    end
  end

end
