require 'spec_helper'

describe Event do
  it  "should add fixed expense" do
    event = Event.new
    event.add_fixed_expense 'An expense', 23.51
    event.fixed_expenses.size.should == 1
    event.fixed_expenses.first.description.should == 'An expense'
    event.fixed_expenses.first.amount.should == 23.51
  end

end

