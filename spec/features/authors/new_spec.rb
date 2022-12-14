require 'rails_helper'

RSpec.describe 'the author creation' do
  it 'links to the new page from the author index' do
    visit "/authors"

    click_button("New Author")

    expect(current_path).to eq("/authors/new")
  end

  it 'can create a new author' do
    visit '/authors/new'

    fill_in('Name', with: 'Charlotte Bronte')
    fill_in('Age when first published', with: 20)
    choose('Currently alive')
    click_button('Create Author')
    
    expect(current_path).to eq('/authors')
    expect(page).to have_content('Charlotte Bronte')
  end
end