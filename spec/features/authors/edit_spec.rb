require 'rails_helper'

RSpec.describe 'the author edit' do
  it 'links to the edit page' do
    author = Author.create!(name: "George Orwell", currently_alive: false, age_when_first_published: 30)

    visit "/authors/#{author.id}"
    click_link "Update Author"

    expect(current_path).to eq("/authors/#{author.id}/edit")
  end

  it 'can edit the author' do
    author = Author.create!(name: "George Oreell", currently_alive: true, age_when_first_published: 29)

    visit "/authors/#{author.id}"

    expect(page).to have_content("George Oreell")
    expect(page).to have_content("true")
    expect(page).to have_content("29")

    visit "/authors/#{author.id}/edit"

    fill_in("Name", with: "George Orwell")
    fill_in("Currently alive", with: "false")
    fill_in("Age when first published", with: "30")
    click_button("Update Author")

    expect(current_path).to eq("/authors/#{author.id}")
    expect(page).to have_content("George Orwell")
    expect(page).to have_content("false")
    expect(page).to have_content("30")
  end
end