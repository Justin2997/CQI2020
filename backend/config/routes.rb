Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'profile/create'
  get 'profile/list'
  get 'profile/show'
end
