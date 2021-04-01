json.extract! recharge, :id, :amount, :operator, :user_id, :created_at, :updated_at
json.url recharge_url(recharge, format: :json)
