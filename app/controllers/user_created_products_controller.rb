class UserCreatedProductsController < ApplicationController

   def index

      @products_by_user = Product.where("owner_uid = #{current_user.id}")

   end

end
