class DashboardController < ApplicationController

#Homepage
def index

   @products_all = Product.where("owner_uid = #{current_user.id}")

   # abort(@product.inspect)

end

def hide
   product_id = params[:id]
   @products_all = Product.find(product_id)
   if(current_user.id == @products_all.owner_uid)
      @products_all.is_active = 0
   end
   @products_all.save
   respond_to do |format|
      format.json { render json: @products_all }
   end
end
def unhide
   product_id = params[:id]
   @products_all = Product.find(product_id)
   if(current_user.id == @products_all.owner_uid)
      @products_all.is_active = 1
   end
   @products_all.save
   respond_to do |format|
      format.json { render json: @products_all }
   end
end


end
