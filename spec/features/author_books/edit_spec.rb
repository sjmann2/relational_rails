require 'rails_helper'

RSpec.describe 'the author book edit' do
  describe 'it can edit the book from the author books index page' do
    before :each do
      @author = Author.create!(name: "Toni Morrison", currently_alive: false, age_when_first_published: 39)
      @book = @author.books.create!(name: "The Blues Eye", length: 4, in_print: true)
    end

    it 'links to the edit page' do
      visit "/authors/#{@author.id}/books"

      click_link("Update Book")

      expect(current_path).to eq("/books/#{@book.id}/edit")
    end

    it 'can edit the book' do
      visit "/authors/#{@author.id}/books"

      expect(page).to have_content("The Blues Eye")
      expect(page).to have_content("4")
      expect(page).to have_content("true")

      visit "/books/#{@book.id}/edit"

      fill_in("Name", with: "The Bluest Eye")
      fill_in("Length", with: "244")
      fill_in("In print", with: "false")
      click_button("Update Book")

      expect(current_path).to eq("/books/#{@book.id}")
      expect(page).to have_content("The Bluest Eye")
      expect(page).to have_content("244")
      expect(page).to have_content("false")
    end
  end
end