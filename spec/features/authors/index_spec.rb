require 'rails_helper'

RSpec.describe 'the authors index page' do
  describe 'attributes' do
    before :each do
      @author = Author.create!(name: "Jane Austen", currently_alive: false)
      @author_2 = Author.create!(name: "Leslie Feinberg", currently_alive: false)
    end

    it 'displays a list of all authors' do
      visit "/authors"

      expect(page).to have_content(@author.name)
      expect(page).to have_content(@author_2.name)
    end
  end
end