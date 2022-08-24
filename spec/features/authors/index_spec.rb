require 'rails_helper'

RSpec.describe 'the authors index page' do
  describe 'attributes' do
    before :each do
      @jane_austen = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
      @leslie_feinberg = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
      @carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31) 
    end

    it 'displays a list of all authors' do
      visit "/authors"

      expect(page).to have_content(@jane_austen.name)
      expect(page).to have_content(@leslie_feinberg.name)
      expect(page).to have_content(@carmen_maria_machado.name)
    end

    it 'displays created at timestamp for each author' do
      visit "/authors"

      expect(page).to have_content(@jane_austen.created_at)
      expect(page).to have_content(@leslie_feinberg.created_at)
      expect(page).to have_content(@carmen_maria_machado.created_at)
    end
    
    xit 'displays a list of authors ordered by most recently created first' do
      #orderly test
      visit "/authors"

      let(:leslie_feinberg) {"Leslie Feinberg"}
    end 
  end
  describe 'when I visit any page on the site' do
    describe 'I see a link at the top of the page that takes me to the book index' do
      before :each do
        @jane_austen = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @leslie_feinberg = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
        @carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31) 
      end

      it 'links to book index' do
        visit "/authors"

        click_link "All Books"

        expect(current_path).to eq("/books")
      end
    end
  end
end