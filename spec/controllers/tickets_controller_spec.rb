require 'spec_helper'

describe TicketsController do
  before(:each) do
    @event = Event.create(:name=>'Och AYE')
  end


  def self.it_should_redirect_to_index
      it "should redirect to the index" do
        response.should redirect_to(:action=>:index)
      end
  end
  describe :index do
    before(:each) do
      get :index, :event_id=>@event.id.to_s
    end

    it "should render index and assign tickets" do
      response.should be_success
      response.should render_template 'index'
      assigns(:tickets).should_not be_nil
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

end
