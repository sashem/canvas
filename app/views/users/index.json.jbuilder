json.array!(@users) do |user|
  json.extract! user, :username, :password, :role
  json.url user_url(user, format: :json)
end