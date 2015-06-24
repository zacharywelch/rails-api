Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    resources :songs, except: [:new, :edit]
    resources :albums, except: [:new, :edit]
    resources :artists, except: [:new, :edit]
  end

  root to: 'artists#index', scope: :api, defaults: { format: :json }
end
