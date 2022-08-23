require 'rails_helper'

RSpec.describe 'the books show page' do
  describe 'attributes' do
    before :each do
      @author = Author.create!(name: "Jane Austen", currently_alive: false)
      @book = @author.books.create!(name: "Pride and Prejudice", id: 1, length: 324, in_print: true)
      @book_2 = @author.books.create!(name: "Sense and Sensibility", id: 2, length: 402, in_print: true)
    end
    
    it 'displays the book name' do
      visit "/books/#{@book.id}"

      expect(page).to have_content(@book.name)
      expect(page).to_not have_content(@book_2.name)
    end

    it 'displays the book length' do
      visit "/books/#{@book.id}"

      expect(page).to have_content(@book.length)
    end

    it 'displays the author of the book' do
      visit "/books/#{@book.id}"

      expect(page).to have_content(@author.name)
    end

    it 'displays whether or not the book is in print' do
      visit "/books/#{@book.id}"

      expect(page).to have_content(@book.in_print)
    end
  end
end