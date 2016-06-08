
Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users", sessions: "users/sessions" }

  unauthenticated :user do
    root :to => 'monitoring/projects#index', :constraints => lambda { |request| request.env['warden'].user.nil? }, as: :unauthenticated_root
  end

  root :to => 'monitoring/projects#index', :constraints => lambda { |request| request.env['warden'].user.role == 'monitoring_officer' if request.env['warden'].user }, as: :monitoring_root
  root :to => 'monitoring/projects#index', :constraints => lambda { |request| request.env['warden'].user.role == 'project_engineer' if request.env['warden'].user }, as: :projects_root
  root :to => 'accounting#index', :constraints => lambda { |request| request.env['warden'].user.role == 'accounting_officer' if request.env['warden'].user }, as: :accounting_root
  root :to => 'supplies#index', :constraints => lambda { |request| request.env['warden'].user.role == 'supply_officer' if request.env['warden'].user }, as: :supply_root

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
    resources :entries, except:[:destroy] do
      match "/scope_to_date" => "entries#scope_to_date", as: :scope_to_date, via: [:get], on: :collection
    end
    resources :cash_flow, only: [:index]
    resources :accounts
    resources :liabilities
    resources :equities
    resources :revenue
    resources :assets
    resources :cash_advances, only: [:show] do
      resources :payments, only: [:new, :create], module: :cash_advances
        match "/scope_to_date" => "transactions/cash_advances#scope_to_date", as: :scope_to_date, via: [:get], on: :collection
    end
  end
  resources :projects, only: [:index] do
    resources :payments, only: [:index], module: :project_payments
  end
  resources :monitoring, only:[:index]
  namespace :monitoring do
    resources :equipment, only: [:index, :show]
    resources :file_attachments, only: [:show]
    resources :projects, except:[:destroy] do
      resources :work_details, only:[:new, :create, :index]
      resources :time_extensions, only: [:new, :create]
      resources :contracts, only: [:new, :create]
      resource :notice_to_proceed, only: [:new, :create, :edit, :update]
      resources :payments, only: [:new, :create, :index]
      resources :amount_revisions, only: [:index]
      resources :time_extensions, only: [:index]
      resources :line_items, only: [:index]
      resources :purchase_orders, only:[:index, :new, :create]
      resources :labor_costs, only:[:index, :new, :create]
      resources :file_attachments
    end
    resources :accomplishment_images, only:[:show]
    resources :contracts, only:[:edit, :update, :show] do
      resources :payments, only: [:new, :create], module: :contracts
    end
    resources :work_details, only:[:index, :show, :edit, :update] do
      resources :work_accomplishments, only: [:new, :create, :index]
      resources :amount_revisions, only: [:new, :create]
    end
    resources :work_accomplishments, only:[:edit, :update]
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
    resources :other_deductions, only: [:new, :create, :edit, :update], module: :employees
  end
  resources :other_deductions, only: [:edit, :update], module: :employees

  resources :users


  get 'supplies/inventories' => "supplies/inventories#index"
  get 'supplies/reports' => "supplies/reports#index"

  resources :contractors do
    resources :line_items, only: [:index], module: :contractors
  end


  resources :fund_transfers

  resources :equipment do
    resources :fuel_expenses, module: :equipment
    resources :equipment_schedules, module: :equipment
    resources :equipment_statuses, module: :equipment
  end

  resources :equipment_statuses, only: [:edit, :update]
  resources :supplies, only: [:index]


  resources :orders, module: :supplies do
    match "/projects" => "orders#projects", as: :projects, via: [:get], on: :collection
    match "/contractors" => "orders#contractors", as: :contractors, via: [:get], on: :collection
    match "/customers" => "orders#customers", as: :customers, via: [:get], on: :collection

  end

  namespace :supplies do
    resources :contractors, only:[:show]
    resources :line_items do
      resources :payments, only:[:new, :create]
    end
    resources :inventories do
      resources :stocks, only: [:new, :create]
      match "/discontinue" => "inventories#discontinue", as: :discontinue, via: [:get, :post]
      match "/continue" => "inventories#continue", as: :continue, via: [:get, :post]
      match "/available" => "inventories#available", as: :available, via: [:get], on: :collection
      match "/out_of_stock" => "inventories#out_of_stock", as: :out_of_stock, via: [:get], on: :collection
      match "/discontinued" => "inventories#discontinued", as: :discontinued, via: [:get], on: :collection

    end
    resources :carts
    resources :equipment do
      resources :items, except:[:destroy]
      match "/active" => "equipment#active", as: :active, via: [:get], on: :collection
      match "/inactive" => "equipment#inactive", as: :inactive, via: [:get], on: :collection
    end

    resources :stocks, only: [:edit, :update]
  end



end
