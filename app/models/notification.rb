require 'digest/md5'

class Notification

  # static methods
  def self.parse_superfeedr(n)
    #Get feed by 'hid' or create new feed entry
    hid = Digest::MD5.hexdigest(n['id'])
    feed = Feed.where(:hid => hid).first_or_create(:title => n['title'],
                                                   :url => n['status']['feed'])
    #TODO: Set feed updated time.

    #For each entry in feed items, add Entry
    n['items'].each do |i|
      hid = Digest::MD5.hexdigest(i['id'])
      #We don't care if create fails, so we don't use the ! at the end.
      e = feed.entries.create(:hid => hid,
                              :permalink => i['permalinkUrl'],
                              :title => i['title'],
                              :content => i['content'])
      #TODO: Set author and published times.
    end
  end

end
