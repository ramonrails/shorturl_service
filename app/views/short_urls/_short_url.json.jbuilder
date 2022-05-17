json.extract! short_url, :id, :url, :shortcode, :last_accessed_at, :counts, :created_at, :updated_at
json.url short_url_url(short_url, format: :json)
