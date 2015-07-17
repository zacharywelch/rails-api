Rails.application.routes.draw do
  resources :users, except: [:new, :edit]
  scope defaults: { format: :json } do
    resources :artists, except: [:new, :edit] do
      get :featured, :ranked, :hot, on: :collection
      resources :albums, only: [:index, :create]
    end
    resources :albums, except: [:new, :edit, :create] do
      get :recent, :ranked, :hot, on: :collection
      resources :songs, only: [:index, :create]
    end
    resources :songs, except: [:new, :edit, :create] do
      get :top_25, :hot, on: :collection
    end
    root to: 'artists#index'
  end
end
