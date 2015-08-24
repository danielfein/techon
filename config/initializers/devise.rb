# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|

  config.mailer_sender = 'feinest92@yahoo.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = false

config.allow_unconfirmed_access_for = 2.days
config.confirm_within = 70.days
  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 8..72

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.omniauth :twitter, "9qZ3YaXDBlzQusECHS7r3AL5z", "BX9FtBAELHoDh0VKhMZDzxTDMqWJrrLeVMmPzwOzvcfTvwNoV2"
  config.omniauth :facebook, "1663187720562616", "c408d41dbd521a8946a3020197bff4f9"
  config.omniauth :instagram, "fb379200bad24c53b0fe79700417e0a5", "c94569c942b441e69e44afffdb0662eb"


end
