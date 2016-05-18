class BooksTags < ActiveRecord::Migration
  def change
    create_table :books_tags, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :tag, index: true
    end
  end
end
