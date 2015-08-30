class CallbacksController < Devise::OmniauthCallbacksController
   before_action :bind_account!, :only => [:twitter, :facebook, :instagram]
   def twitter
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
         sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
         set_flash_message(:notice, :success, :kind => 'Twitter') if is_navigational_format?
      else
         session['devise.twitter_data'] = request.env['omniauth.auth']
         redirect_to new_user_registration_url
      end
   end

   def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
   end

   def instagram
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
   end

   private
   def bind_account!
      if(current_user)
         current_user.bind_account(request.env['omniauth.auth'])
         redirect_to edit_user_registration_path
      end
   end
end
