class CreateConvertions < ActiveRecord::Migration
  def change
    create_table :convertions do |t|
      t.belongs_to :user, index: true
      t.string :convertion_url
      t.timestamps null: false
    end
  end
end
