class Feed < ActiveRecord::Base
  #NOTE: The :hid field is an md5 hash of the url and is indexed so that feeds
  #can be quickly searched by knowing the url of the feed. The url of the feed 
  #can be arbitrary length, but the hash will be fixed 32-character length, making
  #searching and indexing more efficient.
  has_many :entries, :dependent => :destroy,
                     :order => 'updated_at DESC',
                     :inverse_of => :feed
  before_save :hash_url

  #NOTE: rails_admin can only edit fields that have been made attr_accessible
  attr_accessible :title, :url

  validates :title, :presence => true,
                    :length => { :maximum => 255 }
  validates :url, :presence => true

  private

  def hash_url
    #TODO: Actually hash this
    self.hid = self.url
  end
end
