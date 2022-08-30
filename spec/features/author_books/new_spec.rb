require 'rails_helper'

RSpec.describe 'the book creation' do
  before :each do
    @author = Author.create!(name: "Ursula K. Le Guin" , currently_alive: false, age_when_first_published: 33)
    @book = @author.books.create!(name: "The Left Hand of Darkness", length: 312, in_print: true)
  end

  it 'links to the new page from the author books index' do
    visit "/authors/#{@author.id}/books"

    click_button("Create Book")

    expect(current_path).to eq("/authors/#{@author.id}/books/new")
  end

  it 'can create a new book' do
    visit "/authors/#{@author.id}/books/new"

    fill_in('Name', with: "The Dispossessed")
    fill_in('Length', with: 284)
    
    choose('Out of print')
    click_button('Create Book')

    expect(current_path).to eq("/authors/#{@author.id}/books")
    expect(page).to have_content('The Dispossessed')
    expect(page).to have_content('284')
    expect(page).to have_content('false')
  end
end