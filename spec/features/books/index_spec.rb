require 'rails_helper'

RSpec.describe 'the books index page' do
  describe 'attributes' do
    before :each do
      @author = Author.create!(name: "Jane Austen", currently_alive: false)
      @book = @author.books.create!(name: "Pride and Prejudice", id: 1, length: 324, in_print: true)
      @book_2 = @author.books.create!(name: "Sense and Sensibility", id: 2, length: 402, in_print: true)
    end

    it 'displays the book name' do
      visit "/books"

      expect(page).to have_content(@book.name)
      expect(page).to have_content(@book_2.name)
    end

    it 'displays the book length' do
      visit "/books"

      expect(page).to have_content(@book.length)
      expect(page).to have_content(@book_2.length)
    end

    it 'displays whether or not the book is in print' do
      visit "/books"

      expect(page).to have_content(@book.in_print)
    end

    it 'displays created at and updated at time stamps' do
      visit "/books"
      
      expect(page).to have_content(@book.created_at)
      expect(page).to have_content(@book.updated_at)
    end

    it 'displays the book id' do
      visit "/books"

      expect(page).to have_content(@book.id)
    end
  end

  describe 'when I visit any page on the site' do
    describe 'I see a link at the top of the page that takes me to the book index' do
      before :each do
        @author = Author.create!(name: "Jane Austen", currently_alive: false)
        @book = @author.books.create!(name: "Pride and Prejudice", id: 1, length: 324, in_print: true)
        @book_2 = @author.books.create!(name: "Sense and Sensibility", id: 2, length: 402, in_print: true)
      end

      it 'links to book index' do
        visit "/books"

        click_link "All Books"

        expect(current_path).to eq("/books")
      end
    end
  end
end