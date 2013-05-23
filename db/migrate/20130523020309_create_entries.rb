class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :feed
      t.string :hash
      t.text :permalink
      t.string :title
      t.string :author
      t.text :content

      t.index :hash

      t.timestamps
    end
  end
end
