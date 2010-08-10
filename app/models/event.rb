

class Event
  include MongoMapper::Document

  key :name, String, :required=>true

  many :fixed_expenses

end


class Expense
  include MongoMapper::EmbeddedDocument

  key :amount, BigDecimal, :required=>true
  key :description, String, :required=>true
  belongs_to :event
end

class FixedExpense < Expense
  
end
