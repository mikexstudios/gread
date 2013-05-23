class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :hash
      t.string :title
      t.text :url

      t.timestamps
    end

    add_index :feeds, :hash
  end
end
