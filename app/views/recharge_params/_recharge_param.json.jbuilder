json.extract! recharge_param, :id, :operadora, :amount_min, :amount_max, :multiplos_amount_permit, :created_at, :updated_at
json.url recharge_param_url(recharge_param, format: :json)
