json.extract! ticket, :id, :confirmation_number, :room_id, :event_id, :user_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
