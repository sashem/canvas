Listr::Application.routes.draw do
  resources :users
  resources :sessions
  match "sessions/destroy" => "sessions#destroy", via: "POST"
  get ":action" => "canvas#:action"
  match "users/login" => "users#login", via: "POST"
  match "users/fetch" => "users#fetch", via: "POST"
  match "users/fetch_all" => "users#fetch_all", via: "POST"
  match "users/update_datos" => "users#update_datos", via: "POST"
  match "proyectos/fetch" => "proyectos#fetch", via: "POST"
  match "proyectos/create" => "proyectos#create", via: "POST"
  match "proyectos/delete" => "proyectos#delete", via: "POST"
  match "proyectos/update" => "proyectos#update_proyecto", via: "POST"
  match "canvas/fetch" => "canvas#fetch", via: "POST"
  match "canvas/create" => "canvas#create", via: "POST"
  match "canvas/delete" => "canvas#delete", via: "POST"
  match "canvas/add_item" => "canvas#add_item", via: "POST"
  match "canvas/remove_item" => "canvas#remove_item", via: "POST"
  match "canvas/save" => "canvas#save", via: "POST"
  match "canvas/update" => "canvas#update_canva", via: "POST"
  match "canvas/fetch_canva" => "canvas#fetch_canva", via: "POST"
  match "mensajes/create" => "mensajes#create", via: "POST"
  match "mensajes/delete" => "mensajes#delete", via: "POST"
  match "permisos/fetch" => "permisos#fetch", via: "POST"
  match "permisos/create" => "permisos#create", via: "POST"
  match "permisos/edit" => "permisos#edit", via: "POST"
  match "permisos/delete" => "permisos#delete", via: "POST"
  get ":action" => "canvas#canvas"
  resources :datos
  resources :proyectos
  resources :canvas
  
  
  
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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
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
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
