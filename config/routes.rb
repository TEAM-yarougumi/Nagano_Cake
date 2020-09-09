Rails.application.routes.draw do
  #devise
  devise_for :owners, controller: {
    sessions: "owners/sessions",
    passwords: "owners/passwords",
    registrations: "owners/registration"
    }

  devise_for :customers, controller: {
    sessions: "customers/sessions",
    passwords: "customers/passwords",
    registrations: "customers/registration"
    }
  
  #top,about
  get 'owners/top' => 'owners#top'
  root 'home#top'
  get 'home/about' => 'home#about'


  #owner_side

  namespace :owners do
    #items
    resources :items, only: [:new, :create, :edit, :update]
    get 'items/index_owner'    =>  'items#index_owner'
    get 'items/:id/show_owner' =>  'items#show_owner'
    
    #genre
    resources :genres, only: [:index, :create, :edit, :update]
    
    #customers
    resources :customers, only: [:index]
    get 'customers/:id/show_owner'      => 'customers#show_owner' , as: :show_owner_costomer
    get 'customers/:id/edit/edit_owner' => 'customers#edit_owner', as: :edit_owner_costomer
    patch 'customers/:id/update_owner'  => 'customers#update_owner', as: :update_owner_costomer

    #orders
    resources :orders, only: [:index, :show, :update]
    patch 'order/:id/update_order' => 'orders#update_order'

  end


  #customer_side
  
  #items
  namespace :customers do
    resources :items, only: [:index, :show]
  end

  scope module: :customers do
    #customers_1
    get 'customers/:id/leave' => 'customers#leave', as: :leave
    patch 'customers/out' => 'customers#out'

    #customers_2
    resources :customers, only: [:show, :edit, :update] do
      #cart_items
      delete 'cart_items' => 'cart_items#all_destroy'
      resources :cart_items, only: [:create, :index, :update, :destroy]
      
      #shipping_addresses
      resources :shipping_addresses , only: [:index,  :create, :edit, :update, :destroy]
      
      #orders_1
      resources :orders, only: [:index, :show, :new, :create]
    end
    
    #orders_2
    get '/customers/:customer_id/orders/thanks' => 'orders#thanks'
    post '/customers/:customer_id/orders/confirm' => 'orders#confirm', as: :confirm
    get '/customers/:customer_id/orders/:id/complete' => 'orders#complete'    
  end
  
  
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
