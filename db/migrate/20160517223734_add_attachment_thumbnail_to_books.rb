class AddAttachmentThumbnailToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :books, :thumbnail
  end
end
