json.array!(@user_groups) do |user_group|
  json.extract! user_group, :id, :title, :rate
  json.url user_group_url(user_group, format: :json)
end
