Warmup::Application.routes.draw do
  
  # root :to => redirect('/home/index')
  # get "home/index"

  # get '/users', to: 'user#index', as: :user_form
  # post '/users', to: 'user#index', as: :user_index

  # get '/', to: 'home#index', as: :home

  get '/', to: 'animal#index',  as: :home
  post '/adopt', to: 'animal#adopt', as: :adopt
  # match '/adopt', to: 'animal#adopt', via: :options

  # get '/users', to: 'user#index', as: :users_all
  post '/users/add', to: 'user#add'
  post '/users/login', to: 'user#login'
  post '/TESTAPI/resetFixture', to: 'user#reset_fixture'
  post '/TESTAPI/unitTests', to: 'user#unit_tests'

  # test paths
  # get '/test/add', to: 'user#add', as: :test_add
  # get '/test/login', to: 'user#login', as: :test_login

  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
