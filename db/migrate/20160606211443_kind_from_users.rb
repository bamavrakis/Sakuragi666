class KindFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :kind
  end
end
