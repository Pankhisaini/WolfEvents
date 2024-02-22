require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do
    User.create(
      email: "admin@gmail.com",
      password: "12345678",
      name: "Admin",
      phone_number: "1234567890",
      address: "Stovall Dr",
      credit_card_information: "0000000000000000",
      is_admin: true
    )
  end

  before do
    session[:user_id] = user.id
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end
end
