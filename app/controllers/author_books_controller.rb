class AuthorBooksController < ApplicationController
  def index
    @author = Author.find(params[:author_id])
    if params[:length]
      @books = @author.sort_by_length(params[:length])
    else
      @books = @author.books.order(params[:sort])    
    end
  end

  def new
    @author = Author.find(params[:author_id])
  end

  def create
    @author = Author.find(params[:author_id])
    @book = @author.books.create!(book_params)
    
    redirect_to "/authors/#{@author.id}/books"
  end
  
  private
  def book_params
    params.permit(:name, :length, :in_print)
  end
end