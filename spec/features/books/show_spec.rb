require 'rails_helper'

RSpec.describe 'the books show page' do
  describe 'attributes' do
    before :each do
      @author = Artist.create!(name: "Jane Austen", currently_alive: false)
      @book = Book.create!(name: "Pride and Prejudice", id: 1, length: 324, in_print: true)
    end
    
    it 'displays the book name' do
      visit "/books/#{@book.id}"

      expect()
    end

    it 'displays the book length'

    it 'displays the book author'

    it 'displays whether or not the book is in print'

    it 'displays the book id'

  end
end