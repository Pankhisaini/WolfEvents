# require 'rails_helper'
#
# RSpec.describe UsersController, type: :controller do
#   let(:user) do
#     User.create(
#       email: "admin@gmail.com",
#       password: "12345678",
#       name: "Admin",
#       phone_number: "1234567890",
#       address: "Stovall Dr",
#       credit_card_information: "0000000000000000",
#       is_admin: true
#     )
#   end
#
#   before do
#     session[:user_id] = user.id
#   end
#
#   describe "GET #index" do
#     it "returns a successful response" do
#       get :index
#       expect(response).to be_successful
#     end
#   end
# end

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_params) do
    {
      user: {
        email: "new_user@example.com",
        password: "password",
        name: "New User",
        phone_number: "9876543210",
        address: "123 Main St",
        credit_card_information: "1111222233334444"
      }
    }
  end
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
  let(:other_user) { User.create( email: "user@gmail.com",
                                  password: "12345678",
                                  name: "User",
                                  phone_number: "1234567890",
                                  address: "Raleigh",
                                  credit_card_information: "0000000000000000",
                                  is_admin: false ) }
  before do
    session[:user_id] = user.id
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "redirects non-admin users to root_url" do
      user.update(is_admin: false)
      get :index
      expect(response).to redirect_to(root_url)
    end

  end

  describe "GET #show" do


    it "redirects non-admin users to root_url if they try to access another user's show page" do
      user.update(is_admin: false)
      get :show, params: { id: other_user.id }
      expect(response).to redirect_to(root_url)
    end

    it "assigns the requested user as @user" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #new" do
    it "redirects non-admin users to root_url" do
      user.update(is_admin: false)
      get :new
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET #edit" do
    it "redirects non-admin users to root_url if they try to edit another user's profile" do
      user.update(is_admin: false)
      other_user.update(is_admin: false)
      get :edit, params: { id: other_user.id }
      expect(response).to redirect_to(root_url)
    end

    it "allows admin users to edit another user's profile" do
      user.update(is_admin: true)
      get :edit, params: { id: other_user.id }
      expect(response).to be_successful
    end

    it "allows users to edit their own profile" do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      expect {
        post :create, params: user_params
      }.to change(User, :count).by(1)
    end
  end

  describe "PATCH #update" do
    it "updates the user's profile" do
      patch :update, params: { id: user.id, user: { name: "Updated Name" } }
      user.reload
      expect(user.name).to eq("Updated Name")
    end
    it "redirects non-admin users to profile_path if they try to update another user's profile" do
      user.update(is_admin: false)
      patch :update, params: { id: user.id, user: { name: "Updated Name" } }
      expect(response).to redirect_to(profile_path)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end
  end
end
