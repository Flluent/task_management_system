require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { User.create(username: "testuser", password: "password", password_confirmation: "password") }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @users" do
      get :index
      expect(assigns(:users)).to eq([ user ])
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post :create, params: { user: { username: "newuser", password: "password", password_confirmation: "password" } }
        }.to change(User, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { user: { username: "newuser", password: "password", password_confirmation: "password" } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a user" do
        expect {
          post :create, params: { user: { username: "", password: "password", password_confirmation: "password" } }
        }.to change(User, :count).by(0)
      end

      it 'redirects to the signup page' do
        post :create, params: { user: { username: "", password: "", password_confirmation: "" } }
        expect(response).to redirect_to(signup_path)

        expect(flash[:alert]).to include("Ошибка при регистрации")
      end
    end
  end
end
