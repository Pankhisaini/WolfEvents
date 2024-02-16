class User < ApplicationRecord
  before_create :set_defaults
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: "Invalid email format" }
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "Phone number must be 10 digits" }
  validates :credit_card_information, presence: true, format: { with: /\A\d{16}\z/, message: "Credit card number must be 16 digits" }
  validates :password, presence: true, on: :create
  validates :name, presence: true
  validates :address, presence: true

  has_many :tickets,dependent: :destroy
  has_many :events
  has_many :reviews, dependent: :destroy

  private

  def set_defaults
    self.is_admin ||= 0 # setting default value for users other than admin
  end
end
