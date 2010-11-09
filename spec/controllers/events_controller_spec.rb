require 'spec_helper'

describe EventsController do

  before(:each) do
    @event = Event.create(:name=>"Och Aye")
  end

  after(:each) do
    Event.all{|event| event.destroy}
  end

  describe "showing event" do
    before(:each) do
      get 'show', :id=>@event.id.to_s
    end


    it "successfully renders the event" do
      response.should be_success
      response.should render_template('show')
      assigns(:event).should == @event
      assigns(:scenario).should_not be_nil
    end

  end

  describe "showing scenario" do
    before(:each) do
      get :scenario, :id=>@event.id.to_s, :sales=>"35"
    end

    it "renders the partial scenario" do
      response.should be_success
      response.should render_template('scenario_result')
      assigns(:event).should == @event
      assigns(:scenario).should_not be_nil
    end


    it "displayes the correct scenario" do
      assigns(:scenario).sales.should == 35
    end
  end

end
