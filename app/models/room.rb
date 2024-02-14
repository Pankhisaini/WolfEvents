class Room < ApplicationRecord
  validates :room_location, presence: true,uniqueness: true
  validates :room_capacity, presence: true, numericality: { greater_than_or_equal_to: 1}

  has_many :tickets, dependent: :destroy
  has_many :events, dependent: :destroy

end
