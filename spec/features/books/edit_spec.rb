# As a visitor
# When I visit a Book Show page
# Then I see a link to update that Book "Update Book"
# When I click the link
# I am taken to '/books/:id/edit' where I see a form to edit the book's attributes:
# When I click the button to submit the form "Update Book"
# Then a `PATCH` request is sent to '/books/:id',
# the book's data is updated,
# and I am redirected to the Book Show page where I see the Book's updated information
require 'rails_helper'

RSpec.describe 'the book edit' do
  before :each do
    @author = Author.create!(name: "Toni Morrison", currently_alive: false, age_when_first_published: 39)
    @book = @author.books.create!(name: "The Blues Eye", length: 4, in_print: false)
  end

  it 'links to the edit page' do
    visit "/books/#{@book.id}"

    click_link("Update Book")
    expect(current_path).to eq("/books/#{@book.id}/edit")
  end

  it 'can edit the book' do
    visit "/books/#{@book.id}"

    expect(page).to have_content("The Blues Eye")
    expect(page).to have_content("4")
    expect(page).to have_content("false")
    
    visit "/books/#{@book.id}/edit"

    fill_in("Name", with: "The Bluest Eye")
    fill_in("Length", with: "244")
    fill_in("In print", with: "true")
    click_button("Update Book")

    expect(current_path).to eq("/books/#{@book.id}")
    expect(page).to have_content("The Bluest Eye")
    expect(page).to have_content("244")
    expect(page).to have_content("true")
  end
end