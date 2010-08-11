class Event
  include MongoMapper::Document

  key :name, String, :required=>true

  many :fixed_expenses, :class_name=>'Event::Expense'

  def add_fixed_expense description, amount
    fixed_expenses << Expense.new(:description=>description, :amount=>amount)
  end
  

  class Expense
    include MongoMapper::EmbeddedDocument

    key :amount, BigDecimal, :required=>true
    key :description, String, :required=>true
    belongs_to :event
  end
end



