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

  many :tickets

  def scenario_for(sales)
    Scenario.new(self, sales)
  end

  class Scenario
    attr_reader :tickets_sold, :total_income
    def initialize(event, sales)
      @tickets_sold = {}
      @sales = sales
      @event = event

      @total_income = 0
      tickets_unaccounted = sales
      event.tickets.sort_by(&:price).each do |ticket|
        sold = [ticket.capacity, tickets_unaccounted].min
        @total_income += sold * ticket.price
        tickets_unaccounted -= sold
        @tickets_sold[ticket.name] = sold
      end

    end

    def total_cost
      @event.fixed_expenses.total + @sales * @event.delegate_expenses.total
    end

    def profit
      total_income - total_cost
    end


  end
end




