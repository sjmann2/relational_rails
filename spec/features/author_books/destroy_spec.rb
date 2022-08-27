require 'rails_helper'

RSpec.describe 'deleting a book from the index page' do
  before :each do
    @author = Author.create!(name: "Toni Morrison", currently_alive: false, age_when_first_published: 39)
    @book = @author.books.create!(name: "The Bluest Eye", length: 404, in_print: true)
  end

  it 'can delete a book from the index page' do
    visit "/authors/#{@author.id}/books"

    expect(page).to have_content("Toni Morrison")

    click_link("Delete Book")

    expect(current_path).to eq("/books")
    expect(page).to_not have_content("Toni Morrison")
  end
end