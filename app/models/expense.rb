class Expense
  include MongoMapper::EmbeddedDocument

  key :amount, Float, :required=>true
  key :description, String, :required=>true
  belongs_to :event
end
