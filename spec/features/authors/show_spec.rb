require 'rails_helper'

RSpec.describe 'the authors show page' do
  describe 'attributes' do
    before :each do
      @author = Author.create!(name: "Jane Austen", currently_alive: false)
      @author_2 = Author.create!(name: "Leslie Feinberg", currently_alive: false)
    end

    it 'displays the author name' do
      visit "/authors/#{@author.id}"

      expect(page).to have_content(@author.name)
      expect(page).to_not have_content(@author_2.name)
    end

    it 'displays the age of the author when first book was published' do
      visit "/authors/#{@author.id}"

      expect(page).to have_content(@author.age_when_first_published)
    end

    it 'displays whether or not the author is still living' do
      visit "/authors/#{@author.id}"

      expect(page).to have_content(@author.currently_alive)
    end
  end
end