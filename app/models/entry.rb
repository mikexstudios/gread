class Entry < ActiveRecord::Base
  #NOTE: The :hid field is an md5 hash of the 'id' returned by superfeedr. We'll
  #have to find a way to mirror this during initial population with other rss
  #polling methods.
  belongs_to :feed, #:touch => true, #update :notebook's updated_at
                    :inverse_of => :entry

  attr_accessible :author, :content, :feed_id, :hid, :permalink, :title
  validates :feed_id, :presence => true
  validates :permalink, :presence => true
  validates :title, :length => { :maximum => 255 }
  validates :author, :length => { :maximum => 255 }
end
