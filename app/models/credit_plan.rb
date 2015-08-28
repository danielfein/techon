class CreditPlan < ActiveRecord::Base
  include Payola::Sellable

  def redirect_path(sale)

     # you can return any path here, possibly referencing the given subscription
     '/charges/new?#{sale.guid}'
   end
end
