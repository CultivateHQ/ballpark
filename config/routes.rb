Enigma::Application.routes.draw do
  require_ssl = !Rails.env.development?
  scope :constraints => require_ssl ? { :protocol => "https" }  : {} do
    resources :events do
      get :scenario, :on=>:member
      resources :fixed_expenses
      resources :delegate_expenses
      resources :tickets do
        put :update_ticket_cost_details, :on=>:collection
      end
      resources :sponsors
    end

    devise_for :users
    root :to=> redirect("/events")

  end

  match "/*path", :to => redirect { |_, request| "https://" + request.host_with_port + request.fullpath } if require_ssl

end
