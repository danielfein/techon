class DashboardController < ApplicationController

#Homepage
def index

   @products = Product.where("owner_uid = #{current_user.id}")

   # abort(@product.inspect)

end



end
