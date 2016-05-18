class AddUploaderToBooks < ActiveRecord::Migration
  def change
    add_column :books, :uploader_id, :integer
  end
end
