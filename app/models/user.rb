class User < ApplicationRecord
  before_create :set_defaults
  has_secure_password
  validates :email, presence: true, uniqueness: true

  private

  def set_defaults
    self.is_admin ||= 0 #setting default value for users other than admin
  end
end
