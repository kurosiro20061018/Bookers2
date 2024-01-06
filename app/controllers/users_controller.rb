class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
  @user = User.find(params[:id])
  puts @user.inspect
  @books = @user.books
  @book = Book.new
  end


  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfullyユーザー情報を更新しました"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "successfullyユーザー情報の更新に失敗しました"
      render :edit
    end
  end

 before_action :set_user, only: [:show, :edit, :update, :destroy]

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
