Mypolice::Application.routes.draw do |map|
  resources :addresses

  resources :responses

  devise_for :polices

  devise_for :admins

  resources :posts do
    resources :responses
    resources :comments
  end
  
  resources :tags

  namespace :admin do 
    resources :posts do  
        put :approve, :on => :member
        put :unapprove, :on => :member
        get :approved, :on => :collection
        get :unapproved, :on => :collection
      end
    resources :comments do  
        put :approve, :on => :member
        put :unapprove, :on => :member
        get :approved, :on => :collection
        get :unapproved, :on => :collection
      end
    resources :polices do
        put :cheif, :on => :member
        put :uncheif, :on =>:member
    end
    resources :responses, :users, :tags, :categories, :whos
  end

  namespace :police do
    resources :polices
  end

  
  devise_for :users  

  get "home/index"
  
  match "/admin" => "admin/dashboard#index", :as => :admin_root
  match "/police" => "police/dashboard#index", :as => :police_root
 
  match '/police/profile/:id/' => 'police/polices#show', :as => :profile   

  resource :admins do 
    root :to => :admin_root 
  end

  resource :polices do
    root :to => :police_root
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to =>"home#index"
end
