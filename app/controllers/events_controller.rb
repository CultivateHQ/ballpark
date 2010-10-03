class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @scenario = @event.scenario_for(200)
  end

  def create
    @event = Event.new(params[:event])
    @event.save!
    redirect_to :action=>:index
  end
end
