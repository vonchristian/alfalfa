Rails.application.routes.draw do
  namespace :cost_code do
    resources :divisions, except:[:destroy] do
    resources :items, only:[:new, :create]
  end
  end


  get 'settings/index'
  get 'reports/contract_summary_report', as: 'contract_summary_report'
  get 'reports/index', as: 'reports'
 devise_for :users, :controllers => { :registrations => "users" }
get 'expenses/filtered_data' => 'expenses#filtered_data'
get 'accounts/income_statement' => 'accounts#income_statement'

resources :materials do
  get "delete"
end
  mount Plutus::Engine => "/accounting", :as => "accounting"
resources :activities
resources :employees do
  resources :cash_advances, module: :employees
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

  resources :construction_equipments do
    resources :depreciations, only:[:new, :create], module: :construction_equipments
  end
  resources :lands
  resources :expenses do
    resources :entries
  end
  resources :equipment
  resources :entries
  resources :inventories
resources :accounts do
  match :balance_sheet, via: [:get], on: :collection
end
  namespace :accounts do

  resources :expenses do
    resources :entries, module: :expenses
  end
  resources :liabilities
  resources :equities
  resources :revenue
  resources :assets
end
resources :work_details do
  resources :work_accomplishments, module: :projects
  resources :materials, module: :projects
  resources :labor_costs, module: :projects
  resources :equipment_costs, module: :projects
end
  resources :projects do
    resources :work_details, module: :projects
    resources :invoices, only:[:new, :create], module: :projects
    resources :billable_materials
  resources :workers
    resources :collections
    resources :project_billings
      match :overview, via: [:get], on: :collection
      match :import, via: [:post], on: :collection
      match :add_workers, via: [:get], on: :member
      match :add_cost_code_items, via: [:get], on: :member

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

  resources :contracts do
    resources :contract_amount_revisions
  end


end
