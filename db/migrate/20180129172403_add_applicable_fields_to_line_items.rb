class AddApplicableFieldsToLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :quantity, :integer
    add_column :line_items, :amount, :decimal
  end
end
