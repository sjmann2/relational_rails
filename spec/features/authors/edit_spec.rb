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

  # As a visitor
  # When I visit the author index page
  # Next to every author, I see a link to edit that author’s info
  # When I click the link
  # I should be taken to that author’s edit page where I can update its information just like in User Story 14
  describe 'When I visit the author index page' do
    describe 'Next to every author, I see a link to edit that authors info' do
      before :each do
        @jane_austen = Author.create!(name: "Jane Auste", currently_alive: false, age_when_first_published: 21)
        @leslie_feinberg = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
        @carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31) 
      end

      it 'links to the edit page' do
        visit "/authors"
        save_and_open_page
        click_link "Update #{@jane_austen.name}"

        expect(current_path).to eq("/authors/#{@jane_austen.id}/edit")
      end

      xit 'can edit the authors information' do
        visit "/authors"

        expect(page).to have_content("Jane Auste")

        click_link("Update Author")

        expect(current_path).to eq("/authors/#{@jane_austen.id}/edit")

        fill_in("Name", with: "Jane Austen")
        click_button("Update Author")

        expect(current_path).to eq("/authors")
      end
    end
  end
end