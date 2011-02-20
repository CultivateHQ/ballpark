require 'spec_helper'
describe SponsorsController do
  include ControllerHelper

  always_login
  always_creates_event


  describe :create do
    describe "successful" do
      before(:each) do
        post :create, :sponsor=>{:name=>"Gold Flush Inc", :price=>1500, :number_of_tickets=>4}, :event_id=>@event.id
      end

      it "redirects to index" do
        response.should redirect_to(:action=>:index)
      end


      it "creates the sponsor" do
        assert @event.reload.sponsors.find(:first, :conditions=>{:name=>"Gold Flush Inc"})
      end

    end

    describe "unsuccessful" do
      before(:each) do
        post :create, :sponsor=>{}, :event_id=>@event.id
      end

      it "renders index" do
        response.should render_template('index')
        assert assigns(:sponsor)
        assert assigns(:event)
      end

      it "does not add to the assigned event" do
        assert assigns(:event).sponsors.empty?
      end
    end

  end

  describe :index do
    before(:each) do
      get :index, :event_id => @event.id
    end

    it "renders ok" do
      response.should be_success
      assert assigns(:sponsor)
      assert assigns(:sponsor).new_record?
      response.should render_template('index')
    end
  end

  describe "update" do
    before(:each) do
      @sponsor = @event.sponsors.create(:name=>'Big Company', :number_of_tickets=>2, :price=>1000)
    end
    describe "successful" do
      before(:each) do
        put :update, :event_id=>@event.id, :id=>@sponsor.id, :sponsor=>{:name=>'Gold - Big Company'}
      end

      it "redirects to index" do
        response.should redirect_to(:action=>:index)
      end

      it "updates the sponsor" do
        assert_equal "Gold - Big Company", @event.reload.sponsors.find(@sponsor.id).name
      end
    end

    describe "unsuccessful" do
      before(:each) do
        put :update, :event_id=>@event.id, :id=>@sponsor.id, :sponsor=>{:name=>''}
      end

      it "renders edit" do
        response.should render_template('edit')
        assert assigns(:sponsor)
        assert_equal @sponsor.id, assigns(:sponsor).id
        #assert_equal "hi", event_sponsor_path(@event.id, @sponsor.id)
      end
    end
  end


  describe "delete" do
    
    before(:each) do
      @sponsor = @event.sponsors.create(:name=>'a', :number_of_tickets=>1, :price=>1)
      delete :destroy, :event_id=>@event.id, :id=>@sponsor.id
    end


    it "destroys" do
      assert @event.reload.sponsors.empty?
    end

    it "redirects to index" do
      response.should redirect_to(:action=>:index)
    end
  end

  describe :edit do
    before(:each) do
      @sponsor = @event.sponsors.create(:name=>'a', :number_of_tickets=>1, :price=>1)
      get :edit, :id=>@sponsor.id, :event_id=>@event.id
    end

    it "renders ok" do
      response.should be_success
      assert_equal @sponsor, assigns(:sponsor)
      response.should render_template(:edit)
    end
  end

end
