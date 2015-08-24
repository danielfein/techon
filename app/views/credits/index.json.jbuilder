json.array!(@credits) do |credit|
  json.extract! credit, :id, :uid, :balance
  json.url credit_url(credit, format: :json)
end
