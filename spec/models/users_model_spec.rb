require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(email: 'test@example.com', password: 'password', name: 'Test User', phone_number: '1234567890', address: '123 Test St', credit_card_information: '1234567890123456')
    expect(user).to be_valid
  end

  describe "associations" do
    it "has many tickets" do
      association = described_class.reflect_on_association(:tickets)
      expect(association.macro).to eq :has_many
    end

    it "has many events" do
      association = described_class.reflect_on_association(:events)
      expect(association.macro).to eq :has_many
    end

    it "has many reviews" do
      association = described_class.reflect_on_association(:reviews)
      expect(association.macro).to eq :has_many
    end
  end

  describe "defaults" do
    it "sets default value for is_admin to 0" do
      user = User.create(
        email: 'test@example.com',
        password: 'password',
        name: 'Test User',
        phone_number: '1234567890',
        address: '123 Test St',
        credit_card_information: '1234567890123456'
      )
      expect(user.is_admin).to eq false
    end
  end
end