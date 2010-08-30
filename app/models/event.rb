class Event
  include MongoMapper::Document

  key :name, String, :required=>true

  many :fixed_expenses, :class_name=>'Expense' do
    def total
      self.sum(&:amount)
    end
  end

end



