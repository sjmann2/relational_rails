require 'rails_helper'

RSpec.describe 'the author books index page' do
  describe 'attributes' do
    before :each do
      @author_1 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
      @book_1 = @author_1.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
      @book_2 = @author_1.books.create!(name: "In the Dream House", length: 321, in_print: true)
      @author_2 = Author.create!(name: "Jane Austen", currently_alive: false,  age_when_first_published: 21)
      @book_3 = @author_2.books.create!(name: "Sense and Sensibility", length: 402, in_print: true)
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
    
  describe 'when I visit any page on the site' do
    describe 'I see a link at the top of the page that takes me to the book index' do
      before :each do
        @author_1 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
        @book_1 = @author_1.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
        @book_2 = @author_1.books.create!(name: "In the Dream House", length: 321, in_print: true)
      end

      it 'links to book index' do
        visit "/authors/#{@author_1.id}/books"
        click_link "All Books"

        expect(current_path).to eq("/books")
      end
    end
  end

  describe 'when I visit any page on the site' do
    describe 'I see a link at the top of the page that takes me to the author index' do
      before :each do
        @author_1 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 21)
        @book_1 = @author_1.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
        @book_2 = @author_1.books.create!(name: "In the Dream House", length: 321, in_print: true)
      end

      it 'links to author index' do
        visit "/authors/#{@author_1.id}/books"
        click_link "All Authors"

        expect(current_path).to eq("/authors")
      end
    end
  end
  
  describe 'the index page has a link to sort books in alphabetical order' do
    before :each do
      @author_1 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
      @book_2 = @author_1.books.create!(name: "In the Dream House", length: 321, in_print: true)
      @book_1 = @author_1.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
      @book_3 = @author_1.books.create!(name: "The Low Low Woods", length: 125, in_print: true )
    end

    it 'has a link to sort books alphabetically' do
      visit "/authors/#{@author_1.id}/books"
      click_link("Sort Books Alphabetically")
      
      expect(current_path).to eq("/authors/#{@author_1.id}/books")
    end

    it 'displays books alphabetically by name' do
      visit "/authors/#{@author_1.id}/books"

      expect(@book_1.name).to_not appear_before(@book_2.name)
      expect(@book_3.name).to_not appear_before(@book_1.name)

      click_link("Sort Books Alphabetically")

      expect(@book_1.name).to appear_before(@book_2.name)
      expect(@book_2.name).to appear_before(@book_3.name)
      
      expect(current_path).to eq("/authors/#{@author_1.id}/books")
    end
  end

  describe 'display records over a given threshold' do
    before :each do
      @author_1 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
      @book_1 = @author_1.books.create!(name: "Her Body and Other Parties", length: 302, in_print: true)
      @book_2 = @author_1.books.create!(name: "In the Dream House", length: 225, in_print: true)
      @book_3 = @author_1.books.create!(name: "The Low Low Woods", length: 189, in_print: true)
    end

    it 'returns records based on the number inputted' do
      visit "authors/#{@author_1.id}/books"

      expect(page).to have_content("Her Body and Other Parties")
      expect(page).to have_content("In the Dream House")
      expect(page).to have_content("The Low Low Woods")
      
      fill_in("Length", with: "250")

      click_button("Only return books longer than 'length'")

      expect(current_path).to eq("/authors/#{@author_1.id}/books")
      expect(page).to have_content("Her Body and Other Parties")
      expect(page).to_not have_content("The Low Low Woods")
      expect(page).to_not have_content("In the Dream House")
    end
  end
end