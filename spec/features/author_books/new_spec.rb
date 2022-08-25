# As a visitor
# When I visit a Author Book Index page
# Then I see a link to add a new adoptable book for that author "Create Book"
# When I click the link
# I am taken to '/authors/:author_id/books/new' where I see a form to add a new adoptable book
# When I fill in the form with the book’s attributes:
# And I click the button "Create Book"
# Then a `POST` request is sent to '/authors/:author_id/books',
# a new book object/row is created for that author,
# and I am redirected to the Author Books Index page where I can see the new book listed
require 'rails_helper'

RSpec.describe 'the book creation' do
  before :each do
    @author = Author.create!(name: "Ursula K. Le Guin" , currently_alive: false, age_when_first_published: 33)
    @book = @author.books.create!(name: "The Left Hand of Darkness", length: 312, in_print: true)
  end

  it 'links to the new page from the author books index' do
    visit "/authors/#{@author.id}/books"

    click_link("Create Book")

    expect(current_path).to eq("/authors/#{@author.id}/books/new")
  end

  it 'can create a new book' do
    visit "/authors/#{@author.id}/books/new"

    fill_in('Name', with: "The Dispossessed")
    fill_in('Length', with: 284)
    fill_in('In print', with: true)
    click_button('Create Book')

    expect(current_path).to eq("/authors/#{@author.id}/books")
    expect(page).to have_content('The Dispossessed')
    expect(page).to have_content('284')
    expect(page).to have_content('true')
  end
end