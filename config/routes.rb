Rails.application.routes.draw do
  scope defaults: { format: :json } do
    resources :artists, except: [:new, :edit] do
      get :featured, on: :collection
      get :ranked, on: :collection
      get :hot, on: :collection
    end
    resources :albums, except: [:new, :edit] do
      resources :songs
      get :recent, on: :collection
      get :ranked, on: :collection
      get :hot, on: :collection
    end
    resources :songs do 
      get :top_10, on: :collection
    end
    root to: 'artists#index'
  end
end
