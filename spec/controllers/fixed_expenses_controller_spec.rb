require 'spec_helper'

describe FixedExpensesController do
  describe "creating expense" do
    before(:each) do
      @event = Event.create(:name=>'Och AYE')
    end
    describe "successfully" do
      before(:each) do
        post :create, :fixed_expense=>{:description=>'Haggis', :amount=>'45.50'}, :event_id=>@event.id.to_s
      end

      it "should add the expense to the event, and save" do
        @event.reload.fixed_expenses.size.should == 1
        @event.fixed_expenses.first.description.should == 'Haggis'
        @event.fixed_expenses.first.amount.should == 45.50
      end

      it "should add redirect to the expenses list" do
        response.should redirect_to event_fixed_expenses_path(@event.id)
      end
    end

  end

  after(:each) do
    Event.all.each {|e| e.destroy}
  end

end
