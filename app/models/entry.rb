class Entry < ActiveRecord::Base
  attr_accessible :author, :content, :feed_id, :hash, :permalink, :title
end
