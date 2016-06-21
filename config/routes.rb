Rails.application.routes.draw do
  get 'download/download'

  # HACER BIEN LAS RUTAS LIBROS-USUARIO, MEJOR HACERLO MANUAL!
  resources :tags
  resources :books
  get 'search_form' => 'books#search_form'
  post 'search' => 'books#search'
  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'books/:id/add_to_library' => 'books#add_to_library', as: :add_to_library
  get 'convertions/:id/download' => 'convertions#download_convertion', as: :download_convertion
  get 'convertions' => 'convertions#index', as: :convertions
  delete 'convertions/:id' => 'convertions#destroy', as: :convertion
  get 'books/:id/convert/:output_format' => 'convertions#convert', as: :convert
  get 'books/:id/readepub' => 'books#readepub', as: :read_epub
  get 'books/:id/send_form' => 'books#send_form', as: :send_form
  post 'books/:id/send_book' => 'books#send_book', as: :send_book
  get 'books/:id/download_book' => 'books#download_book', as: :download_book
  get 'books/:id/create_preview' => 'convertions#create_preview', as: :create_preview
  get 'users/ban/:id' => 'users#ban', as: :ban_user
  get 'users/unban/:id' => 'users#unban', as: :unban_user
  get 'users/upgrade/:id' => 'users#upgrade', as: :upgrade_user
  get 'users/downgrade/:id' => 'users#downgrade', as: :downgrade_user
  get 'users/recommendations/:id' => 'users#recommend', as: :recommendate

#   get 'download/:download_host/:download_link' => 'download#download', as: :download

  get 'books/recommendations/:id' => 'books#recommend', as: :recommendations
  post 'books/rate/:id' => 'books#rate_book', as: :rate_book

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:index, :destroy]
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


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
