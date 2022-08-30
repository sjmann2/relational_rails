class Book < ApplicationRecord
  belongs_to :author

  def self.in_print?
    Book.where(in_print: :true)
  end

  def self.search_books(book_name)
    Book.where(name: "#{book_name}")
  end
end