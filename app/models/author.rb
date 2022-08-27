class Author < ApplicationRecord
  has_many :books, :dependent => :destroy

  def book_count
    self.books.count
  end

  def self.by_created_at
    Author.order(created_at: :asc)
  end
end