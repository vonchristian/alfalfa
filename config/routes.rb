Rails.application.routes.draw do
 

  get 'settings/index'
  get 'reports/contract_summary_report', as: 'contract_summary_report'
  get 'reports/index', as: 'reports'
 devise_for :users, :controllers => { :registrations => "users" }


  mount Plutus::Engine => "/accounting", :as => "accounting"
resources :activities
resources :categories
resources :accounts
resources :assets
resources :revenues
resources :liabilities
resources :equities
resources :incomes

resources :users

  root "projects#index"
  get "projects/search"
  get "/dashboard" => 'dashboards#dashboard', as: "dashboard"
  get 'entries/daily' => 'entries#daily'

  resources :contractors
    
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
    resources :collections
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
