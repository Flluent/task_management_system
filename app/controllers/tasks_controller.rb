class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [ :show, :edit, :update, :delete ]

  def index
    @tasks = Task.all

    # Сортировка по параметрам с безопасной белым списком
    valid_sort_columns = %w[title user_id status description category priority editable]
    sort_column = valid_sort_columns.include?(params[:sort]) ? params[:sort] : "created_at"
    sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"

    if sort_column == 'editable'
      # Преобразуем boolean в строку для сортировки
      @tasks = @tasks.order(Arel.sql("CASE WHEN editable THEN 'Да' ELSE 'Нет' END #{sort_direction}"))
    else
      @tasks = @tasks.order(sort_column => sort_direction)
    end

    # Пагинация
    @tasks = @tasks.page(params[:page]).per(6)
  end


  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: "Задача успешно создана!"
    else
      flash[:alert] = "Что-то пошло не так: ".concat(@task.errors.full_messages.to_sentence)
      redirect_to tasks_new_path
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Задача успешно обновлена!"
    else
      render :edit
    end
  end

  def delete
    @task.destroy
    redirect_to tasks_path, notice: "Задача успешно удалена!"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def sort_direction(column)
    if column == params[:sort]
      params[:direction] == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :category, :priority, :editable)
  end
end
