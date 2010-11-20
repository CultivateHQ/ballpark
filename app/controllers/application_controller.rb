class ApplicationController < ActionController::Base
  before_filter :ensure_ssl_if_production_and_heroku
  protect_from_forgery

  def find_event
    @event = Event.find(params[:event_id])
  end

  private

  def ensure_ssl_if_production_and_heroku
    redirect_to "https://#{request.host}#{request.path_info}" if "production" == RAILS_ENV && 'https' != request.env['HTTP_X_FORWARDED_PROTO']
  end

end

