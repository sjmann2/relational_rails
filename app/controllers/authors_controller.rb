class AuthorsController < ApplicationController
  def index
    @authors = Author.order(created_at: :desc)
  end

  def show
    @author = Author.find(params[:id])
  end

  def new  
  end

  def create
    author = Author.create!(author_params)
    redirect_to '/authors'
  end

  def author_params
    params.permit(:name)
    params.permit(:currently_alive)
    params.permit(:name)
  end
end