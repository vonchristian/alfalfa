Rails.application.routes.draw do


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
resources :work_details do
  resources :work_accomplishments, module: :projects
  resources :issued_materials, module: :projects
  resources :labor_costs, module: :projects
  resources :equipment_costs, module: :projects
end
  resources :projects do
    resources :add_workers, module: :projects
    resources :assign_project_engineers, module: :projects
    resources :activities, only:[:index], module: :projects
    resources :work_details, module: :projects do
       match :import, via: [:post], on: :collection, module: :projects
     end
    resources :invoices, only:[:new, :create], module: :projects
    resources :billable_materials
  resources :workers
    resources :collections
      match :overview, via: [:get], on: :collection
    resource :notice_to_proceed, module: :projects
    resources :time_extensions
    resources :amount_revisions
    resources :remarks
    resources :expenses,         module: :projects
    resources :contracts
  end
  resources :contracts do
    resources :contract_amount_revisions
  end


end
