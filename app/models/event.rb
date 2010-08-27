class Event
  include MongoMapper::Document

  key :name, String, :required=>true

  many :fixed_expenses, :class_name=>'Expense' do

    def add attributes
      expense = Expense.new(attributes)
      return nil unless expense.valid?
      self << Expense.new(attributes)
    end
  end
end



