require 'rails_helper'

RSpec.describe 'the author books index page' do
  describe 'attributes' do
    before :each do
      @author_1 = Author.create!(name: "Carmen Maria Machado", currently_alive: true)
      @book_1 = @author_1.books.create!(name: "Her Body and Other Parties", id: 1, length: 380, in_print: true)
      @book_2 = @author_1.books.create!(name: "In the Dream House", id: 2, length: 321, in_print: true)
      @author_2 = Author.create!(name: "Jane Austen", currently_alive: false)
      @book_3 = @author_2.books.create!(name: "Sense and Sensibility", id: 4, length: 402, in_print: true)
    end

    it 'displays the name of the book' do
      visit "authors/#{@author_1.id}/books"

      expect(page).to have_content(@book_1.name)
      expect(page).to have_content(@book_2.name)
      expect(page).to_not have_content(@book_3.name)
    end

    it 'displays the length of the book' do
      visit "authors/#{@author_1.id}/books"

      expect(page).to have_content(@book_1.length)
      expect(page).to have_content(@book_2.length)
    end

    it 'displays whether or not the book is in print' do
      visit "authors/#{@author_1.id}/books"

      expect(page).to have_content(@book_1.in_print)
      expect(page).to have_content(@book_2.in_print)
    end

    it 'displays created at and updated at time stamps' do
      visit "/authors/#{@author_1.id}/books"
      
      expect(page).to have_content(@book_1.created_at)
      expect(page).to have_content(@book_1.updated_at)
      expect(page).to have_content(@book_2.created_at)
      expect(page).to have_content(@book_2.updated_at)
    end

    it 'displays the author id' do
      visit "/authors/#{@author_1.id}/books"

      expect(page).to have_content(@book_1.id)
      expect(page).to have_content(@book_2.id)
    end
  end
end