require 'rails_helper'

RSpec.describe 'the authors show page' do
  describe 'attributes' do
    before :each do
      @author = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
      @author_2 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
      @book_1 = @author_2.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
      @book_2 = @author_2.books.create!(name: "In the Dream House", length: 321, in_print: true)
    end

    it 'displays the author name' do
      visit "/authors/#{@author.id}"

      expect(page).to have_content(@author.name)
      expect(page).to_not have_content(@author_2.name)
    end

    it 'displays the age of the author when first book was published' do
      visit "/authors/#{@author.id}"

      expect(page).to have_content(@author.age_when_first_published)
    end

    it 'displays whether or not the author is still living' do
      visit "/authors/#{@author.id}"

      expect(page).to have_content(@author.currently_alive)
    end

    it 'displays created at and updated at time stamps' do
      visit "/authors/#{@author.id}"
      
      expect(page).to have_content(@author.created_at)
      expect(page).to have_content(@author.updated_at)
    end

    it 'displays the author id' do
      visit "/authors/#{@author.id}"

      expect(page).to have_content(@author.id)
    end
  end

  describe 'count of number of books' do
    it 'shows the total count of books by the author' do
      author_2 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
      book_1 = author_2.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
      book_2 = author_2.books.create!(name: "In the Dream House", length: 321, in_print: true)

      visit "/authors/#{author_2.id}"

      expect(page).to have_content("Total number of books for Carmen Maria Machado: 2")
    end
  end

  describe 'when I visit author show page' do
    describe 'I see a link to take me to that authors books page' do
      before :each do
        @author = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @author_2 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
        @book_1 = @author_2.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
        @book_2 = @author_2.books.create!(name: "In the Dream House", length: 321, in_print: true)
      end

      it 'links to authors books page' do
        visit "/authors/#{@author.id}"

        click_button "Books by #{@author.name}"

        expect(current_path).to eq("/authors/#{@author.id}/books")
      end
    end
  end

  describe 'when I visit any page on the site' do
    describe 'I see a link at the top of the page that takes me to the book index' do
      before :each do
        @author = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @author_2 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
        @book_1 = @author_2.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
        @book_2 = @author_2.books.create!(name: "In the Dream House", length: 321, in_print: true)
      end

      it 'links to book index' do
        visit "/authors/#{@author.id}"

        click_button "All Books"

        expect(current_path).to eq("/books")
      end
    end
  end

  describe 'when I visit any page on the site' do
    describe 'I see a link at the top of the page that takes me to the author index' do
      before :each do
        @author = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @author_2 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
        @book_1 = @author_2.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
        @book_2 = @author_2.books.create!(name: "In the Dream House", length: 321, in_print: true)
      end

      it 'links to author index' do
        visit "/authors/#{@author.id}"
        click_button "All Authors"

        expect(current_path).to eq("/authors")
      end
    end
  end
end