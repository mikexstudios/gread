class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :hash
      t.string :title
      t.text :url

      t.index :hash

      t.timestamps
    end
  end
end
