class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include Pundit
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  # rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found


  def after_sign_in_path_for(current_user)
    if current_user.is_a?(User) && current_user.supply_officer?
      supplies_url
    elsif current_user.is_a?(User) && current_user.project_engineer?
      monitoring_index_url
    elsif current_user.is_a?(User) && current_user.accounting_officer?
      accounting_index_url
    elsif current_user.is_a?(User) && current_user.monitoring_officer?
      monitoring_index_url
    elsif current_user.is_a?(User) && current_user.system_administrator?
      accounting_index_url
    end
  end

  # def record_not_found
  #   redirect_to after_sign_in_path_for(current_user), alert: "We're sorry but the page you were looking for could not be found."
  # end

  private
  def permission_denied
    redirect_to after_sign_in_path_for(current_user), alert: "We're sorry but you are not allowed to access this page or feature."
    return
  end
  def current_cart
    Supplies::Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Supplies::Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
