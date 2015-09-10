class PlayController < ApplicationController





   def product
      @products_all = Product.where("owner_uid = #{current_user.id}")
      #for header balance

      @products_liked_by_user = Transaction.where("recipient_uid = #{current_user.id} OR sender_uid = #{current_user.id}")
      product_skips = Skip.where("uid = #{current_user.id}")
      count = 0
      @product_ids = []
      @products_liked_by_user.each do |x|
         unless(x.product_id.blank?)
            @product_ids[count] = x.product_id
            count += 1
         end
      end
      product_skips.each do |x|
         unless(x.product_id.blank?)
            @product_ids[count] = x.product_id
            count += 1
         end
      end
      @current_user_identity = Identity.where("user_id = #{current_user.id} AND provider = 'facebook'").first()


      # PRICE NEEDS TO BE > BALANCE of OWNER
      #
      #
      #


      if(@product_ids == []) #ensure we are not checking an empty array, as that would yield an unexpected result
         @product_ids[0] = 0
      end
      if(params[:id].blank?)
         @products = Product.where.not("id IN (?) OR owner_uid = (?)", @product_ids, current_user.id).where("is_active = 1").order("price DESC")
         get_affordable_product()
      else

         @products = Product.where.not("id IN (?) OR owner_uid = (?)", @product_ids, current_user.id).where("provider = (?) AND is_active = 1 ", params[:id]).order("price DESC")
         get_affordable_product()
      end
   end


   def pull_new_product

      #for header balance

      @products_liked_by_user = Transaction.where("recipient_uid = #{current_user.id} OR sender_uid = #{current_user.id}")

      product_skips = Skip.where("uid = #{current_user.id}")
      count = 0
      @product_ids = []

      @products_liked_by_user.each do |x|
         unless(x.product_id.blank?)
            @product_ids[count] = x.product_id

            count += 1
         end

      end
      product_skips.each do |x|
         unless(x.product_id.blank?)
            @product_ids[count] = x.product_id
            count += 1
         end
      end
      if(@product_ids == []) #ensure we are not checking an empty array, as that would yield an unexpected result
         @product_ids[0] = 0
      end
      # @product = Product.where("price < #{@Balance}").where.not("id IN (?)", @product_ids).first
      if(params[:id] == "null")
         @products = Product.where.not("id IN (?) OR owner_uid = (?)", @product_ids, current_user.id).where("is_active = 1").order("price DESC")
       get_affordable_product()
      else
         @products = Product.where.not("id IN (?) OR owner_uid = (?)", @product_ids, current_user.id).where("provider = (?) AND is_active = 1 ", params[:id]).order("price DESC")
       get_affordable_product()
      end

      respond_to do |format|
         format.json { render json: @product }
      end
   end


   def get_affordable_product
      temp_index = 0;
      continue = true
      while(continue)
            begin
         @temp_product = @products[temp_index]

            @balance_of_user = Credit.find_by_uid(@temp_product.owner_uid)
            if @balance_of_user.balance >= @temp_product.price
               @product = @temp_product
               continue = false
            end
         rescue
            continue = false
         end
         temp_index += 1
      end
   end

   def index

   end


end
