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
      it "should be total income - cost" do
        event.scenario_for(0).profit.should == -150
        event.scenario_for(10).profit.should == 250
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
