class ApplicationController < ActionController::Base
  before_filter :ensure_ssl_if_production_and_heroku
  before_filter :verify_access
  protect_from_forgery

  def find_event
    @event = Event.find(params[:event_id])
  end

  private

  def ensure_ssl_if_production_and_heroku
    redirect_to "https://#{request.host}#{request.path_info}" if "production" == RAILS_ENV && 'https' != request.env['HTTP_X_FORWARDED_PROTO']
  end


  def verify_access
    authenticate_or_request_with_http_basic("enigma") do |username, password|
      username == "ruby" && password == "w3w01f"
    end
  end

end

