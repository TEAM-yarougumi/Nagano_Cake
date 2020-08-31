Rails.application.routes.draw do
  devise_for :owners, controller: {
    sessions: "models/sessions",
    passwords: "models/passwords",
    registrations: "models/registration"
    }

  devise_for :customers, controller: {
    sessions: "models/sessions",
    passwords: "models/passwords",
    registrations: "models/registration"
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end