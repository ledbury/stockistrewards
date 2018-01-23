class CreateJoinTableProductTypeStockist < ActiveRecord::Migration[5.1]
  def change
    create_join_table :product_types, :stockists   do |t|
      t.index [:product_type_id, :stockist_id]
    end
  end
end
