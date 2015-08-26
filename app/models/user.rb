class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
     :omniauthable, :omniauth_providers => [:twitter,:facebook,:instagram]

     def self.from_omniauth( _auth )
        # abort(_auth.inspect)
        # abort(_auth.credentials.token.inspect)
         where( provider: _auth.provider, uid: _auth.uid ).first_or_create do | user |
           user.password = Devise.friendly_token[0,20]
           user.email = "#{_auth.info.name}@#{_auth.provider}.com"
           user.name = _auth.info.name
           user.nickname = _auth.info.nickname
          #  user.company = "#{ _auth.info.name }/#{_auth.provider}"
          #  user.profile_image_url = _auth.info.image
          #  user.is_social = true
           user.twitter_link = _auth.info.Twitter
           if(_auth.provider == "facebook")
    user.facebook_token = _auth.credentials.token
         elsif(_auth.provider == "twitter")
            user.twitter_token = _auth.credentials.token
          elsif(_auth.provider == "instagram")
                   user.instagram_token = _auth.credentials.token
      end

         end
       end
end
