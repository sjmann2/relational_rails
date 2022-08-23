class AddAgeWhenFirstPublishedToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :age_when_first_published, :integer
  end
end
