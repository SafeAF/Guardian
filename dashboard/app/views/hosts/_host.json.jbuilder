json.extract! host, :id, :hostname, :ip, :first_seen, :last_seen, :user_id, :created_at, :updated_at
json.url host_url(host, format: :json)
