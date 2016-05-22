class AddDownloadLinkToConvertions < ActiveRecord::Migration
  def change
    add_column :convertions, :download_link, :string
  end
end
