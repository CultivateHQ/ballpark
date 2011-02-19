class Event
  include Mongoid::Document
  field :name

  validates_presence_of :name

  %w(delegate fixed).each do |type|
    embeds_many "#{type}_expenses" do
      def total
        self.sum(&:amount)
      end
    end
  end

  embeds_many :tickets

  def capacity
    tickets.sum(&:capacity)
  end

  def scenario_for(sales)
    Scenario.new(self, sales)
  end

  class Scenario
    attr_reader :tickets_sold, :total_income, :sales
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




