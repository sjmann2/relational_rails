require 'rails_helper'

RSpec.describe Book, type: :model do
  it {should belong_to :author}

  describe 'class methods' do
    describe 'in_print?' do
      it 'only displays books that are in print' do
        carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
        book_1 = carmen_maria_machado.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
        book_2 = carmen_maria_machado.books.create!(name: "In the Dream House", length: 321, in_print: false)

        expect(book_1.in_print?).to eq(true)
        expect(book_2.in_print?).to eq(false)
      end
    end

    describe 'search_books' do
      before :each do
        @author_1 = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @book_1 = @author_1.books.create!(name: "Pride and Prejudice", id: 1, length: 324, in_print: true)
        @author_2 = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
        @book_2 = @author_2.books.create!(name: "Stone Butch Blues", length: 300, in_print: false)
      end

      it 'filters results by exact book name' do
        expect(Book.search_books("Stone Butch Blues")).to eq([@book_2])
      end
    end
  end
end