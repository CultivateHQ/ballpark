require 'spec_helper'

describe EventsController do
include ControllerHelper
  before(:each) do
    @event = Event.create(:name=>"Och Aye")
    login
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

  describe "create" do
    before(:each) do
      post :create, :event=>{:name=>'Oooplah'}
    end

    it "redirects" do
      response.should redirect_to(:action=>:index)
    end
    
    it "creates the event" do
      assert Event.find(:conditions=>{:name=>'Oooplah'})
    end
  end

end
