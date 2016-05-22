class AddNameToConvertions < ActiveRecord::Migration
  def change
    add_column :convertions, :name, :string
  end
end
