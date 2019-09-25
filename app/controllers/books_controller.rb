class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]


  def create
     @book = Book.new(book_params)
    if @book.save
       flash[:notice] ="You have create book successfully."
       redirect_to book_path(@book.id)
    else
       @books = Book.all
       render("books/index")
    end
  end

  def show
    @book = Book.find(params[:id])
  	@books = Book.all
    @user = User.find(@book.user_id)
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render("books/edit")
    end
  end

  private

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end

  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end
end
