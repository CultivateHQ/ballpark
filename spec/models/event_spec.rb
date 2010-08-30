require 'spec_helper'

describe Event do

  describe "fixed_expenses" do
    describe "total" do
      it "should be total of amounts" do
        event = Event.new
        event.fixed_expenses.total.should == 0
        event.fixed_expenses << Expense.new(:amount=>2)
        event.fixed_expenses.total.should == 2
        event.fixed_expenses << Expense.new(:amount=>3)
        event.fixed_expenses.total.should == 5
      end
    end
  end
end
