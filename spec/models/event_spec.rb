require 'spec_helper'

describe Event do

  describe "add_fixed_expense" do
    it  "should add valid expense" do
      event = Event.new
      event.fixed_expenses.add(:description=>'An expense', :amount=>'23.51').should be_true
      event.fixed_expenses.size.should == 1
      event.fixed_expenses.first.description.should == 'An expense'
      event.fixed_expenses.first.amount.should == 23.51
    end

    it "should not add an invalid expense" do
      event = Event.new
      event.fixed_expenses.add({}).should be_false
      event.fixed_expenses.should be_empty
    end

  end
end
