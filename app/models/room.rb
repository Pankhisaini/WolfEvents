class Room < ApplicationRecord
  has_many :tickets
  has_many :events
end
