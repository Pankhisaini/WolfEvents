class Event < ApplicationRecord
  belongs_to :room
  has_many :reviews
  has_many :tickets
  has_and_belongs_to_many :users
end
