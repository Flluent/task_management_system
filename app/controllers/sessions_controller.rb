class SessionsController < ApplicationController
  def new
    # Здесь Леша напишет код для формы для входа
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "Вы вошли в систему!"
    else
      flash[:alert] = "Неверное имя пользователя или пароль"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Вы вышли из системы!"
  end
end
