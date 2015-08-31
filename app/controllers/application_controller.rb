class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :authenticate_user!
  before_action :display_balance if(defined?current_user)

  def display_balance

     @Credits = Credit.find_by_uid(current_user.id)
    if(!@Credits.nil?)
      @Balance = @Credits.balance
    else
      @Add_User_Credit = Credit.new("uid"=>current_user.id,"balance"=> 0)
      @Add_User_Credit.save
      if @Add_User_Credit.save
        @Balance = Credit.find_by_uid(current_user.id).balance
      else
        @Balance = 0
      end
    end
  end
end
