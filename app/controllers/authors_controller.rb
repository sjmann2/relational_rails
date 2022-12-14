class AuthorsController < ApplicationController
  def index
    if params[:search]
      @authors = Author.search_authors(params[:search])
    else
      @authors = Author.by_created_at
    end
  end

  def show
    @author = Author.find(params[:id])
  end

  def new  
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    author = Author.find(params[:id])
    author.update(author_params)
    redirect_to "/authors/#{author.id}"
  end

  def create
    author = Author.create!(author_params)
    redirect_to '/authors'
  end

  def destroy
    author = Author.find(params[:id])
    author.destroy
    redirect_to '/authors'
  end

  private
  def author_params
    params.permit(:name, :currently_alive, :age_when_first_published)
  end
end