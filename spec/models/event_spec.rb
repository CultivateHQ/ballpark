require 'spec_helper'

describe Event do

  let(:event){Event.new}


  describe "capacity" do
    it "should be the total ticket capacity" do
      event.tickets << Ticket.new(:capacity=>10)
      event.tickets << Ticket.new(:capacity=>4)

      event.capacity.should == 14
    end
  end


  describe "fixed_expenses" do
    describe "total" do
      it "should be total of amounts" do
        event.fixed_expenses.total.should == 0
        event.fixed_expenses << Expense.new(:amount=>2)
        event.fixed_expenses.total.should == 2
        event.fixed_expenses << Expense.new(:amount=>3)
        event.fixed_expenses.total.should == 5
      end
    end
  end


  describe "sponsors" do
    describe "total_price" do
      it "should be the sum of all the sponsorship cash" do
        event.sponsors.total_price.should == 0
        event.sponsors.create(:name=>'A', :number_of_tickets=>0,:price=>1000)
        event.sponsors.total_price.should == 1000
      end
    end

    describe "total tickets" do
      it "should be the sum of all the sponsorship tickets" do
        event.sponsors.create(:name=>'A', :number_of_tickets=>1,:price=>1000)
        event.sponsors.create(:name=>'B', :number_of_tickets=>3,:price=>1000)
        event.sponsors.total_tickets.should == 4
      end

    end
  end

  describe "scenarios" do
    before(:each) do
      event.tickets << Ticket.new(:name=>"Free", :price=>0, :capacity=>5)
      event.tickets << Ticket.new(:name=>"Mid", :price=>100, :capacity=>15)
      event.tickets << Ticket.new(:name=>"High", :price=>200, :capacity=>15)

      event.fixed_expenses << Expense.new(:amount=>150)
      event.delegate_expenses << Expense.new(:amount=>10)
    end

    describe "total cost" do

      it"should be the same as fixed expenses if no tickets sold" do
        event.scenario_for(0).total_cost.should == 150
      end

      it "should increase fixed expense + sales * delegate costs" do
        event.scenario_for(1).total_cost.should == 160
        event.scenario_for(5).total_cost.should == 200
        event.scenario_for(10).total_cost.should == 250
      end

    end


    describe "profit" do
      it "should be total income - cost - ticket cost" do
        event.scenario_for(0).profit.should == -150
        event.scenario_for(10).profit.should == 250
        event.fixed_cost_per_ticket = 1
        event.scenario_for(10).profit.should == 240
      end
    end

    describe "total income" do
      it "should be sum of each ticket price * amount sold" do
        event.scenario_for(0).total_income.should == 0
        event.scenario_for(5).total_income.should == 0
        event.scenario_for(6).total_income.should == 100
        event.scenario_for(10).total_income.should == 500
        event.scenario_for(20).total_income.should == 1500
        event.scenario_for(21).total_income.should == 1700
      end

      it "takes into account fixed ticket price" do
        event.fixed_cost_per_ticket = 1;
        event.scenario_for(6).ticket_cost.should == 6
      end

      it "takes into account percent cost per ticket" do
        event.percent_cost_per_ticket = 10
        event.scenario_for(6).ticket_cost.should == 10
        event.scenario_for(21).ticket_cost.should == 170
      end

    end

    describe "sponsorship" do
      before(:each) do
        event.sponsors.create(:name=>"A", :price=>1000, :number_of_tickets=>2)
        event.sponsors.create(:name=>"B", :price=>2000, :number_of_tickets=>3)
      end

      it "cost of for sponsors should be included in the total cost" do
        event.scenario_for(0).total_cost.should == 200
        event.scenario_for(0).delegate_cost.should == 50
      end

      it "should include sponsorship income in the total income" do
        event.scenario_for(0).total_income.should == 3000
        event.scenario_for(0).sponsorship_income.should == 3000
      end
    end

    describe "tickets sold" do
      it "should assume tickets sold cheapest first" do
        event.scenario_for(00).tickets_sold.should == {"Free"=>0, "Mid"=>0, "High"=>0}
        event.scenario_for(05).tickets_sold.should == {"Free"=>5, "Mid"=>0, "High"=>0}
        event.scenario_for(20).tickets_sold.should == {"Free"=>5, "Mid"=>15, "High"=>0}
        event.scenario_for(25).tickets_sold.should == {"Free"=>5, "Mid"=>15, "High"=>5}
      end
    end


  end
end
