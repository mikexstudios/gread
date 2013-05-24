# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  feed_id    :integer
#  hid        :string(255)
#  permalink  :text
#  title      :string(255)
#  author     :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Entry < ActiveRecord::Base
  self.record_timestamps = false #disable auto-timestamping
  before_save :set_updated_at
  before_save :hash_permalink

  #NOTE: The :hid field is an md5 hash of the 'id' returned by superfeedr. We'll
  #have to find a way to mirror this during initial population with other rss
  #polling methods.
  belongs_to :feed, #:touch => true, #update :notebook's updated_at
                    :inverse_of => :entries

  #TODO: Get rid of feed_id
  attr_accessible :author, :content, :feed_id, :hid, :permalink, :title,
                  :created_at
  validates :feed_id, :presence => true
  validates :permalink, :presence => true
  validates :title, :length => { :maximum => 255 }
  validates :author, :length => { :maximum => 255 }

  private

  #We re-implement updated_at but leave created_at unimplemented so that we 
  #can set it ourselves.
  def set_updated_at
    self.updated_at = Time.now
  end

  def hash_permalink
    self.hid = Digest::MD5.hexdigest(self.permalink)
  end
end
