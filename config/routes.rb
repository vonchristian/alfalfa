Rails.application.routes.draw do
  

  ####Accounting Department
  namespace :accounting do
    resources :bank_account
    resources :petty_cash, only: [:index] do
      resources :disbursements, module: :petty_cash
      resources :fund_transfers, module: :petty_cash
    end
    resources :reports, only:[:index]
    resources :balance_sheet, only:[:index]
    resources :income_statement, only:[:index]
    resources :entries
  end

  resources :accounts

  get 'settings/index'
  get 'reports/contract_summary_report', as: 'contract_summary_report'
  get 'reports/index', as: 'reports'

  devise_for :users, :controllers => { :registrations => "users", sessions: "users/sessions" }
  get 'expenses/filtered_data' => 'expenses#filtered_data'
  get 'accounts/income_statement' => 'accounts#income_statement'
  resources :payroll, only:[:index, :show]

  resources :activities
  resources :employees do
    resources :cash_advances, :module => :employees
    resources :worked_days, :module => :employees
    resources :educational_attainments, module: :employee_details
    resources :salaries, module: :employees
  end

  resources :categories
  resources :users
   root "projects#index"
  get "projects/search"
  get "/dashboard" => 'dashboards#dashboard', as: "dashboard"
  get 'result/index' => "result#index"
  get 'supplies/inventories' => "supplies/inventories#index"
  resources :contractors do
    resources :issued_inventories, module: :contractors
  end

  resources :inventories do
    resources :restockings, module: :inventories
    resources :stocks, module: :inventories
  end
  resources :sales, module: :inventories
  resources :issued_inventories

  namespace :accounts do

    resources :liabilities
    resources :equities
    resources :revenue
    resources :assets
  end

resources :work_details do
  resources :work_accomplishments, module: :projects
  resources :issued_inventories, module: :projects
  resources :purchase_orders, module: :work_details
  resources :employments, module: :work_details
  resources :equipment_maintenances, module: :work_details
  resources :equipment_costs, module: :work_details
  resources :equipment_fuel_costs, only:[:new, :create], module: :work_details
  resources :time_extensions,     only:[:new, :create], module: :work_details
  resources :amount_revisions,   only:[:new, :create], module: :work_details
end

resources :joint_ventures, controller: 'projects', type: 'JointVenture'

  resources :projects do
    resources :equipment_costs, module: :projects
    resources :add_workers, module: :projects
    resources :attachment_files, module: :projects
    resources :assign_project_engineers, module: :projects
    resources :activities, only:[:index], module: :projects
    resources :work_details, module: :projects
    resources :invoices, only:[:new, :create], module: :projects
    resources :employments, module: :projects
    resources :employees
    resources :collections
      match :overview, via: [:get], on: :collection
      match :payroll, via: [:get], on: :member
    resource :notice_to_proceed, module: :project_details
    resources :remarks
    resources :expenses,         module: :projects
    resources :contracts
  end

  resources :contracts do
    resources :contract_amount_revisions
  end





  resources :fund_transfers

  resources :equipment do
    resources :fuel_expenses, module: :equipment
    resources :equipment_schedules, module: :equipment
    resources :equipment_statuses, module: :equipment
  end

  resources :equipment_statuses, only: [:edit, :update]
  resources :supplies


  resources :orders, module: :supplies

  namespace :supplies do
    resources :line_items
    resources :inventories
    resources :carts
  end



end
