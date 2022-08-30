require 'rails_helper'

RSpec.describe 'the books index page' do
  describe 'attributes' do
    before :each do
      @author = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
      @book = @author.books.create!(name: "Pride and Prejudice", length: 324, in_print: true)
      @book_2 = @author.books.create!(name: "Sense and Sensibility", length: 402, in_print: true)
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
        @author = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @book = @author.books.create!(name: "Pride and Prejudice", length: 324, in_print: true)
        @book_2 = @author.books.create!(name: "Sense and Sensibility", length: 402, in_print: true)
      end

      it 'links to book index' do
        visit "/books"

        click_button "All Books"

        expect(current_path).to eq("/books")
      end
    end
  end

  describe 'when I visit any page on the site' do
    describe 'I see a link at the top of the page that takes me to the author index' do
      before :each do
        @author = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @book = @author.books.create!(name: "Pride and Prejudice", length: 324, in_print: true)
        @book_2 = @author.books.create!(name: "Sense and Sensibility", length: 402, in_print: true)
      end

      it 'links to author index' do
        visit "/books"
        click_button "All Authors"

        expect(current_path).to eq("/authors")
      end
    end
  end

  describe 'book index only shows true records' do
    before :each do
      @author_1 = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
      @book_1 = @author_1.books.create!(name: "Pride and Prejudice", length: 324, in_print: true)
      @author_2 = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
      @book_2 = @author_2.books.create!(name: "Stone Butch Blues", length: 300, in_print: false)
    end

    it 'lists only books that are in print' do
      visit "/books"

      expect(page).to have_content(@book_1.name)
      expect(page).to_not have_content(@book_2.name)
    end
  end

  describe 'when I visit an index page I see a text box to filter results by keyword' do
    describe 'when I type a keyword that is an exact match of one or more of my records' do
      describe "I press the search button and only see records that are an exact match" do
        it 'filters results by keyword' do
          author_1 = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
          book_1 = author_1.books.create!(name: "Pride and Prejudice", length: 324, in_print: true)
          author_2 = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
          book_2 = author_2.books.create!(name: "Stone Butch Blues", length: 300, in_print: true)

          visit "/books"
          
          expect(page).to have_content("Pride and Prejudice")
          expect(page).to have_content("Stone Butch Blues")

          fill_in("Search", with: "Pride and Prejudice")
          click_on("Search Books")

          expect(current_path).to eq("/books")
          expect(page).to have_content("Pride and Prejudice")
          expect(page).to_not have_content("Stone Butch Blues")
        end
      end
    end
  end
end