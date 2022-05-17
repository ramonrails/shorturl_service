# frozen_string_literal: true

Rails.application.routes.draw do
  # NOTE: 
  get '/:id/stats', to: 'short_urls#show'
  get '/:id', to: 'short_urls#show'
  resources :short_urls
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "short_urls#index"
end
