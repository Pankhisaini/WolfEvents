json.extract! review, :id, :rating, :feedback, :user_id, :event_id, :created_at, :updated_at
json.url review_url(review, format: :json)
