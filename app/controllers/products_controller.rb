require 'open-uri'
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    display_balance()
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
        display_balance()

        @pages_liked_by_user = Transaction.where("recipient_uid = #{current_user.id}").where("product_id = #{params[:id]}")
if(@pages_liked_by_user == [])

 @show = true
 elsif
   @show = false
 end
  end

  # GET /products/new
  def new
    display_balance()
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    new_params = product_params.clone

    new_params[:pretty_url] = product_params[:url]
    new_params[:owner_uid] = User.find(current_user).id
    url = product_params[:url]

    if(new_params[:provider] == "facebook")
      # abort("https://graph.facebook.com/v2.4/?ids=#{url}&fields=likes&access_token=CAAXoqRFHZA7gBADEidGMAmn8q9TLXWUq4RcQHLZAqRW7fj8GZBfek1u0lPvCDNThjYWOOKbZCO6mdzvCgZAZBcJrAwIjvgYAyas0xCGVKmIrX3rVEfzM0eZBX9DZBRvv7fcM4UevMwyzd2FiUbKaDLZBhImK7x21O0l2AAiJkEqs3sCJQTN6OMFmZAAe5EwuDGFyoZD".inspect)

      begin
        facebook = Nokogiri::HTML(open("https://graph.facebook.com/v2.4/?ids=#{url}&fields=likes&access_token=CAAXoqRFHZA7gBADEidGMAmn8q9TLXWUq4RcQHLZAqRW7fj8GZBfek1u0lPvCDNThjYWOOKbZCO6mdzvCgZAZBcJrAwIjvgYAyas0xCGVKmIrX3rVEfzM0eZBX9DZBRvv7fcM4UevMwyzd2FiUbKaDLZBhImK7x21O0l2AAiJkEqs3sCJQTN6OMFmZAAe5EwuDGFyoZD"))

        new_params[:provider_id] = JSON.parse(facebook)['id']

        @product = Product.new(new_params)

        respond_to do |format|
          if @product.save

            format.html { redirect_to @product, notice: 'Product was successfully created.' }
            format.json { render :show, status: :created, location: @product }
          else
            format.html { render :new }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      rescue

        respond_to do |format|
          @product = Product.new(new_params)
          @product.errors.add(:url, "Invalid URL, please ensure it is a proper Facebook Page URL")
          format.html { render :new}
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end


      end
    elsif(new_params[:provider] == "instagram")

      begin


        instagram = Nokogiri::HTML(open("https://api.instagram.com/v1/users/search?q=#{url}&access_token=1572822298.fb37920.1653cb1e540b441984d58ef5ce177661"))
      new_params[:provider_id] = JSON.parse(instagram)['data'].first['id']

        @product = Product.new(new_params)

        respond_to do |format|
          if @product.save

            format.html { redirect_to @product, notice: 'Product was successfully created.' }
            format.json { render :show, status: :created, location: @product }
          else
            format.html { render :new }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      rescue

        respond_to do |format|
          @product = Product.new(new_params)
          @product.errors.add(:url, "Invalid URL, please ensure it is a proper Facebook Page URL")
          format.html { render :new}
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end


      end

    end

  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    new_params = product_params.clone

    new_params[:pretty_url] = product_params[:url]
    new_params[:owner_uid] = User.find(current_user).id


    respond_to do |format|
      if @product.update(new_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        # format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :price, :url, :description, :provider)
  end
end
