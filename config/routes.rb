Rails.application.routes.draw do
  scope defaults: { format: :json } do
    resources :artists, except: [:new, :edit] do
      get :featured, on: :collection
      get :ranked, on: :collection
      get :hot, on: :collection
    end
    resources :albums, except: [:new, :edit] do
      resources :songs, only: [:index, :create]
      get :recent, on: :collection
      get :ranked, on: :collection
      get :hot, on: :collection
    end
    resources :songs, except: [:new, :edit, :create] do
      get :top_25, on: :collection
      get :hot, on: :collection 
    end
    root to: 'artists#index'
  end
end
