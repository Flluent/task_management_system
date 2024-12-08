class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :delete]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new()
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: 'Задача успешно создана!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Задача успешно обновлена!'
    else
      render :edit
    end
  end

  def delete
    @task.destroy
    redirect_to tasks_path, notice: 'Задача успешно удалена!'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :category, :priority)
  end
end
