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
       
        expect(@carmen_maria_machado.name).to appear_before(@leslie_feinberg.name)
        expect(@leslie_feinberg.name).to appear_before(@jane_austen.name)
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

        click_button "All Books"

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
        click_button "All Authors"
        
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

    it 'shows the count of books next to each author' do
      visit "/authors"

      click_link("Sort authors by number of books")

      expect(page).to have_content("3")
      expect(page).to have_content("2")
      expect(page).to have_content("1")
    end
  end

  describe 'it links to the author show page' do
    it 'has a link to all books by that author' do
      author = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
      book_1 = author.books.create!(name: "Sense and Sensibility", length: 402, in_print: true)
      book_2 = author.books.create!(name: "Pride and Prejudice", length: 387, in_print: true)

      visit "/authors"

      click_link("All Books by #{author.name}")

      expect(current_path).to eq("/authors/#{author.id}/books")
    end
  end

  describe 'when I visit an index page I see a text box to filter results by keyword' do
    describe 'when I type a keyword that is an exact match of one or more of my records' do
      describe 'I press the search button and only see records that are an exact match' do
        it 'filters results by keyword' do
          jane_austen = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
          leslie_feinberg = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
          carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)           

          visit "/authors"
          expect(page).to have_content("Jane Austen")
          expect(page).to have_content("Leslie Feinberg")
          expect(page).to have_content("Carmen Maria Machado")

          fill_in("Search", with: "Leslie Feinberg")
          click_on("Search Authors")

          expect(current_path).to eq("/authors")
          expect(page).to have_content("Leslie Feinberg")
          expect(page).to_not have_content("Jane Austen")
          expect(page).to_not have_content("Carmen Maria Machado")
        end
      end
    end
  end
end