class Author < ApplicationRecord
  has_many :books, :dependent => :destroy

  def book_count
    self.books.count
  end

  def sort_by_length(length)
    self.books.where("length > #{length}")
  end

  def self.by_created_at
    Author.order(created_at: :asc)
  end

  def self.by_book_count
    Author.all.sort_by { |author| -author.book_count }
  end
end