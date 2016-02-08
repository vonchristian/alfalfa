class ApplicationController < ActionController::Base
    include PublicActivity::StoreController
     include Pundit
    before_action :authenticate_user!
     protect_from_forgery with: :exception
     rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  private
        def permission_denied
          redirect_to root_path, alert: 'Access denied.'
        end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
end
