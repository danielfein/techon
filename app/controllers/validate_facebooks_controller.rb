require 'open-uri'

class ValidateFacebooksController < ApplicationController
  before_action :set_validate_facebook, only: [:show, :edit, :update, :destroy]

  # GET /validate_facebooks
  # GET /validate_facebooks.json
  def index
    @validate_facebooks = ValidateFacebook.all
  end

  # GET /validate_facebooks/1
  # GET /validate_facebooks/1.json
  def show
      @validate_facebook = ValidateFacebook.find(params[:id])
  end

  # GET /validate_facebooks/new
  def new
    @validate_facebook = ValidateFacebook.new
  end




def get_likes()
  errors = ''

  id = params[:id].to_i #this is the id of the individual user's attempt
  @before_count = ValidateFacebook.find_by_id(id)


#Get transaction details
  @user_id = @before_count.uid #ID of user who made attempt to get credits (recipient)
  @product_id = @before_count.product_id

  @current_product = Product.find_by_id(@product_id)

  @current_price = @current_product.price
  @current_product_sender = @current_product.owner_uid
  #
  # @transaction = Transaction.new( :sender_uid => @current_product_sender, :recipient_uid =>@user_id, :payment_amount => @current_price, :provider_type => "facebook", :product_id => @product_id)
  # @transaction.save



#AFTER:

  url = @before_count.url;
  facebook = Nokogiri::HTML(open('https://graph.facebook.com/v2.4/?ids='+ url +'&fields=likes&access_token=CAAXoqRFHZA7gBADEidGMAmn8q9TLXWUq4RcQHLZAqRW7fj8GZBfek1u0lPvCDNThjYWOOKbZCO6mdzvCgZAZBcJrAwIjvgYAyas0xCGVKmIrX3rVEfzM0eZBX9DZBRvv7fcM4UevMwyzd2FiUbKaDLZBhImK7x21O0l2AAiJkEqs3sCJQTN6OMFmZAAe5EwuDGFyoZD'));
  current_likes_count = JSON.parse(facebook).values[0]['likes']

  if @before_count.before < current_likes_count
    @transaction = Transaction.new( :sender_uid => @current_product_sender, :recipient_uid =>@user_id, :payment_amount => @current_price, :provider_type => "facebook", :product_id => @product_id)
    @transaction.save
    if(Credit.find_by_uid(@user_id))
      @temp_credit = Credit.find_by_uid(@user_id)
      @temp_id = @temp_credit.id

      @temp_balance = @temp_credit.balance + @current_price
      @award_creds = Credit.update(@temp_id,"uid"=>@user_id, "balance"=> @temp_balance)
         @before_count.balance = @temp_balance

    else
        @award_credits = Credit.new("uid"=>@user_id, "balance"=> @current_price)
        @award_credits.save
              @before_count.balance = @current_price
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
@validate_facebook = @before_count

@before_count.save
respond_to do |format|
  if @before_count.save
    format.html { redirect_to @before_count, notice: 'Validate facebook was successfully created.' }
    format.json { render :show, status: :created, location: @before_count }
  else
    format.html { render :new }
    format.json { render json: @before_count.errors, status: :unprocessable_entity }
  end
end
end

def set_likes()
  errors = ''
  id = params[:id] #this is the id of the product, to create a new one
  product = Product.find_by_id(id)
  url = product.url
  product_id = product.id
  new_url = 'https://graph.facebook.com/v2.4/?ids='+ url +'&access_token=CAAXoqRFHZA7gBADEidGMAmn8q9TLXWUq4RcQHLZAqRW7fj8GZBfek1u0lPvCDNThjYWOOKbZCO6mdzvCgZAZBcJrAwIjvgYAyas0xCGVKmIrX3rVEfzM0eZBX9DZBRvv7fcM4UevMwyzd2FiUbKaDLZBhImK7x21O0l2AAiJkEqs3sCJQTN6OMFmZAAe5EwuDGFyoZD'
  # split = url.split('&',2)
  # split2 = split[0].to_s

  get_url = Nokogiri::HTML(open(new_url));


  new_url = JSON.parse(get_url)
  facebook_id = new_url.values[0]['id']
  new_url = 'https://graph.facebook.com/v2.4/?ids='+ facebook_id + '&fields=likes&access_token=CAAXoqRFHZA7gBADEidGMAmn8q9TLXWUq4RcQHLZAqRW7fj8GZBfek1u0lPvCDNThjYWOOKbZCO6mdzvCgZAZBcJrAwIjvgYAyas0xCGVKmIrX3rVEfzM0eZBX9DZBRvv7fcM4UevMwyzd2FiUbKaDLZBhImK7x21O0l2AAiJkEqs3sCJQTN6OMFmZAAe5EwuDGFyoZD'

  facebook = Nokogiri::HTML(open(new_url));

  current_likes_count = JSON.parse(facebook).values[0]['likes']

@validate_facebook = ValidateFacebook.new({:uid => User.find(current_user).id,:before => current_likes_count, :url => url,:product_id => product_id})
respond_to do |format|
  if @validate_facebook.save
    format.html { redirect_to @validate_facebook, notice: 'Validate facebook was successfully created.' }
    format.json { render :show, status: :created, location: @validate_facebook }
  else
    format.html { render :new }
    format.json { render json: @validate_facebook.errors, status: :unprocessable_entity }
  end
end
end

  # GET /validate_facebooks/1/edit
  def edit
  end

  # POST /validate_facebooks
  # POST /validate_facebooks.json
  def create
    @validate_facebook = ValidateFacebook.new(validate_facebook_params)
    abort(@validate_facebook.inspect)
    @validate_facebook.before = get_likes(params[:id])
    respond_to do |format|
      if @validate_facebook.save
        format.html { redirect_to @validate_facebook, notice: 'Validate facebook was successfully created.' }
        format.json { render :show, status: :created, location: @validate_facebook }
      else
        format.html { render :new }
        format.json { render json: @validate_facebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /validate_facebooks/1
  # PATCH/PUT /validate_facebooks/1.json
  def update
    respond_to do |format|
      if @validate_facebook.update(validate_facebook_params)
        format.html { redirect_to @validate_facebook, notice: 'Validate facebook was successfully updated.' }
        format.json { render :show, status: :ok, location: @validate_facebook }
      else
        format.html { render :edit }
        format.json { render json: @validate_facebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /validate_facebooks/1
  # DELETE /validate_facebooks/1.json
  def destroy
    @validate_facebook.destroy
    respond_to do |format|
      format.html { redirect_to validate_facebooks_url, notice: 'Validate facebook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_validate_facebook
      new_url = params[:id]
      new_url = new_url.gsub('PrD','.')

      @validate_facebook = ValidateFacebook.find_by_url(new_url)
      new_url = "https://"+ new_url+"/"
      new_url = "https://www.facebook.com/thenextweb?fref=ts"
      facebook = Nokogiri::HTML(open(new_url))
      likes = facebook.at('meta[name="description"]')['content']
      likes_array = likes.split(' ')
      likes_count = likes_array[likes_array.index("likes")-1].tr(',', '').to_i
      #image = open(new_url).read

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def validate_facebook_params
      params.require(:validate_facebook).permit(:uid, :time, :before, :url, :url_id, :product_id)
    end
end
