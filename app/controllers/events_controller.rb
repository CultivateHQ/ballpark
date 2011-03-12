class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def index
    @events = current_user.events
  end

  def show
    find_event
    scenario_for(@event.default_sales || @event.capacity * 0.8)
  end


  def scenario
    find_event
    @event.update_attribute(:default_sales, params[:sales])
    scenario_for(params[:sales])
    render :partial=>'scenario_result'
  end

  def create
    @event = current_user.events.create(params[:event])
    redirect_to :action=>:index
  end

private

  def find_event
    super(params[:id])
  end
  def scenario_for(sales)
    @scenario = @event.scenario_for(sales.to_i)
  end

end
