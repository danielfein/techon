require 'open-uri'
require 'twitter'
require 'twitter_helper'
class ValidateTwittersController < ApplicationController
  before_action :set_validate_twitter, only: [:show, :edit, :update, :destroy]

  # GET /validate_twitters
  # GET /validate_twitters.json
  def index
    display_balance()
    # @test = TwitterHelper.new('CURRENT_USER_TOKEN_ID', 'CURRENT_USER_TOKEN_SECRET').search_for( 'trump' )

    @validate_twitters = ValidateTwitter.all
  end

  # GET /validate_twitters/1
  # GET /validate_twitters/1.json
  def show
    @validate_twitter = ValidateTwitter.find(params[:id])
  end

  # GET /validate_twitters/new
  def new
    @validate_twitter = ValidateTwitter.new
  end




  def get_twitter()
    id = params[:id] #this is the id of the product, to create a new one
    @before_count = ValidateTwitter.find_by_id(id)

    #Get transaction details
    @user_id = @before_count.uid #ID of user who made attempt to get credits (recipient)
    @product_id = @before_count.product_id
    @current_product = Product.find_by_id(@product_id)
    product_id = @current_product.id
    username = @current_product.pretty_url
    current_follower_count = TwitterHelper.new('CURRENT_USER_TOKEN_ID', 'CURRENT_USER_TOKEN_SECRET').find_twitter_user( username ).followers_count

    @current_price = @current_product.price
    @current_product_sender = @current_product.owner_uid

    if @before_count.before < current_follower_count
      @transaction = Transaction.new( :sender_uid => @current_product_sender, :recipient_uid =>@user_id, :payment_amount => @current_price, :provider_type => "twitter", :product_id => @product_id)
      @transaction.save
      if(Credit.find_by_uid(@user_id))
        @temp_credit = Credit.find_by_uid(@user_id)
        @temp_id = @temp_credit.id
        @temp_balance = @temp_credit.balance + @current_price
        @award_creds = Credit.update(@temp_id,"uid"=>@user_id,"balance"=> @temp_balance)
      else
        @award_credits = Credit.new("uid"=>@user_id,"balance"=> @current_price)
        @award_credits.save
      end

      if(Credit.find_by_uid(@current_product_sender))
        @temp_credit = Credit.find_by_uid(@current_product_sender)
        @temp_id = @temp_credit.id
        @temp_balance = @temp_credit.balance - @current_price
        @deduct_creds = Credit.update(@temp_id,"uid"=>@current_product_sender,"balance"=> @temp_balance)
      else
        @deduct_creds = Credit.new("uid"=>@current_product_sender,"balance"=> @current_price)
        @deduct_creds.save
      end

      @before_count.awarded = 1;
    else
      @before_count.awarded = 0;
    end

    @validate_twitter = @before_count
    @before_count.save
    respond_to do |format|
      if @before_count.save
        format.html { redirect_to @before_count, notice: 'Validate twitter was successfully created.' }
        format.json { render :show, status: :created, location: @before_count }
      else
        format.html { render :new }
        format.json { render json: @before_count.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_twitter()
    errors = ''
    id = params[:id] #this is the id of the product, to create a new one
    product = Product.find_by_id(id)
    twitter_id = product.provider_id
    product_id = product.id
    username = product.pretty_url
    current_follower_count = TwitterHelper.new('CURRENT_USER_TOKEN_ID', 'CURRENT_USER_TOKEN_SECRET').find_twitter_user( username ).followers_count

    @validate_twitter = ValidateTwitter.new({:uid => User.find(current_user).id,:before => current_follower_count, :username => username,:product_id => product_id})
    respond_to do |format|
      if @validate_twitter.save
        format.html { redirect_to @validate_twitter, notice: 'Validate twitter was successfully created.' }
        format.json { render :show, status: :created, location: @validate_twitter }
      else
        format.html { render :new }
        format.json { render json: @validate_twitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /validate_twitters/1/edit
  def edit
  end

  # POST /validate_twitters
  # POST /validate_twitters.json
  def create
    @validate_twitter = ValidateTwitter.new(validate_twitter_params)
    abort(@validate_twitter.inspect)
    @validate_twitter.before = get_likes(params[:id])
    respond_to do |format|
      if @validate_twitter.save
        format.html { redirect_to @validate_twitter, notice: 'Validate twitter was successfully created.' }
        format.json { render :show, status: :created, location: @validate_twitter }
      else
        format.html { render :new }
        format.json { render json: @validate_twitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /validate_twitters/1
  # PATCH/PUT /validate_twitters/1.json
  def update
    respond_to do |format|
      if @validate_twitter.update(validate_twitter_params)
        format.html { redirect_to @validate_twitter, notice: 'Validate twitter was successfully updated.' }
        format.json { render :show, status: :ok, location: @validate_twitter }
      else
        format.html { render :edit }
        format.json { render json: @validate_twitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /validate_twitters/1
  # DELETE /validate_twitters/1.json
  def destroy
    @validate_twitter.destroy
    respond_to do |format|
      format.html { redirect_to validate_twitters_url, notice: 'Validate twitter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_validate_twitter
    new_url = params[:id]
    new_url = new_url.gsub('PrD','.')
    @validate_twitter = ValidateTwitter.find_by_url(new_url)
    new_url = "https://"+ new_url+"/"
    new_url = "https://www.facebook.com/thenextweb?fref=ts"
    twitter = Nokogiri::HTML(open(new_url))
    likes = twitter.at('meta[name="description"]')['content']
    likes_array = likes.split(' ')
    likes_count = likes_array[likes_array.index("likes")-1].tr(',', '').to_i
    #image = open(new_url).read
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def validate_twitter_params
    params.require(:validate_twitter).permit(:uid, :time, :before, :url, :url_id, :product_id)
  end
end
