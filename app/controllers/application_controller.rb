class ApplicationController < ActionController::Base
  protect_from_forgery

  def find_event
    @event = Event.find(params[:event_id])
  end

end

