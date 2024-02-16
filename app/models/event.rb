class Event < ApplicationRecord
  validates :event_name, presence: true
  validates :event_category, presence: true
  validates :event_date, presence: true
  validates :event_start_time, presence: true
  validates :event_end_time, presence: true
  validates :ticket_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :number_of_seats_left, presence: true, numericality: { greater_than_or_equal_to: 0 }


  belongs_to :room
  has_many :reviews, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :users
end
