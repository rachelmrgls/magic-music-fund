Rails.application.routes.draw do
  get 'clubs/new'
  get 'club_session/new'

  get 'sessions/club'

  get 'sessions/new'

  resources :charges 
  resources :students
  resources :clubs
  resources :campaigns
  resources :pledges, only: [:create, :destroy]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'campaigns#index'
  get    'home'    => 'campaigns#index'
  get    'signup'  => 'students#new'
  get    'student_login'   => 'sessions#new'
  post   'student_login'   => 'sessions#create'
  delete 'student_logout'  => 'sessions#destroy'
  get    'club_signup'  => 'clubs#new'
  get    'club_login'   => 'club_session#new'
  post   'club_login'   => 'club_session#create'
  delete 'club_logout'  => 'club_session#destroy'
  get   'profile'  => 'students#show'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
