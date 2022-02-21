Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
# Ensure you have defined root_url to *something* in your config/routes.rb.
#      For example:
