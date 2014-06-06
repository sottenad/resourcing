json.array!(@subscription_types) do |subscription_type|
  json.extract! subscription_type, :id, :subscription_name, :price
  json.url subscription_type_url(subscription_type, format: :json)
end
