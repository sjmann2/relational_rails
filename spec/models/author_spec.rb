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
  end
end