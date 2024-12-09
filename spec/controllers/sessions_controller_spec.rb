require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user, username: "testuser", password: "password") }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'logs the user in and redirects to the tasks index' do
        post :create, params: { username: user.username, password: "password" }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(tasks_path)
        expect(flash[:notice]).to eq("Вы вошли в систему!")
      end
    end

    context 'with invalid credentials' do
      it 'does not log the user in and redirects to the login page' do
        post :create, params: { username: user.username, password: "wrongpassword" }
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("Неверное имя пользователя или пароль")
      end

      it 'redirects to the login page if the user does not exist' do
        post :create, params: { username: "nonexistentuser", password: "password" }
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("Неверное имя пользователя или пароль")
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs the user out and redirects to the root path' do
      session[:user_id] = user.id  # Имитация того, что пользователь уже залогинен
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Вы вышли из системы!")
    end
  end
end
