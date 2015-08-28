class PlayController < ApplicationController
  def product

    display_balance() #for header balance

      @products_liked_by_user = Transaction.where("recipient_uid = #{current_user.id} OR sender_uid = #{current_user.id}")

      count = 0
      @product_ids = []

      @products_liked_by_user.each do |x|
        unless(x.product_id.nil?)
            @product_ids[count] = x.product_id

              count += 1
        end

      end

      if(@product_ids == []) #ensure we are not checking an empty array, as that would yield an unexpected result
        @product_ids[0] = 0
      end
      # @product = Product.where("price < #{@Balance}").where.not("id IN (?)", @product_ids).first
    if(params[:id].nil?)
      @product = Product.where.not("id IN (?)", @product_ids).first

    else
      @product = Product.where.not("id IN (?)", @product_ids).where("provider = (?)", params[:id]).first
    
    end
  end

  def index
#         display_balance() #for header balance
#
# abort(current_user.id.inspect)
#           @products_liked_by_user = Transaction.where("recipient_uid = #{current_user.id}").where("sender_uid = #{current_user.id}")
#
#           count = 0
#           @product_ids = []
#           @products_liked_by_user.each do |x|
#             unless x.product_id.nil?
#                 @product_ids[count] = x.product_id
#                   count += 1
#             end
#
#           end
#           if(@product_ids == []) #ensure we are not checking an empty array, as that would yield an unexpected result
#             @product_ids[0] = 0
#           end
#           # @product = Product.where("price < #{@Balance}").where.not("id IN (?)", @product_ids).first
#           abort(Product.where.not("id IN (?)", @product_ids).where("provider = (?)", params[:id]).inspect)
#           @product = Product.where.not("id IN (?)", @product_ids).where("provider = (?)", params[:id]).first
#

  end


end
