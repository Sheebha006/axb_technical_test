Rails.application.routes.draw do
  resources :invoices
  root 'invoices#index'

  post "add_collection" => "invoices#add_collection"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
