require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, user: user) }

  # Убедитесь, что у вас есть метод для получения текущего пользователя
  before do
    # Возможная имитация метода, если он необходим для проверки доступа
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @tasks' do
      get :index
      expect(assigns(:tasks)).to include(task)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: task.id }
      expect(response).to be_successful
    end

    it 'assigns the requested task to @task' do
      get :show, params: { id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Task to @task' do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        { title: 'New Task', description: 'Task description', status: 'open', category: 'general', priority: 'high' }
      end

      it 'creates a new Task' do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it 'redirects to the tasks index' do
        post :create, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { title: '', description: 'Task description' } }

      it 'does not create a new Task' do
        expect {
          post :create, params: { task: invalid_attributes }
        }.to_not change(Task, :count)
      end

      it 'redirects to the new task form' do
        post :create, params: { task: invalid_attributes }
        expect(response).to redirect_to(new_task_path)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested task to @task' do
      get :edit, params: { id: task.id }
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { title: 'Updated Task' } }

      it 'updates the requested task' do
        patch :update, params: { id: task.id, task: new_attributes }
        task.reload
        expect(task.title).to eq('Updated Task')
      end

      it 'redirects to the tasks index' do
        patch :update, params: { id: task.id, task: new_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        patch :update, params: { id: task.id, task: { title: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:invalid_attributes) { { title: '', description: 'Task description' } }
    it 'does not create a new Task' do
      expect {
        post :create, params: { task: invalid_attributes }
      }.to_not change(Task, :count)
    end

    it 'sets an alert message' do
      post :create, params: { task: invalid_attributes }
      expect(flash[:alert]).to eq('Что-то пошло не так: Title can\'t be blank')
    end
  end
end
