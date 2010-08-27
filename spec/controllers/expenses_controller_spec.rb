require 'spec_helper'

describe ExpensesController do
  describe "creating expense" do
    before(:each) do
      @event = Event.create(:name=>'Och AYE')
    end
    describe "successfully" do
      before(:each) do
        post :create, :expense=>{:description=>'Haggis', :amount=>'45.50'}, :event_id=>@event.id.to_s
      end

      it "should add the expense to the event, and save" do
        @event.reload.fixed_expenses.size.should == 1
        @event.fixed_expenses.first.description.should == 'Haggis'
        @event.fixed_expenses.first.amount.should == 45.50
      end

      it "should add redirect to the expenses list" do
        response.should redirect_to event_expenses_path(@event.id)
      end
    end

    describe "unsuccessfully" do
      before(:each) do
        post :create, :expense=>{}, :event_id=>@event.id.to_s
      end

      it "should render the index" do
        response.should be_success
        response.should render_template 'index'
      end

      it "should assign the expense and event" do
        assigns(:event).should_not be_nil
        assigns(:expense).should_not be_nil
      end

    end

  end



  after(:each) do
    Event.all.each {|e| e.destroy}
  end

end
