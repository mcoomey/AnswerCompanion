AnswerCompanion::Application.routes.draw do

  get "instructors/index"

  get "instructor/index"

  get "course_assets/new"

  get "course_assets/create"

  get "course_assets/index"

  get "course_assets/show"

  get "course_assets/edit"

  get "course_assets/update"

  get "course_assets/destroy"

  get "screens/index"
  get "screens/welcome"
  
  resources :categories do
    resources :subcategories
  end

  resources :textbooks do
    resources :exercises
  end

  resources :textbooks do
    resources :lessons
  end

  resources :textbooks do
    resources :section_titles
  end
 
  resources :exercises do
    resources :videos
  end
  
  resources :lessons do
    resources :videos do
      get 'progress'
    end
  end
  
  devise_for :instructors, :controllers => {:registrations => "instructors/registrations"} do
    get '/instructor/signup', :to => 'instructors/registration#new'
    post '/resource', :to => 'instructors/registration#create'
  end
  
  devise_for :students

  devise_for :parents

	resources :instructors do
		resources :courses
	end
	
	resources :students do
		resources :subjects
	end
	
	resources :subjects do
		resources :textbook_delegations
	end
	
	resources :videos
  resources :section_titles
  resources :lessons
  resources :exercises
  resources :schools
  resources :courses
  
	root :to => "screens#index"
	
	match "subjects/toggle_archive", :to => "subjects#toggle_archive"

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
