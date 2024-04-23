json.extract! contact, :id, :names, :alias, :phone, :user_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)
