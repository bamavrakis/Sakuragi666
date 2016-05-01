class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :default => ""
    add_column :users, :last_name, :string, :default => ""
    add_column :users, :type, :string, :default => "user"
  end
end
