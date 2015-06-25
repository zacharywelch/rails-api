Rails.application.routes.draw do
  scope defaults: { format: :json } do
    resources :artists, except: [:new, :edit]
    resources :albums, except: [:new, :edit] do
      resources :songs
    end
    resources :songs
    root to: 'artists#index'
  end
end
