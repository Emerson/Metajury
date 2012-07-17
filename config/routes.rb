RocketFuel::Application.routes.draw do

  root :to => 'pages#home'

  # Session Routes
  match 'login'   => 'user_sessions#login',  :as => 'login'
  match 'logout'  => 'user_sessions#logout', :as => 'logout'

  # User Routes
  resources :users
  match 'users/:id/submissions' => 'submissions#user_submissions', :as => 'user_submissions'

  match 'confirm/:token'   => 'users#confirm',   :as => 'confirmation'
  match 'reconfirm/:id'    => 'users#reconfirm', :as => 'reconfirm'

  # Password Reset Routes
  match 'request-password-reset' => 'users#request_password_reset', :as => 'request_password_reset'
  match 'password/:token/update' => 'users#update_password',        :as => 'update_password',      :via => [:get, :post]
  match 'password/send-reset'    => 'users#send_password_reset',    :as => 'send_password_reset',  :via => :post

  # Conditional Routes
  match 'signup'  => 'users#signup', :as => 'signup' if ApplicationSettings.config['user_registration']
  match 'account' => 'users#edit',   :as => 'account'

  # Submission Routes
  resources :submissions do
    resources :comments
  end

  # User submissions
  match 'my-submissions' => 'submissions#current_user_submissions', :as => 'current_user_submissions'

  # Voting Paths
  match 'submission/:id/upvote' => 'submissions#upvote', :as => 'upvote'
  match 'submission/:id/downvote' => 'submissions#downvote', :as => 'downvote'
  match 'comment/:id/upvote' => 'comments#upvote', :as => 'upvote_comment'
  match 'comment/:id/downvote' => 'comments#downvote', :as => 'downvote_comment'

  # Tag Paths
  match 'tag/:tag'  => 'submissions#tag', :as => 'tag'
  match 'tags/list' => 'submissions#tag_list', :as => 'tag_list'

  namespace :admin do
    resources :users do
      member do
        get 'confirm_delete'
      end
    end
    resources :submissions do
      member do
        get 'confirm_delete'
      end
    end
    root :to => 'dashboard#index'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority

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
  # match ':controller(/:action(/:id(.:format)))'
end
