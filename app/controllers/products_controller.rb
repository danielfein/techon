require 'open-uri'
require 'twitter'
require 'twitter_helper'
class ProductsController < ApplicationController
   before_action :set_product, only: [:show, :edit, :update, :destroy]

   # GET /products
   # GET /products.json
   def index

      @products = Product.all

   end



   def hide
      product_id = params[:id]
      @product = Product.find(product_id)
      if(current_user.id == @product.owner_uid)
         @product.is_active = 0
      end
      @product.save
      redirect_to dashboard_path
   end
   def unhide
      product_id = params[:id]
      @product = Product.find(product_id)
      if(current_user.id == @product.owner_uid)
         @product.is_active = 1
      end
      @product.save
      redirect_to dashboard_path
   end





   # GET /products/1
   # GET /products/1.json
   def show

      @pages_liked_by_user = Transaction.where("recipient_uid = #{current_user.id}").where("product_id = #{params[:id]}")
      if(@pages_liked_by_user == [])

         @show = true
      else
         @show = false
      end
   end

   # GET /products/new
   def new
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

      url = product_params[:url]

      if(new_params[:provider] == "facebook")
         @products = Product.all
         @products.each do |x|
            if(x.url == url)
               @product = Product.new()
               @product.errors.add(:url, "This link already exists in our database")
               respond_to do |format|
                  format.html { render :new and return }
                  format.json { render json: @product.errors, status: :unprocessable_entity }
               end
            end
         end
         begin
            new_url = "https://graph.facebook.com/v2.4/?ids=#{url}&fields=name,likes,picture,cover&access_token=CAAXoqRFHZA7gBADEidGMAmn8q9TLXWUq4RcQHLZAqRW7fj8GZBfek1u0lPvCDNThjYWOOKbZCO6mdzvCgZAZBcJrAwIjvgYAyas0xCGVKmIrX3rVEfzM0eZBX9DZBRvv7fcM4UevMwyzd2FiUbKaDLZBhImK7x21O0l2AAiJkEqs3sCJQTN6OMFmZAAe5EwuDGFyoZD"
            facebook = JSON.parse(Nokogiri::HTML(open(new_url)))
            new_params[:provider_id] = facebook[url]['id']
            new_params[:name] = facebook[url]['name']
            new_params[:cover_photo] = facebook[url]['cover']['source']
            new_params[:profile_pic] = facebook[url]['picture']['data']['url']
            new_params["owner_uid"] = current_user.id
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
            url = url.gsub("http://instagram.com/",'')
               url = url.gsub("https://instagram.com/",'')
            instagram = Nokogiri::HTML(open("https://api.instagram.com/v1/users/search?q=#{url}&access_token=1572822298.fb37920.1653cb1e540b441984d58ef5ce177661"))
            insta_data =  JSON.parse(instagram)['data'].first
            # abort(insta_data.inspect)
            new_params[:provider_id] = insta_data['id']
                        new_params[:owner_uid] = current_user.id
            new_params[:name] = insta_data['full_name']
            new_params[:url] = "https://instagram.com/" + insta_data['username']
            new_params[:pretty_url] = "https://instagram.com/" + insta_data['username']
            new_params[:profile_pic] =insta_data['profile_picture']
                     new_params[:cover_photo] =insta_data['profile_picture']
            # abort(instagram['data']['profile_picture'].inspect)
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
               @product.errors.add(:url, "Invalid URL, please ensure it is a proper Instagram Page URL")
               format.html { render :new}
               format.json { render json: @product.errors, status: :unprocessable_entity }
            end
         end
      elsif(new_params[:provider] == "twitter")

         begin
            # twitter = Nokogiri::HTML(open("https://api.twitter.com/1.1/followers/ids.json?cursor=-1&screen_name=fcbare&count=5000&access_token=1572822298.fb37920.1653cb1e540b441984d58ef5ce177661"))
            username = new_params[:url]
            current_user_a = TwitterHelper.new('CURRENT_USER_TOKEN_ID', 'CURRENT_USER_TOKEN_SECRET').find_twitter_user( username )
            @match = Product.where("provider_id = #{current_user_a.id}").first
            if(@match.nil?)
               username = username.gsub('https://twitter.com/','')
               username = username.gsub('http://twitter.com/','')
               new_params["pretty_url"], = "https://twitter.com/" + username
               new_params["url"] = "https://twitter.com/" + username
               new_params["owner_uid"] = current_user.id
               new_params[:name] = current_user_a.attrs[:name]
               new_params[:profile_pic] = current_user_a.attrs[:profile_image_url_https].gsub('_normal','')
               new_params[:cover_photo] = current_user_a.attrs[:profile_background_image_url_https]
               new_params[:provider_id] = current_user_a.id;
               puts 'getting here 1'
               @product = Product.new(new_params)
               respond_to do |format|
                  if @product.save
                     puts 'getting here 2'
                     format.html { redirect_to @product, notice: 'Product was successfully created.' }
                     format.json { render :show, status: :created, location: @product }
                  else
                     puts 'getting here 5'
                     format.html { render :new }
                     format.json { render json: @product.errors, status: :unprocessable_entity }
                  end
               end
            else
               respond_to do |format|
                  puts 'getting here 4'
                  @product = Product.new(new_params)
                  @product.errors.add(:url, "This Twitter user already exists!")
                  format.html { render :new}
                  format.json { render json: @product.errors, status: :unprocessable_entity }

               end
            end
            rescue
               puts 'getting here 3'
               respond_to do |format|
                  puts 'getting here 4'
                  @product = Product.new(new_params)
                  @product.errors.add(:url, "Invalid URL, please ensure it is a proper Twitter Page URL")
                  format.html { render :new}
                  format.json { render json: @product.errors, status: :unprocessable_entity }
               end
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
