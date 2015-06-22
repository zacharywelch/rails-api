Rails.application.routes.draw do
  resources :songs, except: [:new, :edit]
  resources :albums, except: [:new, :edit]
  resources :artists, except: [:new, :edit]
end
