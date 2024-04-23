json.extract! deposit, :id, :amount, :bank_origin, :status, :phone, :user_id, :created_at, :updated_at
json.url deposit_url(deposit, format: :json)
