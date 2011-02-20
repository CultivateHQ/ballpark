class Event
  include Mongoid::Document
  field :name
  field :fixed_cost_per_ticket, :type=>Float, :default=>0.0
  field :percent_cost_per_ticket, :type=>Float, :default=>0.0

  validates_presence_of :name

  %w(delegate fixed).each do |type|
    embeds_many "#{type}_expenses" do
      def total
        self.sum(&:amount)
      end
    end
  end

  embeds_many :tickets
  embeds_many :sponsors

  def capacity
    tickets.sum(&:capacity)
  end

  def scenario_for(sales)
    Scenario.new(self, sales)
  end

  class Scenario
    attr_reader :tickets_sold, :total_income, :sales, :ticket_cost
    def initialize(event, sales)
      @tickets_sold = {}
      @sales = sales
      @event = event
      @ticket_cost = 0

      @total_income = 0
      tickets_unaccounted = sales
      event.tickets.sort_by(&:price).each do |ticket|
        sold = [ticket.capacity, tickets_unaccounted].min
        ticket_sales = sold * ticket.price
        @ticket_cost += sold * event.fixed_cost_per_ticket
        @ticket_cost += ticket_sales * event.percent_cost_per_ticket / 100
        @total_income += ticket_sales 
        tickets_unaccounted -= sold
        @tickets_sold[ticket.name] = sold
      end
    end
 

    def total_cost
      @event.fixed_expenses.total + @sales * @event.delegate_expenses.total
    end

    def profit
      total_income - total_cost - ticket_cost
    end


  end
end




