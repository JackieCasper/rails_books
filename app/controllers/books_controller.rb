class BooksController < ApplicationController
  before_action :require_user
  before_action :logged_in, only: %i[index show new edit]
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all
  end

  def show
    @comments = @book.comments.order(:created_at)
    @book_comment = @book.comments.new(user_id: @current_user.id)
  end

  def new
    @book = Book.new
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)
    if @book.valid?
      @book.save
      redirect_to @book
    else
      puts @book.errors.messages
      flash[:book] = @book.errors.messages
      redirect_back fallback_location: new_book_path
    end
  end

  def edit
    @authors = Author.all
  end

  def update
    if @book.update(book_params)
      redirect_to @book
    else
      flash[:book] = @book.errors.messages
      redirect_back fallback_location: edit_book_path(@book)
    end
  end

  def destroy
    if @book.destroy
      redirect_to books_path
    else
      flash[:error] = 'Could not delete book.'
      redirect_back fallback_location: @book
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :genre, :author_id, :pages)
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
