class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.boolean :currently_alive
      t.integer :age_when_first_published

      t.timestamps
    end
  end
end
