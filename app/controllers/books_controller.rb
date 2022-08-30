class BooksController < ApplicationController
  def index
    if params[:search]
      @books = Book.search_books(params[:search])
    else
      @books = Book.in_print?
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to "/books/#{book.id}"
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private
  def book_params
    params.permit(:name, :length, :in_print)
  end
end