class AddPermalinkToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :permalink, :string
    add_index :books, :permalink
  end
  def self.down
    remove_column :books, :permalink
  end
end