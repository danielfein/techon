json.array!(@validate_facebooks) do |validate_facebook|
  json.extract! validate_facebook, :id, :uid, :before, :url, :url_id
  json.url validate_facebook_url(validate_facebook, format: :json)
end
