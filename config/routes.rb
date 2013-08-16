Rwm9::Application.routes.draw do

  resources :activities

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  root :to => "static_pages#home_page"
  #********** Static Pages ************#

  get 'bookmarklet' => "static_pages#bookmarklet", as: 'bookmarklet'
  get 'about' => "static_pages#about", as: 'about'
  get 'talent' => "static_pages#talent", as: 'talent'
  get 'contact' => "static_pages#contact", as: 'contact'
  get 'privacy' => "static_pages#privacy", as: 'privacy'
  get 'faq' => "static_pages#faq", as: 'faq'

  match '404', to: "static_pages#error_pages", as: 'error_page'
  #*********** User Homepage *********#

  get 'user/info' => 'user#info'

  #*********** Article Index *********#
  get 'articles' => 'article#index', as: 'my_articles'

  get 'articles/delete/:id' => 'article#delete', as: 'my_articles_delete'

  #*********** Article Handler *********#
  #Render iFrame
  get 'articles/iFrame' => 'article#iFrame'

  #Render show
  get 'articles/show/:id' => 'article#show', as: 'article'

  #add article
  post 'articles/add_new_article' => 'article#add_new_article'

  #get article
  get 'articles/get_article' => 'article#get_article'

  #*********** Comment Handler *********#

  post 'comment/new_comment' => 'comment#add_new_comment'
  get 'comment/get_article_comments' => 'comment#get_article_comments'


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
