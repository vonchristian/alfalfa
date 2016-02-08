Rails.application.routes.draw do
  mount Plutus::Engine => "/accounting", :as => "accounting"
resources :accounts
resources :assets
resources :revenues
resources :liabilities
resources :equities
resources :incomes



  root "projects#index"
  get "projects/search"
  get "/dashboard" => 'dashboards#dashboard', as: "dashboard"
  get 'entries/daily' => 'entries#daily'

  resources :contractors do
    resources :billings, module: :contractors

  end
  resources :expenses do
    resources :entries
  end
  resources :equipment
  resources :entries
  resources :inventories

  namespace :accounts do
  resources :expenses do
    resources :entries, module: :expenses
  end
  resources :liabilities
  resources :equities
  resources :revenue
  resources :assets
end
  resources :projects do
    match :detailed, via: [:get], on: :collection
 
    resource :notice_to_proceed
    resources :time_extensions
    resources :amount_revisions
    resources :remarks
    resources :accomplishments
    resources :expenses,         module: :projects
    resources :bids
    resources :contracts
    resources :billings, module: :projects
  end
  resources :requirements

end
