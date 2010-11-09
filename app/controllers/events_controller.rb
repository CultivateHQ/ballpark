class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def show
    find_event
    scenario_for(@event.capacity)
  end


  def scenario
    find_event
    scenario_for(params[:sales].to_i)
    render :partial=>'scenario_result'
  end

  def create
    @event = Event.new(params[:event])
    @event.save!
    redirect_to :action=>:index
  end

private

  def find_event
    @event = Event.find(params[:id])
  end

  def scenario_for(sales)
    @scenario = @event.scenario_for(sales)
  end

end
