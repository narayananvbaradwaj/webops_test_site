json.array!(@users) do |user|
  json.extract! user, :id, :roll
  json.url user_url(user, format: :json)
end
