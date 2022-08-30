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
  end
end