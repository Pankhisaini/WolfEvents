json.extract! room, :id, :room_location, :room_capacity, :created_at, :updated_at
json.url room_url(room, format: :json)
