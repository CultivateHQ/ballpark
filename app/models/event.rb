class Event
  include Mongoid::Document
  referenced_in :user
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
  embeds_many :sponsors do
    def total_price
      self.sum(&:price)
    end
    def total_tickets
      self.sum(&:number_of_tickets)
    end
  end

  def capacity
    tickets.sum(&:capacity)
  end

  def scenario_for(sales)
    Scenario.new(self, sales)
  end

  class Scenario
    attr_reader :tickets_sold, :sales, :ticket_cost, :sales_income
    def initialize(event, sales)
      @tickets_sold = {}
      @sales = sales
      @event = event
      @ticket_cost = 0
      @sales_income = 0
      count_tickets
    end
 

    def total_cost
      @event.fixed_expenses.total + delegate_cost + ticket_cost
    end

    def profit
      total_income - total_cost
    end

    def fixed_costs
      @event.fixed_expenses.total
    end

    def delegate_cost
      (@sales + @event.sponsors.total_tickets )* @event.delegate_expenses.total
    end

    def total_income
      sales_income + sponsorship_income
    end

    def sponsorship_income
      @event.sponsors.total_price
    end


    private
    def count_tickets
      tickets_unaccounted = @sales
      @event.tickets.sort_by(&:price).each do |ticket|
        sold = [ticket.capacity, tickets_unaccounted].min
        ticket_sales = sold * ticket.price
        @ticket_cost += sold * @event.fixed_cost_per_ticket
        @ticket_cost += ticket_sales * @event.percent_cost_per_ticket / 100
        @sales_income += ticket_sales 
        tickets_unaccounted -= sold
        @tickets_sold[ticket.name] = sold
      end
    end



  end
end




