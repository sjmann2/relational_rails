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
    author = Author.create!(name: params[:name], currently_alive: params[:currently_alive], age_when_first_published: params[:age_when_first_published])
    redirect_to '/authors'
  end
end