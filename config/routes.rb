Rails.application.routes.draw do
 

  get 'settings/index'
  get 'reports/contract_summary_report', as: 'contract_summary_report'
  get 'reports/index', as: 'reports'
 devise_for :users, :controllers => { :registrations => "users" }
get 'expenses/filtered_data' => 'expenses#filtered_data'


  mount Plutus::Engine => "/accounting", :as => "accounting"
resources :activities
resources :employees do 
  end
resources :categories
resources :accounts
resources :assets do 
  resources :entries, module: :assets
end
resources :revenues
resources :liabilities
resources :equities
resources :incomes

resources :users

  root "projects#index"
  get "projects/search"
  get "/dashboard" => 'dashboards#dashboard', as: "dashboard"
  get 'entries/daily' => 'entries#daily'
get 'result/index' => "result#index"
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
  resources :workers
    resources :collections
    resources :project_billings
    match :overview, via: [:get], on: :collection
      match :add_workers, via: [:get], on: :member
    
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
