json.array!(@validate_twitters) do |validate_twitter|
  json.extract! validate_twitter, :id
  json.url validate_twitter_url(validate_twitter, format: :json)
end
