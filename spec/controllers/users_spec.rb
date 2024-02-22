require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(id: 1, email: "admin@gmail.com", password: "12345678", name: "Admin", phone_number: "1234567890", address: "Stovall Dr", credit_card_information: "0000000000000000", is_admin: true) }
  let(:valid_attributes) {
    {
      email: "test@example.com",
      password: "password",
      name: "Test User",
      phone_number: "1234567890",
      address: "123 Test St",
      credit_card_information: "1234567890123456"
    }
  }

  # let(:invalid_attributes) {
  #   {
  #     email: "",
  #     password: "password",
  #     name: "",
  #     phone_number: "123",
  #     address: "",
  #     credit_card_information: "123"
  #   }
  # }

  # let(:admin) {
  #   User.create! valid_attributes.merge(is_admin: true)
  # }

  # let(:user) {
  #   User.create! valid_attributes
  # }

  before do
    # allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe "GET #index" do
    it "redirects non-admin users" do
      get :index
      expect(response).to redirect_to(root_path)
    end

    it "allows admin users" do
      allow(controller).to receive(:current_user).and_return(admin)
      get :index
      expect(response).to be_successful
    end
  end
end

