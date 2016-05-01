class ChangeColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :books, :popularity, 0
  end
end
