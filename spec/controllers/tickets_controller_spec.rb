require 'spec_helper'

describe TicketsController do
  include ControllerHelper

  always_login
  always_creates_event


  def self.it_should_redirect_to_index
    it "should redirect to the index" do
      response.should redirect_to(:action=>:index)
      assert assigns(:ticket)
      assert_equal @event, assigns(:event)
    end
  end

  describe :index do
    before(:each) do
      get :index, :event_id=>@event.id.to_s
    end

    it "should render index and assign tickets" do
      response.should be_success
      response.should render_template 'index'
      assigns(:event).should_not be_nil

    end

  end

  describe :create do
    describe :successful do

      before(:each) do
        post :create, :event_id=>@event.id.to_s, :ticket=>{:capacity=>5, :price=>100,:name=>'Early Bird'}
      end

      it_should_redirect_to_index

      it "should create the ticket" do
        @event.reload.tickets.size.should == 1
        @event.tickets.first.name.should == 'Early Bird'
      end

    end


    describe :unsuccessful do
      before(:each) do
        post :create, :event_id=>@event.id.to_s, :ticket=>{:capacity=>3}
      end

      it "should re-render the index" do
        response.should render_template 'index'
        response.should be_success
      end

      it "should not create the ticket" do
        @event.reload.tickets.should be_empty
        assigns(:event).tickets.should be_empty
        assigns(:ticket).capacity.should == 3
      end

    end
  end

  describe :update do

    before(:each) do
      @ticket = @event.tickets.build(:name=>'Early worm', :capacity=>10, :price=>100)
      @event.save
    end

    describe :successful do
      before(:each) do
        put :update, :event_id=>@event.id, :id=>@ticket.id, :ticket=>{:name=>'Early bird'}
      end

      it_should_redirect_to_index

      it "should update the ticket" do
        @event.reload.tickets.first.name.should == 'Early bird'
      end
    end

    describe :unsuccessful do
      before(:each) do
        put :update, :event_id=>@event.id.to_s, :id=>@ticket.id, :ticket=>{:name=>''}
      end

      it "should re-render the index" do
        response.should render_template 'index'
        response.should be_success
      end

      it "should not update the ticket" do
        @event.reload.tickets.first.name.should == 'Early worm'
      end

    end
  end

  describe :destroy do
    before(:each) do
      @ticket = @event.tickets.build(:name=>'Early worm', :capacity=>10, :price=>100)
      @event.save
      delete :destroy, :event_id=>@event.id, :id=>@ticket.id
    end

    it "should remove the ticket" do
      @event.reload.tickets.should be_empty
    end

    it_should_redirect_to_index

  end


  describe :update_ticket_cost_details do
    before(:each) do
      put :update_ticket_cost_details, :event_id=>@event.id.to_s, :event=>{:fixed_cost_per_ticket=>0.99, :percent_cost_per_ticket=>4.1}
    end

    it_should_redirect_to_index

    it "updates the ticket cost" do
      assert_equal 0.99, @event.reload.fixed_cost_per_ticket
      assert_equal 4.1, @event.percent_cost_per_ticket
    end
  end

  describe :edit do
    before(:each) do
      @ticket = @event.tickets.create(:name=>'Early worm', :capacity=>10, :price=>100)
      get :edit, :id=>@ticket.id, :event_id=>@event.id
    end

    it "renders ok" do
      response.should be_success
      assert_equal @ticket, assigns(:ticket)
    end
  end

end
