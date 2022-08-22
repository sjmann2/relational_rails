class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :length
      t.boolean :in_print

      t.timestamps
    end
  end
end
