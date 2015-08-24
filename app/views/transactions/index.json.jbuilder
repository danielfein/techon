json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :sender_uid, :recipient_uid, :payment_amount, :date_occured, :provider_type
  json.url transaction_url(transaction, format: :json)
end
