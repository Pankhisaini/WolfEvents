json.extract! event, :id, :event_name, :event_category, :event_date, :event_start_time, :event_end_time, :ticket_price, :number_of_seats_left, :room_id, :created_at, :updated_at
json.url event_url(event, format: :json)
