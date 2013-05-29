class RenameEntryPermalinkToUrl < ActiveRecord::Migration
  def change
    rename_column :entries, :permalink, :url
  end
end
