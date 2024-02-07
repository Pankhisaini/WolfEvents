json.extract! user, :id, :email, :password, :name, :phone_number, :address, :credit_card_information, :created_at, :updated_at
json.url user_url(user, format: :json)
