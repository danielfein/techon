class VerifyController < ApplicationController

def index
   @transactions = Transaction.where("sender_uid = #{current_user.id} OR recipient_uid = #{current_user.id}")
end

def verify
   transaction_id = params[:id]
   @transaction = Transaction.find(transaction_id)
   @product = Product.find(@transaction.product_id)
   provider = @transaction.provider_type
   sender = @transaction.sender_uid
   recipient = @transaction.recipient_uid
   @recipient_identities = Identity.where("user_id = #{recipient}")
   @recipient_identities.each do |x|
      if x.provider == provider
         @verifiable_identity = x

      end
   end
   if(@verifiable_identity)
      if(provider == "facebook")
         verify_facebook()
      end
   end
end

# This requires "user_likes" permission from user.

def verify_facebook
   facebook_id = @verifiable_identity.provider_id
   access_token = @verifiable_identity.access_token
   url = 'https://graph.facebook.com/v2.4/'+ facebook_id +'/likes?fields=id,name&access_token='+ access_token
   abort(url.inspect)
   facebook = Nokogiri::HTML(open(url));
   # facebook_parsed = JSON.parse(facebook).values[0]['likes']
   facebook_parsed = JSON.parse(facebook)
   abort(facebook_parsed.inspect)
end

end
