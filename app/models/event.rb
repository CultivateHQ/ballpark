class Event
  include MongoMapper::Document

  key :name, String, :required=>true

  %w(fixed delegate).each do |type|
    many "#{type}_expenses", :class_name=>'Expense' do
      def total
        self.sum(&:amount)
      end
    end
  end

end



