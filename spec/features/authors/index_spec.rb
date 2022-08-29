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
      
      expect(page).to have_content("Jane Austen")
      expect(page).to have_content("Leslie Feinberg")
      expect(page).to have_content("Carmen Maria Machado")
    end

    it 'displays created at timestamp for each author' do
      visit "/authors"

      expect(page).to have_content(@jane_austen.created_at)
      expect(page).to have_content(@leslie_feinberg.created_at)
      expect(page).to have_content(@carmen_maria_machado.created_at)
    end
    
    describe 'records are ordered by most recently created first' do
      before :each do
        @jane_austen = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @leslie_feinberg = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
        @carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31) 
      end

      it 'displays a list of authors ordered by most recently created first' do
        visit "/authors"
       
        expect(@jane_austen.name).to appear_before(@leslie_feinberg.name)
        expect(@leslie_feinberg.name).to appear_before(@carmen_maria_machado.name)
      end
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

  describe 'when I visit any page on the site' do
    describe 'I see a link at the top of the page that takes me to the author index' do
      before :each do
        @jane_austen = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @leslie_feinberg = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
        @carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31) 
      end

      it 'links to author index' do
        visit "/authors"
        click_link "All Authors"
        
        expect(current_path).to eq("/authors")
      end
    end
  end

  describe 'I see a link to sort authors by the number of books they have' do
    before :each do
      @jane_austen = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
      @leslie_feinberg = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
      @carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31) 
      @book_1 = @carmen_maria_machado.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
      @book_2 = @carmen_maria_machado.books.create!(name: "In the Dream House", length: 321, in_print: true)
      @book_3 = @carmen_maria_machado.books.create!(name: "The Low Low Woods", length: 189, in_print: true)
      @book_3 = @jane_austen.books.create!(name: "Sense and Sensibility", length: 402, in_print: true)
      @book_4 = @jane_austen.books.create!(name: "Pride and Prejudice", length: 387, in_print: true)
      @book_5 = @leslie_feinberg.books.create!(name: "Stone Butch Blues", length: 300, in_print: false)
    end

    it 'displays a link that sorts authors by number of books' do
      visit "/authors"

      click_link("Sort authors by number of books")

      expect(current_path).to eq("/authors")
    end

    it 'sorts authors by number of books' do
      visit "/authors"

      click_link("Sort authors by number of books")

      expect("Carmen Maria Machado").to appear_before("Jane Austen")
      expect("Jane Austen").to appear_before("Leslie Feinberg")
    end

    it 'shows the count of books next to each author' do
      visit "/authors"

      click_link("Sort authors by number of books")

      expect(page).to have_content("3")
      expect(page).to have_content("2")
      expect(page).to have_content("1")
    end
  end
end