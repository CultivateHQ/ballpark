class ApplicationController < ActionController::Base
  before_filter :ensure_ssl_if_production_and_heroku
  before_filter :authenticate_user!
  protect_from_forgery

  def find_event(id=params[:event_id])
    @event = current_user.events.find(id)
  end

  private

  def ensure_ssl_if_production_and_heroku
    redirect_to "https://#{request.host}#{request.path_info}" if "production" == Rails.env && 'https' != request.env['HTTP_X_FORWARDED_PROTO']
  end

end

