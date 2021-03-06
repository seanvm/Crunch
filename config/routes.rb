Rails.application.routes.draw do
  root 'home#show'
  get 'home/show'

  resources :issues do
    # put '/issues/:id/review', to: 'bets#review'
    put :review, defaults: { format: 'js' } #-> /issues/:id/review
    put :complete, defaults: { format: 'js' } #-> /issues/:id/complete
    put :development, defaults: { format: 'js' } #-> /issues/:id/development
    put :confirm, defaults: { format: 'js' } #-> /issues/:id/confirm
    put :unverified, defaults: { format: 'js' } #-> /issues/:id/unverified
  end

  resources :sessions, only: [:create, :destroy]
    get 'sessions/create'
    get 'sessions/destroy'

    get 'auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    get 'signout', to: 'sessions#destroy', as: 'signout'
  
  resources :users

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
