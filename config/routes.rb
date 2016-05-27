
Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users", sessions: "users/sessions" }

unauthenticated :user do
  root :to => 'monitoring/projects#index', :constraints => lambda { |request| request.env['warden'].user.nil? }, as: :unauthenticated_root
end

  root :to => 'monitoring/projects#index', :constraints => lambda { |request| request.env['warden'].user.role == 'monitoring_officer' if request.env['warden'].user }, as: :monitoring_root
  root :to => 'monitoring/projects#index', :constraints => lambda { |request| request.env['warden'].user.role == 'project_engineer' if request.env['warden'].user }, as: :projects_root
  root :to => 'accounting#index', :constraints => lambda { |request| request.env['warden'].user.role == 'accounting_officer' if request.env['warden'].user }, as: :accounting_root

  ####Accounting Department
  resources :accounting, only:[:index]
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
    resources :cash_flow, only: [:index]
    resources :accounts
  end
  resources :projects, only: [:index] do
    resources :payments, only: [:index], module: :project_payments
  end
  resources :monitoring, only:[:index]
  namespace :monitoring do
    resources :equipment, only: [:index]
    resources :projects, except:[:destroy] do
      resources :work_details, only:[:new, :create, :index]
      resources :contracts, only: [:new, :create]
      resource :notice_to_proceed, only: [:new, :create, :edit, :update]
      resources :payments, only: [:new, :create]
      resources :amount_revisions, only: [:index]
      resources :time_extensions, only: [:index]
      resources :line_items, only: [:index]
      resources :purchase_orders, only:[:index, :new, :create]
      resources :file_attachments, only:[:show, :new, :create, :edit, :update]
    end
    resources :accomplishment_images, only:[:show]
    resources :contracts, only:[:edit, :update, :show] do
      resources :payments, only: [:new, :create], module: :contracts
    end
    resources :work_details, only:[:index, :show, :edit, :update] do
      resources :work_accomplishments, only: [:new, :create]
      resources :amount_revisions, only: [:new, :create]
      resources :time_extensions, only: [:new, :create]
    end
    resources :payments, only:[:index]
    resources :contractors, except: [:destroy] do
      resources :contracts, only: [:show]
    end
  end

  resources :accounts

  get 'settings/index'
  get 'reports/contract_summary_report', as: 'contract_summary_report'
  get 'reports/index', as: 'reports'

    get 'expenses/filtered_data' => 'expenses#filtered_data'
  get 'accounts/income_statement' => 'accounts#income_statement'
  resources :payroll, only:[:index, :show]

  resources :employees do
    resources :cash_advances, :module => :employees
    resources :worked_days, :module => :employees
    resources :overtimes, only:[:new, :create], :module => :employees
    resources :educational_attainments, module: :employee_details
    resources :salaries, module: :employees
  end

  resources :users


  get 'supplies/inventories' => "supplies/inventories#index"
  get 'supplies/reports' => "supplies/reports#index"

  resources :contractors do
    resources :line_items, only: [:index], module: :contractors
  end


  namespace :accounts do

    resources :liabilities
    resources :equities
    resources :revenue
    resources :assets
  end

# resources :work_details do
#   resources :work_accomplishments, module: :projects
#   resources :issued_inventories, module: :projects
#   resources :purchase_orders, module: :work_details
#   resources :employments, module: :work_details
#   resources :equipment_maintenances, module: :work_details
#   resources :equipment_costs, module: :work_details
#   resources :equipment_fuel_costs, only:[:new, :create], module: :work_details
#   resources :time_extensions,     only:[:new, :create], module: :work_details
#   resources :amount_revisions,   only:[:new, :create], module: :work_details
# end
#
# resources :joint_ventures, controller: 'projects', type: 'JointVenture'
#
#   resources :projects do
#     resources :equipment_costs, module: :projects
#     resources :add_workers, module: :projects
#     resources :attachment_files, module: :projects
#     resources :assign_project_engineers, module: :projects
#     resources :activities, only:[:index], module: :projects
#     resources :work_details, module: :projects
#     resources :invoices, only:[:new, :create], module: :projects
#     resources :employments, module: :projects
#     resources :employees
#     resources :collections
#       match :overview, via: [:get], on: :collection
#       match :payroll, via: [:get], on: :member
#     resource :notice_to_proceed, module: :project_details
#     resources :remarks
#     resources :expenses,         module: :projects
#     resources :line_items, only: [:index], module: :projects
#   end
#
#   resources :contracts do
#     resources :contract_amount_revisions
#   end





  resources :fund_transfers

  resources :equipment do
    resources :fuel_expenses, module: :equipment
    resources :equipment_schedules, module: :equipment
    resources :equipment_statuses, module: :equipment
  end

  resources :equipment_statuses, only: [:edit, :update]
  resources :supplies, only: [:index]


  resources :orders, module: :supplies

  namespace :supplies do
    resources :line_items
    resources :inventories do
      resources :stocks, only: [:new, :create]
    end
    resources :carts
    resources :equipment
  end



end
