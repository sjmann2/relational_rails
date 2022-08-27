require 'rails_helper'

RSpec.describe 'destroying an author' do
  describe 'delete an author from the show page' do
    before :each do
      @author = Author.create!(name: "Toni Morrison", currently_alive: false, age_when_first_published: 39)
      @book = @author.books.create!(name: "The Bluest Eye", length: 404, in_print: true)
    end

    it 'can delete the author from the show page' do
      visit "/authors/#{@author.id}"

      click_link("Delete Author")

      expect(current_path).to eq("/authors")

      expect(page).to_not have_content("Toni Morrison")
    end

    it 'can delete the authors books along with the author' do
      visit "/authors/#{@author.id}"

      click_link("Delete Author")

      visit "/books"

      expect(page).to_not have_content("The Bluest Eye")
    end
  end


# As a visitor
# When I visit the author index page
# Next to every author, I see a link to delete that author
# When I click the link
# I am returned to the Author Index Page where I no longer see that author
  describe 'deleting an author from the index page' do
    before :each do
      @author = Author.create!(name: "Toni Morrison", currently_alive: false, age_when_first_published: 39)
      @book = @author.books.create!(name: "The Bluest Eye", length: 404, in_print: true)
    end

    it 'can delete the author from the index page' do
      visit '/authors'
      
      expect(page).to have_content("Toni Morrison")

      click_link "Delete #{@author.name}"

      expect(current_path).to eq("/authors")
      expect(page).to_not have_content("Toni Morrison")
    end
  end
end
