require 'rails_helper'

RSpec.describe Author, type: :model do
  it {should have_many :books}

  describe 'instance methods' do
    describe '#book_count' do
      before :each do
        @carmen_maria_machado = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
        @book_1 = @carmen_maria_machado.books.create!(name: "Her Body and Other Parties", length: 380, in_print: true)
        @book_2 = @carmen_maria_machado.books.create!(name: "In the Dream House", length: 321, in_print: true)
      end

      it 'shows a count of number of books associated with the author' do
        expect(@carmen_maria_machado.book_count).to eq(2)
      end
    end

    describe '#sort_by_length' do
      before :each do
        @author_1 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31)
        @book_1 = @author_1.books.create!(name: "Her Body and Other Parties", length: 302, in_print: true)
        @book_2 = @author_1.books.create!(name: "In the Dream House", length: 225, in_print: true)
        @book_3 = @author_1.books.create!(name: "The Low Low Woods", length: 189, in_print: true)
      end

      it 'returns records greater than length specified' do
        expect(@author_1.sort_by_length("250")).to eq([@book_1])
      end
    end

    describe 'class methods' do
      before :each do
        @author_1 = Author.create!(name: "Jane Austen", currently_alive: false, age_when_first_published: 21)
        @author_2 = Author.create!(name: "Leslie Feinberg", currently_alive: false, age_when_first_published: 40)
        @author_3 = Author.create!(name: "Carmen Maria Machado", currently_alive: true, age_when_first_published: 31) 
      end

      describe 'by_created_at' do
        it 'sorts authors by most recently created' do
          expect(Author.by_created_at.to_a).to eq([@author_3, @author_2, @author_1])
        end
      end

      describe 'search_authors' do
        it 'filters results by exact author name' do
          expect(Author.search_authors("Leslie Feinberg")).to eq([@author_2])
        end

        it 'auto-capitalizes author name' do
          expect(Author.search_authors("leslie feinberg")).to eq([@author_2])
        end
      end
    end
  end
end