class PlayController < ApplicationController
   def product

      #for header balance

      @products_liked_by_user = Transaction.where("recipient_uid = #{current_user.id} OR sender_uid = #{current_user.id}")

      count = 0
      @product_ids = []
      @products_liked_by_user.each do |x|
         unless(x.product_id.blank?)
            @product_ids[count] = x.product_id
            count += 1
         end
      end

      if(@product_ids == []) #ensure we are not checking an empty array, as that would yield an unexpected result
         @product_ids[0] = 0
      end
      if(params[:id].blank?)
         @product = Product.where.not("id IN (?) OR owner_uid = (?)", @product_ids, current_user.id).where("is_active = 1").order("price DESC").first
      else

         @product = Product.where.not("id IN (?) OR owner_uid = (?)", @product_ids, current_user.id).where("provider = (?) AND is_active = 1 ", params[:id]).order("price DESC").first
         # abort(params[:id].inspect)
         #  abort(@product_ids.inspect)
      end
   end

   def pull_new_product

      #for header balance

      @products_liked_by_user = Transaction.where("recipient_uid = #{current_user.id} OR sender_uid = #{current_user.id}")

      count = 0
      @product_ids = []

      @products_liked_by_user.each do |x|
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
         @product = Product.where.not("id IN (?) OR owner_uid = (?)", @product_ids, current_user.id).where("is_active = 1").order("price DESC").first

      else
         @product = Product.where.not("id IN (?) OR owner_uid = (?)", @product_ids, current_user.id).where("provider = (?) AND is_active = 1 ", params[:id]).order("price DESC").first

      end
      respond_to do |format|
         format.json { render json: @product }
      end
   end




   def index

   end


end
