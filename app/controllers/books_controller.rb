class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
    flash[:notice] = "successfully投稿に成功しました。"
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user

  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = current_user
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @user = current_user
    if @book.update(book_params)
    flash[:notice] = "successfully更新に成功しました。"
    redirect_to book_path(@book)
    else
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:deleted] = "successfully削除に成功しました。"
    redirect_to book
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end

