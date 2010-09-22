class Ticket
  include MongoMapper::EmbeddedDocument

  key :price, Float, :required=>true
  key :name, String, :required=>true
  key :capacity, Integer, :required=>true

  belongs_to :event
end
