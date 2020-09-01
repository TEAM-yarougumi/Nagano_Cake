Rails.application.routes.draw do
  #devise
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
  
  #top,about
  get 'owners/top' => 'owners#top'
  root 'home#top'
  get 'home/about' => 'home#about'


  #owner_side

  namespace :owners do
    #items
    resources :items, only: [:new, :create, :edit, :update]
    get	'items/index_owner'    =>  'items#index_owner'
    get	'items/:id/show_owner' =>  'items#show_owner'
    
    #genre
    resources :genres, only: [:index, :create, :edit, :update]
    
    #customers
    resources :customers, only: [:index]
    get 'customers/:id/show_owner'      => 'customers#show_owner'
    get 'customers/:id/edit/edit_owner' => 'customers#edit_owner'
    patch 'customers/:id/update_owner'  => 'customers#update_owner'

    #orders
    resources :orders, only: [:index, :show, :update]
    patch 'order/:id/update_order' => 'orders#update_order'

  end


  #customer_side

  scope module: :customers do
    #customers_1
    resources :customers, only: [:show, :edit, :update] do
      #cart_items
      resources :cart_items, only: [:create, :index, :update, :destroy]
      delete 'cart_items' => 'cart_items#all_destroy'

      #shipping_addresses
      resources :shipping_addresses , only: [:index,  :create, :edit, :update, :destroy]

      #orders_1
      resources :orders, only: [:index, :show, :new, :create]
    end
    
    
    #customers_2
    get 'customers/:id/leave' => 'customers#leave'
    patch 'customers/out' => 'customers#out'
    
    #orders_2
    get'/customers/:customer_id/orders/thanks' => 'orders#thanks'
    post'/customers/:customer_id/orders/:id/confirm' => 'orders#confirm'
    get'/customers/:customer_id/orders/:id/complete' => 'orders#complete'    
  end

  namespace :customers do
    #items
    resources :items, only: [:index, :show]
  end
  
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end