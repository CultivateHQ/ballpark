class Event
  include MongoMapper::Document

  key :name, String, :required=>true

  many :fixed_expenses, :class_name=>'Event::Expense'

  def add_fixed_expense attributes
    fixed_expenses << Expense.new(attributes)
  end
  

  class Expense
    include MongoMapper::EmbeddedDocument

    key :amount, Float, :required=>true
    key :description, String, :required=>true
    belongs_to :event
  end
end



