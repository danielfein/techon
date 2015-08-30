class ChargesController < ApplicationController
  def new
    
  end

  def index
    
  end

  def make_charge()
    # If from Stripe. Any amount
    # Amount in cents
    # @Payola::Sale

    @user = User.find(current_user)
    @user_id = @user.id
    @user_email = @user.email

    @sale = Payola::Sale.find_by(guid: params[:id])
    @product_id = @sale.product_id
    @amount = @sale.amount

    @add_payment = Transaction.new( :sender_uid => -1, :recipient_uid => @user_id, :payment_amount => @amount, :provider_type => "Stripe", :product_id => @product_id)
    @add_payment.save

    @product_award_paid_for = CreditPlan.find(@product_id)
    @award_credits = @product_award_paid_for.award_credits.to_i
    if(Credit.find_by_uid(@user_id))
      @temp_credit = Credit.find_by_uid(@user_id)
      @temp_id = @temp_credit.id
      @temp_balance = @temp_credit.balance + @award_credits
      @award_creds = Credit.update(@temp_id,"uid"=>@user_id,"balance"=> @temp_balance)
    else
      @award_credits = Credit.new("uid"=>@user_id,"balance"=> @award_credits)
      @award_credits.save
    end
    redirect_to charges_path
  end

  def create
    # Amount in cents

    @user = User.find(current_user)
    @user_id = @user.id
    @user_email = @user.email


    if charge['paid'] == true
      #add to transactions with sender as -1 admin
      @add_payment = Transaction.new( :sender_uid => -1, :recipient_uid => @user_id, :payment_amount => @amount, :provider_type => "Stripe", :product_id => @product_type)
      @add_payment.save
      if(Credit.find_by_uid(@user_id))
        @temp_credit = Credit.find_by_uid(@user_id)
        @temp_id = @temp_credit.id
        @temp_balance = @temp_credit.balance + @current_price
        @award_creds = Credit.update(@temp_id,"uid"=>@user_id,"balance"=> @temp_balance)
      else
        @award_credits = Credit.new("uid"=>@user_id,"balance"=> @current_price)
        @award_credits.save
      end
    end




  end
end
