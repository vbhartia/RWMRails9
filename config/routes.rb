Rwm9::Application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  root :to => "static_pages#home_page"


  #*********** User Homepage *********#

  get 'dash' => 'user_dash#dash'

  #*********** Article Handler *********#
  get 'articles' => 'article#index'

  #Render iFrame
  get 'articles/iFrame' => 'article#iFrame'

  #Render show
  get 'articles/show/:id' => 'article#show', as: 'article_url'

  #add article
  post 'articles/add_new_article' => 'article#add_new_article'

  #Handle Public posts
  get 'articles/public/:id' => 'article#public_show'



  #*********** Group Handler *********#
  get 'groups' => 'group#index'

  post 'groups/assign_to_group' => 'group#assign_to_group'

  post 'groups/create' => 'group#create'

  get 'groups/show/:id' => 'group#show'

  get 'groups/new' => 'group#new'

  #*********** Comment Handler *********#

  post 'comment/new_comment' => 'comment#add_new_comment'


  #************* Session ************#
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
