json.extract! profile, :id, :name, :last_name, :address, :document, :type_document, :phone, :state, :city, :gender, :age, :date_of_birth, :created_at, :updated_at
json.url profile_url(profile, format: :json)
