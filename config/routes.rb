RadioDePaulWebsite2::Application.routes.draw do
  devise_for :people, ActiveAdmin::Devise.config
  root to: "admin/dashboard#index"
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :awards
      resources :events
      resources :managers
      resources :news_posts
      resources :people
      resources :shows do
        collection do
          get 'onair'
        end
      end
      resources :slots
    end
  end


  resources :events

  resources :awards

  resources :award_organizations

  if Rails.env == 'production'
    ActiveAdmin.routes(self)
  else
    ActiveAdmin.routes(self)
  end

  get 'people/become' => 'people#become'
  get 'people/reset_password' => 'people#reset_password'

  get 'people/send_welcome' => 'people#send_welcome'

  resources :settings

  resources :applications do
    get :autocomplete_genre_name, :on => :collection   
    collection do
      put 'admin'
    end
  end

  resources :apps, :controller => 'applications' do
    get :autocomplete_genre_name, :on => :collection   
    collection do
      put 'admin'
    end
  end

  resources :news_posts

  resources :podcasts

  get 'welcome' => 'pages#welcome', :as => 'welcome'

  get 'home' => 'pages#home', :as => 'home'

  get 'apps/hire/:id' => 'applications#hire', :as => 'applications_hire'

  get "pages/api"

  get 'application' => "applications#new", :as => '/application'

  resources :slots do
    collection do
      get 'current'
      get 'now_playing'
    end
  end

  resources :managers do
    collection do
      get 'random'
    end
  end

  resources :hostings
  
  resources :people do
    collection do
      get 'random'
      get 'search'
      put 'admin'
    end
  end

  resources :shows do
    collection do
      get 'random'
      get 'search'
      get :autocomplete_genre_name
      put 'admin'
    end
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
#  root :to => 'pages#welcome'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
