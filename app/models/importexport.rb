#See: http://railscasts.com/episodes/219-active-model
class Importexport
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  #Create getter and setters
  attr_accessor :opml

  validates :opml, :presence => true
  #TODO: Can't validate size of upload, so should use a more robust gem.
  
  def initialize(attributes = {})
    attributes = {'opml' => nil} if attributes.nil?
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end
