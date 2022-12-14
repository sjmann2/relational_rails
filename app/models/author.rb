class Author < ApplicationRecord
  has_many :books, :dependent => :destroy

  def book_count
    self.books.count
  end

  def sort_by_length(length)
    self.books.where("length > #{length}")
  end

  def self.by_created_at
    Author.order(created_at: :desc)
  end

  def self.search_authors(author_name)
    Author.where(name: "#{author_name.titleize}")
  end
end