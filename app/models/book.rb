class Book < ApplicationRecord
  belongs_to :author

  def self.in_print?
    Book.where(in_print: :true)
  end
end