class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    before_action :authenticate_user!


    def get_item
    end
    
    def update_user_balance
    end

    def award_points
    end

    def deduct_from_owner
    end
end
