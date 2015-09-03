

class TwitterHelper
	attr_accessor :client


	# returning a TwitterClient initialized
	def initialize( _access_token_id, _access_token_secret )
		@client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = '9qZ3YaXDBlzQusECHS7r3AL5z'
		  config.consumer_secret     = 'BX9FtBAELHoDh0VKhMZDzxTDMqWJrrLeVMmPzwOzvcfTvwNoV2'
		  config.access_token        = '3034190534-88YCHJjK8gQac3WWH0Hij0nTu6GvFElSckJtSv9'
		  config.access_token_secret = 'cQiDjH4uGJswZ6rx5Nvt5tPEPgeKYO3cAGFPDvUfzz6GO'
		end
	end


  def find_twitter_user( _key, _options = {} )
    begin
      @client.user("#{ _key }", _options)
    end
  end

   #  def find_twitter_info( _key, _options = {} )
   #    begin
   #      @client.user_timeline
   #    end
   #  end



	#return Twitter Search call
	def search_for( _key, _options = {} )
    begin
      @client.search("#{ _key }", _options)

rescue Twitter::Error::InternalServerError => error

rescue Twitter::Error::Forbidden => error

rescue Twitter::Error::NotFound => error

rescue Twitter::Error::ServiceUnavailable => error

rescue Twitter::Error::NotAcceptable => error

rescue Twitter::Error::TooManyRequests => error

rescue Twitter::Error => error

rescue => error
return Twitter.new(500, "Unknow Twitter error : #{error.to_s}", "twitter")

end

	end
end
