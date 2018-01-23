class RenameNameToTitleForLineItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :line_items, :product_name, :product_title
  end
end
