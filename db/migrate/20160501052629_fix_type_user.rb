class FixTypeUser < ActiveRecord::Migration
  def change
      rename_column :users, :type, :kind
  end
end
