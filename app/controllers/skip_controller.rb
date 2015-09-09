
class SkipController < ApplicationController
   before_action :set_product, only: [:show, :edit, :update, :destroy]

   # GET /products
   # GET /products.json
   def index #add skip here
      product = {}
      product["product_id"] = params[:id]
         product["uid"] = current_user.id
      @new_skip = Skip.new(product)
      respond_to do |format|
         if @new_skip.save

            format.html { redirect_to @new_skip, notice: 'Product was successfully created.' }
            format.json { render :show }
         else
            format.html { render :new }
            format.json { render json: @new_skip.errors, status: :unprocessable_entity }
         end
      end
   end

end
