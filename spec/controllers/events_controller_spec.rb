require 'spec_helper'

describe EventsController do
include ControllerHelper

  always_login
  always_creates_event



  describe "scoping" do
    it "only finds events belonging to the current user" do
      other_user = Fabricate(:user, :email=>'other@example.com')
      other_event = other_user.events.create!(:name=>'Other event')
      assert_raise(Mongoid::Errors::DocumentNotFound) do
        get 'show', :id=>other_event.id
      end
    end
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
      post :create, :event=>{:name=>'pingu'}
    end

    it "redirects" do
      response.should redirect_to(:action=>:index)
    end
    it "creates the event" do
      assert Event.find(:first, :conditions=>{:name=>'pingu'})
    end

    it "associates the event with the current user" do
      assert_equal controller.current_user, Event.find(:first, :conditions=>{:name=>'pingu'}).user
    end
  end

end
