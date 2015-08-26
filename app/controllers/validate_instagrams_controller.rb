require 'open-uri'

class ValidateInstagramsController < ApplicationController
  before_action :set_validate_instagram, only: [:show, :edit, :update, :destroy]

  # GET /validate_instagrams
  # GET /validate_instagrams.json
  def index
    display_balance()
    @validate_instagrams = ValidateInstagram.all
  end

  # GET /validate_instagrams/1
  # GET /validate_instagrams/1.json
  def show
      @validate_instagram = ValidateInstagram.find(params[:id])
  end

  # GET /validate_instagrams/new
  def new
    @validate_instagram = ValidateInstagram.new
  end




def get_instagram()
  id = params[:id] #this is the id of the product, to create a new one
  @before_count = ValidateInstagram.find_by_id(id)

#Get transaction details
  @user_id = @before_count.uid #ID of user who made attempt to get credits (recipient)
  @product_id = @before_count.product_id
  @current_product = Product.find_by_id(@product_id)
  instagram_id = @current_product.provider_id
  product_id = @current_product.id
  username = @current_product.pretty_url

  @current_price = @current_product.price
  @current_product_sender = @current_product.owner_uid

  @transaction = Transaction.new( :sender_uid => @current_product_sender, :recipient_uid =>@user_id, :payment_amount => @current_price, :provider_type => "instagram", :product_id => @product_id)
  @transaction.save

  new_url = "https://api.instagram.com/v1/users/#{instagram_id}/?access_token=1572822298.fb37920.1653cb1e540b441984d58ef5ce177661"

  get_url = Nokogiri::HTML(open(new_url));

  current_follower_count =  JSON.parse(get_url)['data']['counts']['followed_by']


  if @before_count.before < current_follower_count
    @transaction = Transaction.new( :sender_uid => @current_product_sender, :recipient_uid =>@user_id, :payment_amount => @current_price, :provider_type => "instagram", :product_id => @product_id)
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
@validate_instagram = @before_count

@before_count.save
respond_to do |format|
  if @before_count.save
    format.html { redirect_to @before_count, notice: 'Validate instagram was successfully created.' }
    format.json { render :show, status: :created, location: @before_count }
  else
    format.html { render :new }
    format.json { render json: @before_count.errors, status: :unprocessable_entity }
  end
end
end

def set_instagram()
  errors = ''
  id = params[:id] #this is the id of the product, to create a new one
  product = Product.find_by_id(id)
  instagram_id = product.provider_id
  product_id = product.id
  new_url = "https://api.instagram.com/v1/users/#{instagram_id}/?access_token=1572822298.fb37920.1653cb1e540b441984d58ef5ce177661"
  username = product.pretty_url
  get_url = Nokogiri::HTML(open(new_url));





  current_follower_count =  JSON.parse(get_url)['data']['counts']['followed_by']

@validate_instagram = ValidateInstagram.new({:uid => User.find(current_user).id,:before => current_follower_count, :username => username,:product_id => product_id})
respond_to do |format|
  if @validate_instagram.save
    format.html { redirect_to @validate_instagram, notice: 'Validate instagram was successfully created.' }
    format.json { render :show, status: :created, location: @validate_instagram }
  else
    format.html { render :new }
    format.json { render json: @validate_instagram.errors, status: :unprocessable_entity }
  end
end
end

  # GET /validate_instagrams/1/edit
  def edit
  end

  # POST /validate_instagrams
  # POST /validate_instagrams.json
  def create
    @validate_instagram = ValidateInstagram.new(validate_instagram_params)
    abort(@validate_instagram.inspect)
    @validate_instagram.before = get_likes(params[:id])
    respond_to do |format|
      if @validate_instagram.save
        format.html { redirect_to @validate_instagram, notice: 'Validate instagram was successfully created.' }
        format.json { render :show, status: :created, location: @validate_instagram }
      else
        format.html { render :new }
        format.json { render json: @validate_instagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /validate_instagrams/1
  # PATCH/PUT /validate_instagrams/1.json
  def update
    respond_to do |format|
      if @validate_instagram.update(validate_instagram_params)
        format.html { redirect_to @validate_instagram, notice: 'Validate instagram was successfully updated.' }
        format.json { render :show, status: :ok, location: @validate_instagram }
      else
        format.html { render :edit }
        format.json { render json: @validate_instagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /validate_instagrams/1
  # DELETE /validate_instagrams/1.json
  def destroy
    @validate_instagram.destroy
    respond_to do |format|
      format.html { redirect_to validate_instagrams_url, notice: 'Validate instagram was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_validate_instagram
      new_url = params[:id]
      new_url = new_url.gsub('PrD','.')

      @validate_instagram = ValidateInstagram.find_by_url(new_url)
      new_url = "https://"+ new_url+"/"
      new_url = "https://www.facebook.com/thenextweb?fref=ts"
      instagram = Nokogiri::HTML(open(new_url))
      likes = instagram.at('meta[name="description"]')['content']
      likes_array = likes.split(' ')
      likes_count = likes_array[likes_array.index("likes")-1].tr(',', '').to_i
      #image = open(new_url).read

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def validate_instagram_params
      params.require(:validate_instagram).permit(:uid, :time, :before, :url, :url_id, :product_id)
    end
end
