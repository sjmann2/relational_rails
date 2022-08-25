class AuthorBooksController < ApplicationController
  def index
    @author = Author.find(params[:author_id])
    @books = @author.books
  end

  def new
    @author = Author.find(params[:author_id])
  end

  def create
    @author = Author.find(params[:author_id])
    @book = @author.books.create!(book_params)
    
    redirect_to "/authors/#{@author.id}/books"
  end

  def book_params
    params.permit(:name, :length, :in_print)
  end
end