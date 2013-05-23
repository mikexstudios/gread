class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :feed
      t.string :hid #hash
      t.text :permalink
      t.string :title
      t.string :author
      t.text :content

      t.timestamps
    end

    add_index :entries, :hid
  end
end
