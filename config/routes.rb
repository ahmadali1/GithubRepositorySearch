Rails.application.routes.draw do
  root to: 'github#index'
  get 'search', to: 'github#search'
end
