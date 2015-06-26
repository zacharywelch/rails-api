Rails.application.routes.draw do
  scope defaults: { format: :json } do
    resources :artists, except: [:new, :edit] do
      get :featured, on: :collection
      get :ranked, on: :collection
      get :hot, on: :collection
    end
    get 'songs/top_10', to: 'songs#top_10', as: :top_10_songs
    resources :albums, except: [:new, :edit] do
      resources :songs, shallow: true
      get :recent, on: :collection
      get :ranked, on: :collection
      get :hot, on: :collection
    end
    root to: 'artists#index'
  end
end
