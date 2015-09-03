class User < ActiveRecord::Base
   has_many :identities, :dependent => :destroy
   devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable,
   :omniauthable, :omniauth_providers => [:twitter,:facebook,:instagram]

   def bind_account(_auth)
      #self = current_user
      User.create_identity(_auth, self)

   end

   def self.create_identity(identity_attrs, user)
      return user.identities.where(provider: identity_attrs.provider, provider_id: identity_attrs.uid).first_or_create do | identity |
         # Provider information
         identity.provider = identity_attrs.provider
         identity.provider_id = identity_attrs.uid
         identity.access_token = identity_attrs.credentials.token
         identity.access_token_secret = identity_attrs.credentials.secret
      end
   end

   def self.from_omniauth( _auth )
      # abort(_auth.inspect)
      # abort(_auth.inspect)
      # abort(_auth.credentials.token.inspect)

      user = User.joins(:identities).where(:identities => {:provider_id => _auth.uid, :provider => _auth.provider}).first
      puts _auth.uid.inspect
      puts _auth.provider.inspect
      puts user.inspect

      if user.nil?
         if _auth.info.email.nil?
            email = "#{_auth.info.name.gsub ' ','_'}@#{_auth.provider}.com"
         else
            puts _auth.info.email.inspect
            email = _auth.info.email
         end

         name = _auth.info.name
         nickname = _auth.info.nickname
         twitter_link = _auth.info.Twitter
         password = Devise.friendly_token[0,20]
         user = User.create(:password => password, :email => email, :name => name, :nickname => nickname)
         # puts user.errors.inspect
      end

      puts user.errors.inspect
      create_identity(_auth, user)

      return user

   end
end
