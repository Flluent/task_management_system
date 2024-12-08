class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Вы успешно зарегистрировались!'
      redirect_to root_path
    else
      flash[:alert] = 'Ошибка при регистрации. Пожалуйста, попробуйте снова : '.concat(@user.errors.full_messages.to_sentence)
      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
